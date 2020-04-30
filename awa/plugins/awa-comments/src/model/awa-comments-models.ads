-----------------------------------------------------------------------
--  AWA.Comments.Models -- AWA.Comments.Models
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
with ADO.Queries;
with ADO.Queries.Loaders;
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Objects.Enums;
with Util.Beans.Basic.Lists;
with ADO.Audits;
with AWA.Users.Models;
with Util.Beans.Methods;
pragma Warnings (On);
package AWA.Comments.Models is

   pragma Style_Checks ("-mr");

   --  --------------------
   --  The format type defines the message format type.
   --  --------------------
   type Format_Type is (FORMAT_TEXT, FORMAT_WIKI, FORMAT_HTML);
   for Format_Type use (FORMAT_TEXT => 0, FORMAT_WIKI => 1, FORMAT_HTML => 2);
   package Format_Type_Objects is
      new Util.Beans.Objects.Enums (Format_Type);

   type Nullable_Format_Type is record
      Is_Null : Boolean := True;
      Value   : Format_Type;
   end record;

   --  --------------------
   --  The status type defines whether the comment is visible or not.
   --  The comment can be put in the COMMENT_WAITING state so that
   --  it is not immediately visible. It must be put in the COMMENT_PUBLISHED
   --  state to be visible.
   --  --------------------
   type Status_Type is (COMMENT_PUBLISHED, COMMENT_WAITING, COMMENT_SPAM, COMMENT_BLOCKED, COMMENT_ARCHIVED);
   for Status_Type use (COMMENT_PUBLISHED => 0, COMMENT_WAITING => 1, COMMENT_SPAM => 2, COMMENT_BLOCKED => 3, COMMENT_ARCHIVED => 4);
   package Status_Type_Objects is
      new Util.Beans.Objects.Enums (Status_Type);

   type Nullable_Status_Type is record
      Is_Null : Boolean := True;
      Value   : Status_Type;
   end record;

   type Comment_Ref is new ADO.Objects.Object_Ref with null record;

   --  --------------------
   --  The Comment table records a user comment associated with a database entity.
   --  The comment can be associated with any other database record.
   --  --------------------
   --  Create an object key for Comment.
   function Comment_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Comment from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Comment_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Comment : constant Comment_Ref;
   function "=" (Left, Right : Comment_Ref'Class) return Boolean;

   --  Set the comment publication date
   procedure Set_Create_Date (Object : in out Comment_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the comment publication date
   function Get_Create_Date (Object : in Comment_Ref)
                 return Ada.Calendar.Time;

   --  Set the comment message.
   procedure Set_Message (Object : in out Comment_Ref;
                          Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Message (Object : in out Comment_Ref;
                          Value : in String);

   --  Get the comment message.
   function Get_Message (Object : in Comment_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Message (Object : in Comment_Ref)
                 return String;

   --  Set the entity identifier to which this comment is associated
   procedure Set_Entity_Id (Object : in out Comment_Ref;
                            Value  : in ADO.Identifier);

   --  Get the entity identifier to which this comment is associated
   function Get_Entity_Id (Object : in Comment_Ref)
                 return ADO.Identifier;

   --  Set the comment identifier
   procedure Set_Id (Object : in out Comment_Ref;
                     Value  : in ADO.Identifier);

   --  Get the comment identifier
   function Get_Id (Object : in Comment_Ref)
                 return ADO.Identifier;
   --  Get the optimistic lock version.
   function Get_Version (Object : in Comment_Ref)
                 return Integer;

   --  Set the entity type that identifies the table to which the comment is associated.
   procedure Set_Entity_Type (Object : in out Comment_Ref;
                              Value  : in ADO.Entity_Type);

   --  Get the entity type that identifies the table to which the comment is associated.
   function Get_Entity_Type (Object : in Comment_Ref)
                 return ADO.Entity_Type;

   --  Set the comment status to decide whether the comment is visible (published) or not.
   procedure Set_Status (Object : in out Comment_Ref;
                         Value  : in AWA.Comments.Models.Status_Type);

   --  Get the comment status to decide whether the comment is visible (published) or not.
   function Get_Status (Object : in Comment_Ref)
                 return AWA.Comments.Models.Status_Type;

   --  Set the comment format type.
   procedure Set_Format (Object : in out Comment_Ref;
                         Value  : in AWA.Comments.Models.Format_Type);

   --  Get the comment format type.
   function Get_Format (Object : in Comment_Ref)
                 return AWA.Comments.Models.Format_Type;

   --
   procedure Set_Author (Object : in out Comment_Ref;
                         Value  : in AWA.Users.Models.User_Ref'Class);

   --
   function Get_Author (Object : in Comment_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Comment_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Comment_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   COMMENT_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Comment_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Comment_Ref;
                   Into   : in out Comment_Ref);


   --  --------------------
   --    The comment information.
   --  --------------------
   type Comment_Info is
     new Util.Beans.Basic.Bean with  record

      --  the comment identifier.
      Id : ADO.Identifier;

      --  the comment author's name.
      Author : Ada.Strings.Unbounded.Unbounded_String;

      --  the comment author's email.
      Email : Ada.Strings.Unbounded.Unbounded_String;

      --  the comment date.
      Date : Ada.Calendar.Time;

      --  the comment format type.
      Format : AWA.Comments.Models.Format_Type;

      --  the comment text.
      Comment : Ada.Strings.Unbounded.Unbounded_String;

      --  the comment status.
      Status : AWA.Comments.Models.Status_Type;
   end record;

   --  Get the bean attribute identified by the name.
   overriding
   function Get_Value (From : in Comment_Info;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Set the bean attribute identified by the name.
   overriding
   procedure Set_Value (Item  : in out Comment_Info;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);


   package Comment_Info_Beans is
      new Util.Beans.Basic.Lists (Element_Type => Comment_Info);
   package Comment_Info_Vectors renames Comment_Info_Beans.Vectors;
   subtype Comment_Info_List_Bean is Comment_Info_Beans.List_Bean;

   type Comment_Info_List_Bean_Access is access all Comment_Info_List_Bean;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Comment_Info_List_Bean'Class;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   subtype Comment_Info_Vector is Comment_Info_Vectors.Vector;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Comment_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   Query_Comment_List : constant ADO.Queries.Query_Definition_Access;

   Query_All_Comment_List : constant ADO.Queries.Query_Definition_Access;


   type Comment_Bean is abstract new AWA.Comments.Models.Comment_Ref
     and Util.Beans.Basic.Bean and Util.Beans.Methods.Method_Bean with null record;


   --  This bean provides some methods that can be used in a Method_Expression.
   overriding
   function Get_Method_Bindings (From : in Comment_Bean)
                                 return Util.Beans.Methods.Method_Binding_Array_Access;


   --  Set the bean attribute identified by the name.
   overriding
   procedure Set_Value (Item  : in out Comment_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);

   procedure Create (Bean : in out Comment_Bean;
                    Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is abstract;

   procedure Delete (Bean : in out Comment_Bean;
                    Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is abstract;

   procedure Save (Bean : in out Comment_Bean;
                  Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is abstract;

   procedure Publish (Bean : in out Comment_Bean;
                     Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is abstract;


private
   COMMENT_NAME : aliased constant String := "awa_comment";
   COL_0_1_NAME : aliased constant String := "create_date";
   COL_1_1_NAME : aliased constant String := "message";
   COL_2_1_NAME : aliased constant String := "entity_id";
   COL_3_1_NAME : aliased constant String := "id";
   COL_4_1_NAME : aliased constant String := "version";
   COL_5_1_NAME : aliased constant String := "entity_type";
   COL_6_1_NAME : aliased constant String := "status";
   COL_7_1_NAME : aliased constant String := "format";
   COL_8_1_NAME : aliased constant String := "author_id";

   COMMENT_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 9,
      Table   => COMMENT_NAME'Access,
      Members => (
         1 => COL_0_1_NAME'Access,
         2 => COL_1_1_NAME'Access,
         3 => COL_2_1_NAME'Access,
         4 => COL_3_1_NAME'Access,
         5 => COL_4_1_NAME'Access,
         6 => COL_5_1_NAME'Access,
         7 => COL_6_1_NAME'Access,
         8 => COL_7_1_NAME'Access,
         9 => COL_8_1_NAME'Access)
     );
   COMMENT_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := COMMENT_DEF'Access;

   COMMENT_AUDIT_DEF : aliased constant ADO.Audits.Auditable_Mapping :=
     (Count    => 3,
      Of_Class => COMMENT_DEF'Access,
      Members  => (
         1 => 1,
         2 => 6,
         3 => 7)
     );
   COMMENT_AUDIT_TABLE : constant ADO.Audits.Auditable_Mapping_Access
      := COMMENT_AUDIT_DEF'Access;

   Null_Comment : constant Comment_Ref
      := Comment_Ref'(ADO.Objects.Object_Ref with null record);

   type Comment_Impl is
      new ADO.Audits.Auditable_Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => COMMENT_DEF'Access,
                                     With_Audit => COMMENT_AUDIT_DEF'Access)
   with record
       Create_Date : Ada.Calendar.Time;
       Message : Ada.Strings.Unbounded.Unbounded_String;
       Entity_Id : ADO.Identifier;
       Version : Integer;
       Entity_Type : ADO.Entity_Type;
       Status : AWA.Comments.Models.Status_Type;
       Format : AWA.Comments.Models.Format_Type;
       Author : AWA.Users.Models.User_Ref;
   end record;

   type Comment_Access is access all Comment_Impl;

   overriding
   procedure Destroy (Object : access Comment_Impl);

   overriding
   procedure Find (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Comment_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Comment_Ref'Class;
                        Impl   : out Comment_Access);

   package File_1 is
      new ADO.Queries.Loaders.File (Path => "comment-queries.xml",
                                    Sha1 => "80302F51E2EC9855EFAFB43954D724A697C1F8E6");

   package Def_Commentinfo_Comment_List is
      new ADO.Queries.Loaders.Query (Name => "comment-list",
                                     File => File_1.File'Access);
   Query_Comment_List : constant ADO.Queries.Query_Definition_Access
   := Def_Commentinfo_Comment_List.Query'Access;

   package Def_Commentinfo_All_Comment_List is
      new ADO.Queries.Loaders.Query (Name => "all-comment-list",
                                     File => File_1.File'Access);
   Query_All_Comment_List : constant ADO.Queries.Query_Definition_Access
   := Def_Commentinfo_All_Comment_List.Query'Access;
end AWA.Comments.Models;
