-----------------------------------------------------------------------
--  AWA.OAuth.Models -- AWA.OAuth.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1095
-----------------------------------------------------------------------
--  Copyright (C) 2020 Stephane Carrez
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
pragma Warnings (Off);
with ADO.Sessions;
with ADO.Objects;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Basic.Lists;
with AWA.Users.Models;
pragma Warnings (On);
package AWA.OAuth.Models is

   pragma Style_Checks ("-mr");

   type Application_Ref is new ADO.Objects.Object_Ref with null record;

   type Callback_Ref is new ADO.Objects.Object_Ref with null record;

   type Session_Ref is new ADO.Objects.Object_Ref with null record;

   --  --------------------
   --  The application that is granted access to the database.
   --  --------------------
   --  Create an object key for Application.
   function Application_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Application from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Application_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Application : constant Application_Ref;
   function "=" (Left, Right : Application_Ref'Class) return Boolean;

   --  Set the application identifier.
   procedure Set_Id (Object : in out Application_Ref;
                     Value  : in ADO.Identifier);

   --  Get the application identifier.
   function Get_Id (Object : in Application_Ref)
                 return ADO.Identifier;

   --  Set the application name.
   procedure Set_Name (Object : in out Application_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Name (Object : in out Application_Ref;
                       Value : in String);

   --  Get the application name.
   function Get_Name (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Name (Object : in Application_Ref)
                 return String;

   --  Set the application secret key.
   procedure Set_Secret_Key (Object : in out Application_Ref;
                             Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Secret_Key (Object : in out Application_Ref;
                             Value : in String);

   --  Get the application secret key.
   function Get_Secret_Key (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Secret_Key (Object : in Application_Ref)
                 return String;

   --  Set the application public identifier.
   procedure Set_Client_Id (Object : in out Application_Ref;
                            Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Client_Id (Object : in out Application_Ref;
                            Value : in String);

   --  Get the application public identifier.
   function Get_Client_Id (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Client_Id (Object : in Application_Ref)
                 return String;
   --  Get the optimistic lock version.
   function Get_Version (Object : in Application_Ref)
                 return Integer;

   --  Set the application create date.
   procedure Set_Create_Date (Object : in out Application_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the application create date.
   function Get_Create_Date (Object : in Application_Ref)
                 return Ada.Calendar.Time;

   --  Set the application update date.
   procedure Set_Update_Date (Object : in out Application_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the application update date.
   function Get_Update_Date (Object : in Application_Ref)
                 return Ada.Calendar.Time;

   --  Set the application title displayed in the OAuth login form.
   procedure Set_Title (Object : in out Application_Ref;
                        Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Title (Object : in out Application_Ref;
                        Value : in String);

   --  Get the application title displayed in the OAuth login form.
   function Get_Title (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Title (Object : in Application_Ref)
                 return String;

   --  Set the application description.
   procedure Set_Description (Object : in out Application_Ref;
                              Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Description (Object : in out Application_Ref;
                              Value : in String);

   --  Get the application description.
   function Get_Description (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Description (Object : in Application_Ref)
                 return String;

   --  Set the optional login URL.
   procedure Set_App_Login_Url (Object : in out Application_Ref;
                                Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_App_Login_Url (Object : in out Application_Ref;
                                Value : in String);

   --  Get the optional login URL.
   function Get_App_Login_Url (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_App_Login_Url (Object : in Application_Ref)
                 return String;

   --  Set the application logo URL.
   procedure Set_App_Logo_Url (Object : in out Application_Ref;
                               Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_App_Logo_Url (Object : in out Application_Ref;
                               Value : in String);

   --  Get the application logo URL.
   function Get_App_Logo_Url (Object : in Application_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_App_Logo_Url (Object : in Application_Ref)
                 return String;

   --
   procedure Set_User (Object : in out Application_Ref;
                       Value  : in AWA.Users.Models.User_Ref'Class);

   --
   function Get_User (Object : in Application_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Application_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Application_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Application_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Application_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Application_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Application_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   APPLICATION_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Application_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Application_Ref;
                   Into   : in out Application_Ref);

   package Application_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Application_Ref,
                                  "="          => "=");
   subtype Application_Vector is Application_Vectors.Vector;

   procedure List (Object  : in out Application_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);
   --  Create an object key for Callback.
   function Callback_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Callback from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Callback_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Callback : constant Callback_Ref;
   function "=" (Left, Right : Callback_Ref'Class) return Boolean;

   --
   procedure Set_Id (Object : in out Callback_Ref;
                     Value  : in ADO.Identifier);

   --
   function Get_Id (Object : in Callback_Ref)
                 return ADO.Identifier;

   --
   procedure Set_Url (Object : in out Callback_Ref;
                      Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Url (Object : in out Callback_Ref;
                      Value : in String);

   --
   function Get_Url (Object : in Callback_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Url (Object : in Callback_Ref)
                 return String;
   --  Get the optimistic lock version.
   function Get_Version (Object : in Callback_Ref)
                 return Integer;

   --
   procedure Set_Application (Object : in out Callback_Ref;
                              Value  : in AWA.OAuth.Models.Application_Ref'Class);

   --
   function Get_Application (Object : in Callback_Ref)
                 return AWA.OAuth.Models.Application_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Callback_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Callback_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Callback_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Callback_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Callback_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Callback_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   CALLBACK_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Callback_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Callback_Ref;
                   Into   : in out Callback_Ref);

   package Callback_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Callback_Ref,
                                  "="          => "=");
   subtype Callback_Vector is Callback_Vectors.Vector;

   procedure List (Object  : in out Callback_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);
   --  --------------------
   --  The session is created when the user has granted an access to an application
   --  or when the application has refreshed its access token.
   --  --------------------
   --  Create an object key for Session.
   function Session_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Session from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Session_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Session : constant Session_Ref;
   function "=" (Left, Right : Session_Ref'Class) return Boolean;

   --  Set the session identifier.
   procedure Set_Id (Object : in out Session_Ref;
                     Value  : in ADO.Identifier);

   --  Get the session identifier.
   function Get_Id (Object : in Session_Ref)
                 return ADO.Identifier;

   --  Set the session creation date.
   procedure Set_Create_Date (Object : in out Session_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the session creation date.
   function Get_Create_Date (Object : in Session_Ref)
                 return Ada.Calendar.Time;

   --  Set a random salt string to access/request token generation.
   procedure Set_Salt (Object : in out Session_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Salt (Object : in out Session_Ref;
                       Value : in String);

   --  Get a random salt string to access/request token generation.
   function Get_Salt (Object : in Session_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Salt (Object : in Session_Ref)
                 return String;

   --  Set the expiration date.
   procedure Set_Expire_Date (Object : in out Session_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the expiration date.
   function Get_Expire_Date (Object : in Session_Ref)
                 return Ada.Calendar.Time;

   --  Set the application that is granted access.
   procedure Set_Application (Object : in out Session_Ref;
                              Value  : in AWA.OAuth.Models.Application_Ref'Class);

   --  Get the application that is granted access.
   function Get_Application (Object : in Session_Ref)
                 return AWA.OAuth.Models.Application_Ref'Class;

   --
   procedure Set_User (Object : in out Session_Ref;
                       Value  : in AWA.Users.Models.User_Ref'Class);

   --
   function Get_User (Object : in Session_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --
   procedure Set_Session (Object : in out Session_Ref;
                          Value  : in AWA.Users.Models.Session_Ref'Class);

   --
   function Get_Session (Object : in Session_Ref)
                 return AWA.Users.Models.Session_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Session_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Session_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Session_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Session_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Session_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Session_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   SESSION_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Session_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Session_Ref;
                   Into   : in out Session_Ref);

   package Session_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Session_Ref,
                                  "="          => "=");
   subtype Session_Vector is Session_Vectors.Vector;

   procedure List (Object  : in out Session_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);



private
   APPLICATION_NAME : aliased constant String := "awa_application";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "name";
   COL_2_1_NAME : aliased constant String := "secret_key";
   COL_3_1_NAME : aliased constant String := "client_id";
   COL_4_1_NAME : aliased constant String := "version";
   COL_5_1_NAME : aliased constant String := "create_date";
   COL_6_1_NAME : aliased constant String := "update_date";
   COL_7_1_NAME : aliased constant String := "title";
   COL_8_1_NAME : aliased constant String := "description";
   COL_9_1_NAME : aliased constant String := "app_login_url";
   COL_10_1_NAME : aliased constant String := "app_logo_url";
   COL_11_1_NAME : aliased constant String := "user_id";

   APPLICATION_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 12,
      Table   => APPLICATION_NAME'Access,
      Members => (
         1 => COL_0_1_NAME'Access,
         2 => COL_1_1_NAME'Access,
         3 => COL_2_1_NAME'Access,
         4 => COL_3_1_NAME'Access,
         5 => COL_4_1_NAME'Access,
         6 => COL_5_1_NAME'Access,
         7 => COL_6_1_NAME'Access,
         8 => COL_7_1_NAME'Access,
         9 => COL_8_1_NAME'Access,
         10 => COL_9_1_NAME'Access,
         11 => COL_10_1_NAME'Access,
         12 => COL_11_1_NAME'Access)
     );
   APPLICATION_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := APPLICATION_DEF'Access;


   Null_Application : constant Application_Ref
      := Application_Ref'(ADO.Objects.Object_Ref with null record);

   type Application_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => APPLICATION_DEF'Access)
   with record
       Name : Ada.Strings.Unbounded.Unbounded_String;
       Secret_Key : Ada.Strings.Unbounded.Unbounded_String;
       Client_Id : Ada.Strings.Unbounded.Unbounded_String;
       Version : Integer;
       Create_Date : Ada.Calendar.Time;
       Update_Date : Ada.Calendar.Time;
       Title : Ada.Strings.Unbounded.Unbounded_String;
       Description : Ada.Strings.Unbounded.Unbounded_String;
       App_Login_Url : Ada.Strings.Unbounded.Unbounded_String;
       App_Logo_Url : Ada.Strings.Unbounded.Unbounded_String;
       User : AWA.Users.Models.User_Ref;
   end record;

   type Application_Access is access all Application_Impl;

   overriding
   procedure Destroy (Object : access Application_Impl);

   overriding
   procedure Find (Object  : in out Application_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Application_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Application_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Application_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Application_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Application_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Application_Ref'Class;
                        Impl   : out Application_Access);
   CALLBACK_NAME : aliased constant String := "awa_callback";
   COL_0_2_NAME : aliased constant String := "id";
   COL_1_2_NAME : aliased constant String := "url";
   COL_2_2_NAME : aliased constant String := "version";
   COL_3_2_NAME : aliased constant String := "application_id";

   CALLBACK_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 4,
      Table   => CALLBACK_NAME'Access,
      Members => (
         1 => COL_0_2_NAME'Access,
         2 => COL_1_2_NAME'Access,
         3 => COL_2_2_NAME'Access,
         4 => COL_3_2_NAME'Access)
     );
   CALLBACK_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := CALLBACK_DEF'Access;


   Null_Callback : constant Callback_Ref
      := Callback_Ref'(ADO.Objects.Object_Ref with null record);

   type Callback_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => CALLBACK_DEF'Access)
   with record
       Url : Ada.Strings.Unbounded.Unbounded_String;
       Version : Integer;
       Application : AWA.OAuth.Models.Application_Ref;
   end record;

   type Callback_Access is access all Callback_Impl;

   overriding
   procedure Destroy (Object : access Callback_Impl);

   overriding
   procedure Find (Object  : in out Callback_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Callback_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Callback_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Callback_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Callback_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Callback_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Callback_Ref'Class;
                        Impl   : out Callback_Access);
   SESSION_NAME : aliased constant String := "awa_oauth_session";
   COL_0_3_NAME : aliased constant String := "id";
   COL_1_3_NAME : aliased constant String := "create_date";
   COL_2_3_NAME : aliased constant String := "salt";
   COL_3_3_NAME : aliased constant String := "expire_date";
   COL_4_3_NAME : aliased constant String := "application_id";
   COL_5_3_NAME : aliased constant String := "user_id";
   COL_6_3_NAME : aliased constant String := "session_id";

   SESSION_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 7,
      Table   => SESSION_NAME'Access,
      Members => (
         1 => COL_0_3_NAME'Access,
         2 => COL_1_3_NAME'Access,
         3 => COL_2_3_NAME'Access,
         4 => COL_3_3_NAME'Access,
         5 => COL_4_3_NAME'Access,
         6 => COL_5_3_NAME'Access,
         7 => COL_6_3_NAME'Access)
     );
   SESSION_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := SESSION_DEF'Access;


   Null_Session : constant Session_Ref
      := Session_Ref'(ADO.Objects.Object_Ref with null record);

   type Session_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => SESSION_DEF'Access)
   with record
       Create_Date : Ada.Calendar.Time;
       Salt : Ada.Strings.Unbounded.Unbounded_String;
       Expire_Date : Ada.Calendar.Time;
       Application : AWA.OAuth.Models.Application_Ref;
       User : AWA.Users.Models.User_Ref;
       Session : AWA.Users.Models.Session_Ref;
   end record;

   type Session_Access is access all Session_Impl;

   overriding
   procedure Destroy (Object : access Session_Impl);

   overriding
   procedure Find (Object  : in out Session_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Session_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Session_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Session_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Session_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Session_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Session_Ref'Class;
                        Impl   : out Session_Access);
end AWA.OAuth.Models;
