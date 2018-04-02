-----------------------------------------------------------------------
--  awa-blogs-servlets -- Serve files saved in the storage service
--  Copyright (C) 2017, 2018 Stephane Carrez
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

with AWA.Images.Modules;
with AWA.Blogs.Modules;
package body AWA.Blogs.Servlets is

   --  ------------------------------
   --  Load the data content that correspond to the GET request and get the name as well
   --  as mime-type and date.
   --  ------------------------------
   overriding
   procedure Load (Server   : in Image_Servlet;
                   Request  : in out ASF.Requests.Request'Class;
                   Name     : out Ada.Strings.Unbounded.Unbounded_String;
                   Mime     : out Ada.Strings.Unbounded.Unbounded_String;
                   Date     : out Ada.Calendar.Time;
                   Data     : out ADO.Blob_Ref) is
      pragma Unreferenced (Server, Name);

      Post      : constant String := Request.Get_Path_Parameter (1);
      File      : constant String := Request.Get_Path_Parameter (2);
      Size      : constant String := Request.Get_Path_Parameter (3);
      Module    : constant AWA.Blogs.Modules.Blog_Module_Access := Blogs.Modules.Get_Blog_Module;
      Post_Id   : ADO.Identifier;
      File_Id   : ADO.Identifier;
      Width     : Natural;
      Height    : Natural;
      Img_Width : Natural;
      Img_Height : Natural;
   begin
      Post_Id := ADO.Identifier'Value (Post);
      File_Id := ADO.Identifier'Value (File);

      AWA.Images.Modules.Get_Sizes (Dimension => Size,
                                    Width     => Width,
                                    Height    => Height);

      Img_Width  := Width;
      Img_Height := Height;
      Module.Load_Image (Post_Id  => Post_Id,
                         Image_Id => File_Id,
                         Width    => Img_Width,
                         Height   => Img_Height,
                         Mime     => Mime,
                         Date     => Date,
                         Into     => Data);

   end Load;

end AWA.Blogs.Servlets;
