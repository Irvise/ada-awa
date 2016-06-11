-----------------------------------------------------------------------
--  awa-images-beans -- Image Ada Beans
--  Copyright (C) 2016 Stephane Carrez
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

with ADO.Queries;
with ADO.Sessions;
with ADO.Objects;
with ADO.Sessions.Entities;

with AWA.Workspaces.Models;
with AWA.Services.Contexts;
with AWA.Storages.Modules;
package body AWA.Images.Beans is

   --  ------------------------------
   --  Load the list of images associated with the current folder.
   --  ------------------------------
   overriding
   procedure Load_Files (Storage : in Image_List_Bean) is
      use AWA.Services;

      Ctx       : constant Contexts.Service_Context_Access := AWA.Services.Contexts.Current;
      User      : constant ADO.Identifier := Ctx.Get_User_Identifier;
      Session   : ADO.Sessions.Session := Storage.Module.Get_Session;
      Query     : ADO.Queries.Context;
   begin
      if not Storage.Init_Flags (AWA.Storages.Beans.INIT_FOLDER) then
         Load_Folder (Storage);
      end if;
      Query.Set_Query (AWA.Images.Models.Query_Image_List);
      Query.Bind_Param ("user_id", User);
      ADO.Sessions.Entities.Bind_Param (Query, "table",
                                        AWA.Workspaces.Models.WORKSPACE_TABLE, Session);
      if Storage.Folder_Bean.Is_Null then
         Query.Bind_Null_Param ("folder_id");
      else
         Query.Bind_Param ("folder_id", Storage.Folder_Bean.Get_Id);
      end if;
      AWA.Images.Models.List (Storage.Image_List_Bean.all, Session, Query);
      Storage.Flags (AWA.Storages.Beans.INIT_FILE_LIST) := True;
   end Load_Files;

   overriding
   function Get_Value (List : in Image_List_Bean;
                       Name : in String) return Util.Beans.Objects.Object is
   begin
      if Name = "images" then
         return Util.Beans.Objects.To_Object (Value   => List.Image_List_Bean,
                                              Storage => Util.Beans.Objects.STATIC);

      elsif Name = "folders" then
         return Util.Beans.Objects.To_Object (Value   => List.Folder_List_Bean,
                                              Storage => Util.Beans.Objects.STATIC);

      elsif Name = "folder" then
--           if not List.Init_Flags (INIT_FOLDER) then
--              Load_Folder (List);
--           end if;
         if List.Folder_Bean.Is_Null then
            return Util.Beans.Objects.Null_Object;
         end if;
         return Util.Beans.Objects.To_Object (Value   => List.Folder_Bean,
                                              Storage => Util.Beans.Objects.STATIC);

      else
         return Util.Beans.Objects.Null_Object;
      end if;
   end Get_Value;

   --  ------------------------------
   --  Create the Image_List_Bean bean instance.
   --  ------------------------------
   function Create_Image_List_Bean (Module : in AWA.Images.Modules.Image_Module_Access)
                                    return Util.Beans.Basic.Readonly_Bean_Access is
      pragma Unreferenced (Module);

      Object    : constant Image_List_Bean_Access := new Image_List_Bean;
   begin
      Object.Module           := AWA.Storages.Modules.Get_Storage_Module;
      Object.Folder_Bean      := Object.Folder'Access;
      Object.Folder_List_Bean := Object.Folder_List'Access;
      Object.Files_List_Bean  := Object.Files_List'Access;
      Object.Image_List_Bean  := Object.Image_List'Access;
      Object.Flags            := Object.Init_Flags'Access;
      return Object.all'Access;
   end Create_Image_List_Bean;

end AWA.Images.Beans;
