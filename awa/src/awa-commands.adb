-----------------------------------------------------------------------
--  awa-commands -- AWA commands for server or admin tool
--  Copyright (C) 2019, 2020 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with Ada.IO_Exceptions;
with Ada.Unchecked_Deallocation;
with Util.Log.Loggers;
with AWA.Applications.Configs;
with Keystore.Passwords.Input;
with Keystore.Passwords.Files;
with Keystore.Passwords.Unsafe;
with Keystore.Passwords.Cmds;
package body AWA.Commands is

   use type Keystore.Passwords.Provider_Access;
   use type Keystore.Header_Slot_Count_Type;
   use type Keystore.Passwords.Keys.Key_Provider_Access;

   Log     : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("AWA.Commands");

   procedure Load_Configuration (Context : in out Context_Type) is
   begin
      begin
         Context.File_Config.Load_Properties (Context.Config_File.all);

      exception
         when Ada.IO_Exceptions.Name_Error =>
            Log.Error ("Cannot read application configuration file {0}",
                       Context.Config_File.all);
      end;
      if Context.File_Config.Exists (GPG_CRYPT_CONFIG) then
         Context.GPG.Set_Encrypt_Command (Context.File_Config.Get (GPG_CRYPT_CONFIG));
      end if;
      if Context.File_Config.Exists (GPG_DECRYPT_CONFIG) then
         Context.GPG.Set_Decrypt_Command (Context.File_Config.Get (GPG_DECRYPT_CONFIG));
      end if;
      if Context.File_Config.Exists (GPG_LIST_CONFIG) then
         Context.GPG.Set_List_Key_Command (Context.File_Config.Get (GPG_LIST_CONFIG));
      end if;
      Context.Config.Randomize := not Context.Zero;
   end Load_Configuration;

   --  ------------------------------
   --  Returns True if a keystore is used by the configuration and must be unlocked.
   --  ------------------------------
   function Use_Keystore (Context : in Context_Type) return Boolean is
   begin
      if Context.Wallet_File'Length > 0 then
         return True;
      end if;

      return Context.File_Config.Exists ("keystore.path");
   end Use_Keystore;

   --  ------------------------------
   --  Open the keystore file using the password password.
   --  ------------------------------
   procedure Open_Keystore (Context    : in out Context_Type) is
   begin
      Setup_Password_Provider (Context);
      Setup_Key_Provider (Context);

      Context.Wallet.Open (Path      => Context.Get_Keystore_Path,
                           Data_Path => Context.Data_Path.all,
                           Config    => Context.Config,
                           Info      => Context.Info);

      if not Context.No_Password_Opt or else Context.Info.Header_Count = 0 then
         if Context.Key_Provider /= null then
            Context.Wallet.Set_Master_Key (Context.Key_Provider.all);
         end if;
         if Context.Provider = null then
            Context.Provider := Keystore.Passwords.Input.Create (-("Enter password: "), False);
         end if;

         Context.Wallet.Unlock (Context.Provider.all, Context.Slot);
      else
         Context.GPG.Load_Secrets (Context.Wallet);

         Context.Wallet.Set_Master_Key (Context.GPG);

         Context.Wallet.Unlock (Context.GPG, Context.Slot);
      end if;

      Keystore.Properties.Initialize (Context.Secure_Config, Context.Wallet'Unchecked_Access);
      AWA.Applications.Configs.Merge (Context.App_Config,
                                      Context.File_Config,
                                      Context.Secure_Config,
                                      "");
   end Open_Keystore;

   --  ------------------------------
   --  Configure the application by loading its configuration file and merging it with
   --  the keystore file if there is one.
   --  ------------------------------
   procedure Configure (Application : in out AWA.Applications.Application'Class;
                        Name        : in String;
                        Context     : in out Context_Type) is
      Path : constant String := AWA.Applications.Configs.Get_Config_Path (Name);
   begin
      begin
         Context.File_Config.Load_Properties (Path);
      exception
         when Ada.IO_Exceptions.Name_Error =>
            null;
      end;

      if Context.Use_Keystore then
         Open_Keystore (Context);
      else
         Context.App_Config := Context.File_Config;
      end if;
      Application.Initialize (Context.App_Config, Context.Factory);
   end Configure;

   --  ------------------------------
   --  Initialize the commands.
   --  ------------------------------
   overriding
   procedure Initialize (Context : in out Context_Type) is
   begin
      GC.Set_Usage (Config => Context.Command_Config,
                    Usage  => "[switchs] command [arguments]",
                    Help   => -("akt - tool to store and protect your sensitive data"));
      GC.Define_Switch (Config => Context.Command_Config,
                        Output => Context.Version'Access,
                        Switch => "-V",
                        Long_Switch => "--version",
                        Help   => -("Print the version"));
      GC.Define_Switch (Config => Context.Command_Config,
                        Output => Context.Verbose'Access,
                        Switch => "-v",
                        Long_Switch => "--verbose",
                        Help   => -("Verbose execution mode"));
      GC.Define_Switch (Config => Context.Command_Config,
                        Output => Context.Debug'Access,
                        Switch => "-vv",
                        Long_Switch => "--debug",
                        Help   => -("Enable debug execution"));
      GC.Define_Switch (Config => Context.Command_Config,
                        Output => Context.Dump'Access,
                        Switch => "-vvv",
                        Long_Switch => "--debug-dump",
                        Help   => -("Enable debug dump execution"));
      GC.Define_Switch (Config => Context.Command_Config,
                        Output => Context.Zero'Access,
                        Switch => "-z",
                        Long_Switch => "--zero",
                        Help   => -("Erase and fill with zeros instead of random values"));
      GC.Define_Switch (Config => Context.Command_Config,
                        Output => Context.Config_File'Access,
                        Switch => "-c:",
                        Long_Switch => "--config=",
                        Argument => "PATH",
                        Help   => -("Defines the path for configuration file"));
      GC.Initialize_Option_Scan (Stop_At_First_Non_Switch => True);

--      Driver.Set_Description (-("akt - tool to store and protect your sensitive data"));
--     Driver.Set_Usage (-("[-V] [-v] [-vv] [-vvv] [-c path] [-t count] [-z] " &
--                          "<command> [<args>]" & ASCII.LF &
--                          "where:" & ASCII.LF &
--                          "  -V           Print the tool version" & ASCII.LF &
--                          "  -v           Verbose execution mode" & ASCII.LF &
--                          "  -vv          Debug execution mode" & ASCII.LF &
--                          "  -vvv         Dump execution mode" & ASCII.LF &
--                          "  -c path      Defines the path for akt " &
--                          "global configuration" & ASCII.LF &
--                          "  -t count     Number of threads for the " &
--                          "encryption/decryption process" & ASCII.LF &
--                          "  -z           Erase and fill with zeros instead of random values"));
--      Driver.Add_Command ("help",
--                          -("print some help"),
--                          Help_Command'Access);
   end Initialize;

   --  ------------------------------
   --  Setup the command before parsing the arguments and executing it.
   --  ------------------------------
   procedure Setup (Config  : in out GC.Command_Line_Configuration;
                    Context : in out Context_Type) is
   begin
      GC.Define_Switch (Config => Config,
                        Output => Context.Wallet_File'Access,
                        Switch => "-k:",
                        Long_Switch => "--keystore=",
                        Argument => "PATH",
                        Help   => -("Defines the path for the keystore file"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Data_Path'Access,
                        Switch => "-d:",
                        Long_Switch => "--data-path=",
                        Argument => "PATH",
                        Help   => -("The directory which contains the keystore data blocks"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Password_File'Access,
                        Long_Switch => "--passfile=",
                        Argument => "PATH",
                        Help   => -("Read the file that contains the password"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Unsafe_Password'Access,
                        Long_Switch => "--passfd=",
                        Argument => "NUM",
                        Help   => -("Read the password from the pipe with"
                          & " the given file descriptor"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Unsafe_Password'Access,
                        Long_Switch => "--passsocket=",
                        Help   => -("The password is passed within the socket connection"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Password_Env'Access,
                        Long_Switch => "--passenv=",
                        Argument => "NAME",
                        Help   => -("Read the environment variable that contains"
                        & " the password (not safe)"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Unsafe_Password'Access,
                        Switch => "-p:",
                        Long_Switch => "--password=",
                        Help   => -("The password is passed within the command line (not safe)"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Password_Askpass'Access,
                        Long_Switch => "--passask",
                        Help   => -("Run the ssh-askpass command to get the password"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Password_Command'Access,
                        Long_Switch => "--passcmd=",
                        Argument => "COMMAND",
                        Help   => -("Run the command to get the password"));
      GC.Define_Switch (Config => Config,
                        Output => Context.Wallet_Key_File'Access,
                        Long_Switch => "--wallet-key-file=",
                        Argument => "PATH",
                        Help   => -("Read the file that contains the wallet keys"));
   end Setup;

   procedure Setup_Password_Provider (Context : in out Context_Type) is
   begin
      if Context.Password_Askpass then
         Context.Provider := Keystore.Passwords.Cmds.Create ("ssh-askpass");
      elsif Context.Password_Command'Length > 0 then
         Context.Provider := Keystore.Passwords.Cmds.Create (Context.Password_Command.all);
      elsif Context.Password_File'Length > 0 then
         Context.Provider := Keystore.Passwords.Files.Create (Context.Password_File.all);
      elsif Context.Password_Command'Length > 0 then
         Context.Provider := Keystore.Passwords.Cmds.Create (Context.Password_Command.all);
      elsif Context.Unsafe_Password'Length > 0 then
         Context.Provider := Keystore.Passwords.Unsafe.Create (Context.Unsafe_Password.all);
      else
         Context.No_Password_Opt := True;
      end if;
      Context.Key_Provider := Keystore.Passwords.Keys.Create (Keystore.DEFAULT_WALLET_KEY);
   end Setup_Password_Provider;

   procedure Setup_Key_Provider (Context : in out Context_Type) is
   begin
      if Context.Wallet_Key_File'Length > 0 then
         Context.Key_Provider := Keystore.Passwords.Files.Create (Context.Wallet_Key_File.all);
      end if;
   end Setup_Key_Provider;

   --  ------------------------------
   --  Get the keystore file path.
   --  ------------------------------
   function Get_Keystore_Path (Context : in out Context_Type) return String is
   begin
      if Context.Wallet_File'Length > 0 then
         Context.First_Arg := 1;
         return Context.Wallet_File.all;
      else
         raise Error with "No keystore path";
      end if;
   end Get_Keystore_Path;

   overriding
   procedure Finalize (Context : in out Context_Type) is
      procedure Free is
        new Ada.Unchecked_Deallocation (Object => Keystore.Passwords.Provider'Class,
                                        Name   => Keystore.Passwords.Provider_Access);
   begin
      GC.Free (Context.Command_Config);
      Free (Context.Provider);
   end Finalize;

end AWA.Commands;
