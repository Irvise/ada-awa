-----------------------------------------------------------------------
--  AWA.Events.Models -- AWA.Events.Models
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
with AWA.Users.Models;
pragma Warnings (On);
package AWA.Events.Models is

   pragma Style_Checks ("-mr");

   type Message_Status_Type is (QUEUED, PROCESSING, PROCESSED);
   for Message_Status_Type use (QUEUED => 0, PROCESSING => 1, PROCESSED => 2);
   package Message_Status_Type_Objects is
      new Util.Beans.Objects.Enums (Message_Status_Type);

   type Nullable_Message_Status_Type is record
      Is_Null : Boolean := True;
      Value   : Message_Status_Type;
   end record;

   type Message_Type_Ref is new ADO.Objects.Object_Ref with null record;

   type Queue_Ref is new ADO.Objects.Object_Ref with null record;

   type Message_Ref is new ADO.Objects.Object_Ref with null record;

   --  Create an object key for Message_Type.
   function Message_Type_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Message_Type from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Message_Type_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Message_Type : constant Message_Type_Ref;
   function "=" (Left, Right : Message_Type_Ref'Class) return Boolean;

   --
   procedure Set_Id (Object : in out Message_Type_Ref;
                     Value  : in ADO.Identifier);

   --
   function Get_Id (Object : in Message_Type_Ref)
                 return ADO.Identifier;

   --  Set the message type name
   procedure Set_Name (Object : in out Message_Type_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Name (Object : in out Message_Type_Ref;
                       Value : in String);

   --  Get the message type name
   function Get_Name (Object : in Message_Type_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Name (Object : in Message_Type_Ref)
                 return String;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Message_Type_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Message_Type_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Message_Type_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Message_Type_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Message_Type_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Message_Type_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   MESSAGE_TYPE_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Message_Type_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Message_Type_Ref;
                   Into   : in out Message_Type_Ref);

   package Message_Type_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Message_Type_Ref,
                                  "="          => "=");
   subtype Message_Type_Vector is Message_Type_Vectors.Vector;

   procedure List (Object  : in out Message_Type_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);
   --  --------------------
   --  The message queue tracks the event messages that must be dispatched by
   --  a given server.
   --  --------------------
   --  Create an object key for Queue.
   function Queue_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Queue from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Queue_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Queue : constant Queue_Ref;
   function "=" (Left, Right : Queue_Ref'Class) return Boolean;

   --
   procedure Set_Id (Object : in out Queue_Ref;
                     Value  : in ADO.Identifier);

   --
   function Get_Id (Object : in Queue_Ref)
                 return ADO.Identifier;

   --
   procedure Set_Server_Id (Object : in out Queue_Ref;
                            Value  : in Integer);

   --
   function Get_Server_Id (Object : in Queue_Ref)
                 return Integer;

   --  Set the message queue name
   procedure Set_Name (Object : in out Queue_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Name (Object : in out Queue_Ref;
                       Value : in String);

   --  Get the message queue name
   function Get_Name (Object : in Queue_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Name (Object : in Queue_Ref)
                 return String;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Queue_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Queue_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Queue_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Queue_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Queue_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Queue_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   QUEUE_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Queue_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Queue_Ref;
                   Into   : in out Queue_Ref);

   --  Create an object key for Message.
   function Message_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Message from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Message_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Message : constant Message_Ref;
   function "=" (Left, Right : Message_Ref'Class) return Boolean;

   --  Set the message identifier
   procedure Set_Id (Object : in out Message_Ref;
                     Value  : in ADO.Identifier);

   --  Get the message identifier
   function Get_Id (Object : in Message_Ref)
                 return ADO.Identifier;

   --  Set the message creation date
   procedure Set_Create_Date (Object : in out Message_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the message creation date
   function Get_Create_Date (Object : in Message_Ref)
                 return Ada.Calendar.Time;

   --  Set the message priority
   procedure Set_Priority (Object : in out Message_Ref;
                           Value  : in Integer);

   --  Get the message priority
   function Get_Priority (Object : in Message_Ref)
                 return Integer;

   --  Set the message count
   procedure Set_Count (Object : in out Message_Ref;
                        Value  : in Integer);

   --  Get the message count
   function Get_Count (Object : in Message_Ref)
                 return Integer;

   --  Set the message parameters
   procedure Set_Parameters (Object : in out Message_Ref;
                             Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Parameters (Object : in out Message_Ref;
                             Value : in String);

   --  Get the message parameters
   function Get_Parameters (Object : in Message_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Parameters (Object : in Message_Ref)
                 return String;

   --  Set the server identifier which processes the message
   procedure Set_Server_Id (Object : in out Message_Ref;
                            Value  : in Integer);

   --  Get the server identifier which processes the message
   function Get_Server_Id (Object : in Message_Ref)
                 return Integer;

   --  Set the task identfier on the server which processes the message
   procedure Set_Task_Id (Object : in out Message_Ref;
                          Value  : in Integer);

   --  Get the task identfier on the server which processes the message
   function Get_Task_Id (Object : in Message_Ref)
                 return Integer;

   --  Set the message status
   procedure Set_Status (Object : in out Message_Ref;
                         Value  : in AWA.Events.Models.Message_Status_Type);

   --  Get the message status
   function Get_Status (Object : in Message_Ref)
                 return AWA.Events.Models.Message_Status_Type;

   --  Set the message processing date
   procedure Set_Processing_Date (Object : in out Message_Ref;
                                  Value  : in ADO.Nullable_Time);

   --  Get the message processing date
   function Get_Processing_Date (Object : in Message_Ref)
                 return ADO.Nullable_Time;
   --
   function Get_Version (Object : in Message_Ref)
                 return Integer;

   --  Set the entity identifier to which this event is associated.
   procedure Set_Entity_Id (Object : in out Message_Ref;
                            Value  : in ADO.Identifier);

   --  Get the entity identifier to which this event is associated.
   function Get_Entity_Id (Object : in Message_Ref)
                 return ADO.Identifier;

   --  Set the entity type of the entity identifier to which this event is associated.
   procedure Set_Entity_Type (Object : in out Message_Ref;
                              Value  : in ADO.Entity_Type);

   --  Get the entity type of the entity identifier to which this event is associated.
   function Get_Entity_Type (Object : in Message_Ref)
                 return ADO.Entity_Type;

   --  Set the date and time when the event was finished to be processed.
   procedure Set_Finish_Date (Object : in out Message_Ref;
                              Value  : in ADO.Nullable_Time);

   --  Get the date and time when the event was finished to be processed.
   function Get_Finish_Date (Object : in Message_Ref)
                 return ADO.Nullable_Time;

   --
   procedure Set_Queue (Object : in out Message_Ref;
                        Value  : in AWA.Events.Models.Queue_Ref'Class);

   --
   function Get_Queue (Object : in Message_Ref)
                 return AWA.Events.Models.Queue_Ref'Class;

   --  Set the message type
   procedure Set_Message_Type (Object : in out Message_Ref;
                               Value  : in AWA.Events.Models.Message_Type_Ref'Class);

   --  Get the message type
   function Get_Message_Type (Object : in Message_Ref)
                 return AWA.Events.Models.Message_Type_Ref'Class;

   --  Set the optional user who triggered the event message creation
   procedure Set_User (Object : in out Message_Ref;
                       Value  : in AWA.Users.Models.User_Ref'Class);

   --  Get the optional user who triggered the event message creation
   function Get_User (Object : in Message_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --  Set the optional user session that triggered the message creation
   procedure Set_Session (Object : in out Message_Ref;
                          Value  : in AWA.Users.Models.Session_Ref'Class);

   --  Get the optional user session that triggered the message creation
   function Get_Session (Object : in Message_Ref)
                 return AWA.Users.Models.Session_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Message_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Message_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Message_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Message_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Message_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Message_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   MESSAGE_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Message_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Message_Ref;
                   Into   : in out Message_Ref);

   package Message_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Message_Ref,
                                  "="          => "=");
   subtype Message_Vector is Message_Vectors.Vector;

   procedure List (Object  : in out Message_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);


   Query_Queue_Pending_Message : constant ADO.Queries.Query_Definition_Access;



private
   MESSAGE_TYPE_NAME : aliased constant String := "awa_message_type";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "name";

   MESSAGE_TYPE_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 2,
      Table   => MESSAGE_TYPE_NAME'Access,
      Members => (
         1 => COL_0_1_NAME'Access,
         2 => COL_1_1_NAME'Access)
     );
   MESSAGE_TYPE_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := MESSAGE_TYPE_DEF'Access;


   Null_Message_Type : constant Message_Type_Ref
      := Message_Type_Ref'(ADO.Objects.Object_Ref with null record);

   type Message_Type_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => MESSAGE_TYPE_DEF'Access)
   with record
       Name : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Message_Type_Access is access all Message_Type_Impl;

   overriding
   procedure Destroy (Object : access Message_Type_Impl);

   overriding
   procedure Find (Object  : in out Message_Type_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Message_Type_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Message_Type_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Message_Type_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Message_Type_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Message_Type_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Message_Type_Ref'Class;
                        Impl   : out Message_Type_Access);
   QUEUE_NAME : aliased constant String := "awa_queue";
   COL_0_2_NAME : aliased constant String := "id";
   COL_1_2_NAME : aliased constant String := "server_id";
   COL_2_2_NAME : aliased constant String := "name";

   QUEUE_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 3,
      Table   => QUEUE_NAME'Access,
      Members => (
         1 => COL_0_2_NAME'Access,
         2 => COL_1_2_NAME'Access,
         3 => COL_2_2_NAME'Access)
     );
   QUEUE_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := QUEUE_DEF'Access;


   Null_Queue : constant Queue_Ref
      := Queue_Ref'(ADO.Objects.Object_Ref with null record);

   type Queue_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => QUEUE_DEF'Access)
   with record
       Server_Id : Integer;
       Name : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Queue_Access is access all Queue_Impl;

   overriding
   procedure Destroy (Object : access Queue_Impl);

   overriding
   procedure Find (Object  : in out Queue_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Queue_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Queue_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Queue_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Queue_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Queue_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Queue_Ref'Class;
                        Impl   : out Queue_Access);
   MESSAGE_NAME : aliased constant String := "awa_message";
   COL_0_3_NAME : aliased constant String := "id";
   COL_1_3_NAME : aliased constant String := "create_date";
   COL_2_3_NAME : aliased constant String := "priority";
   COL_3_3_NAME : aliased constant String := "count";
   COL_4_3_NAME : aliased constant String := "parameters";
   COL_5_3_NAME : aliased constant String := "server_id";
   COL_6_3_NAME : aliased constant String := "task_id";
   COL_7_3_NAME : aliased constant String := "status";
   COL_8_3_NAME : aliased constant String := "processing_date";
   COL_9_3_NAME : aliased constant String := "version";
   COL_10_3_NAME : aliased constant String := "entity_id";
   COL_11_3_NAME : aliased constant String := "entity_type";
   COL_12_3_NAME : aliased constant String := "finish_date";
   COL_13_3_NAME : aliased constant String := "queue_id";
   COL_14_3_NAME : aliased constant String := "message_type_id";
   COL_15_3_NAME : aliased constant String := "user_id";
   COL_16_3_NAME : aliased constant String := "session_id";

   MESSAGE_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 17,
      Table   => MESSAGE_NAME'Access,
      Members => (
         1 => COL_0_3_NAME'Access,
         2 => COL_1_3_NAME'Access,
         3 => COL_2_3_NAME'Access,
         4 => COL_3_3_NAME'Access,
         5 => COL_4_3_NAME'Access,
         6 => COL_5_3_NAME'Access,
         7 => COL_6_3_NAME'Access,
         8 => COL_7_3_NAME'Access,
         9 => COL_8_3_NAME'Access,
         10 => COL_9_3_NAME'Access,
         11 => COL_10_3_NAME'Access,
         12 => COL_11_3_NAME'Access,
         13 => COL_12_3_NAME'Access,
         14 => COL_13_3_NAME'Access,
         15 => COL_14_3_NAME'Access,
         16 => COL_15_3_NAME'Access,
         17 => COL_16_3_NAME'Access)
     );
   MESSAGE_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := MESSAGE_DEF'Access;


   Null_Message : constant Message_Ref
      := Message_Ref'(ADO.Objects.Object_Ref with null record);

   type Message_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => MESSAGE_DEF'Access)
   with record
       Create_Date : Ada.Calendar.Time;
       Priority : Integer;
       Count : Integer;
       Parameters : Ada.Strings.Unbounded.Unbounded_String;
       Server_Id : Integer;
       Task_Id : Integer;
       Status : AWA.Events.Models.Message_Status_Type;
       Processing_Date : ADO.Nullable_Time;
       Version : Integer;
       Entity_Id : ADO.Identifier;
       Entity_Type : ADO.Entity_Type;
       Finish_Date : ADO.Nullable_Time;
       Queue : AWA.Events.Models.Queue_Ref;
       Message_Type : AWA.Events.Models.Message_Type_Ref;
       User : AWA.Users.Models.User_Ref;
       Session : AWA.Users.Models.Session_Ref;
   end record;

   type Message_Access is access all Message_Impl;

   overriding
   procedure Destroy (Object : access Message_Impl);

   overriding
   procedure Find (Object  : in out Message_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Message_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Message_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Message_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Message_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Message_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Message_Ref'Class;
                        Impl   : out Message_Access);

   package File_1 is
      new ADO.Queries.Loaders.File (Path => "queue-messages.xml",
                                    Sha1 => "9B2B599473F75F92CB5AB5045675E4CCEF926543");

   package Def_Queue_Pending_Message is
      new ADO.Queries.Loaders.Query (Name => "queue-pending-message",
                                     File => File_1.File'Access);
   Query_Queue_Pending_Message : constant ADO.Queries.Query_Definition_Access
   := Def_Queue_Pending_Message.Query'Access;
end AWA.Events.Models;
