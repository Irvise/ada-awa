-----------------------------------------------------------------------
--  AWA.Counters.Models -- AWA.Counters.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-body.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1095
-----------------------------------------------------------------------
--  Copyright (C) 2015 Stephane Carrez
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
with Ada.Unchecked_Deallocation;
with Util.Beans.Objects.Time;
package body AWA.Counters.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function Counter_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_STRING,
                                       Of_Class => COUNTER_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Counter_Key;

   function Counter_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_STRING,
                                       Of_Class => COUNTER_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Counter_Key;

   function "=" (Left, Right : Counter_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Counter_Ref'Class;
                        Impl   : out Counter_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Counter_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Counter_Ref) is
      Impl : Counter_Access;
   begin
      Impl := new Counter_Impl;
      Impl.Object_Id := ADO.NO_IDENTIFIER;
      Impl.Date := ADO.DEFAULT_TIME;
      Impl.Counter := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Counter
   -- ----------------------------------------

   procedure Set_Object_Id (Object : in out Counter_Ref;
                            Value  : in ADO.Identifier) is
      Impl : Counter_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Identifier (Impl.all, 1, Impl.Object_Id, Value);
   end Set_Object_Id;

   function Get_Object_Id (Object : in Counter_Ref)
                  return ADO.Identifier is
      Impl : constant Counter_Access
         := Counter_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Object_Id;
   end Get_Object_Id;


   procedure Set_Date (Object : in out Counter_Ref;
                       Value  : in Ada.Calendar.Time) is
      Impl : Counter_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Time (Impl.all, 2, Impl.Date, Value);
   end Set_Date;

   function Get_Date (Object : in Counter_Ref)
                  return Ada.Calendar.Time is
      Impl : constant Counter_Access
         := Counter_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Date;
   end Get_Date;


   procedure Set_Counter (Object : in out Counter_Ref;
                          Value  : in Integer) is
      Impl : Counter_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 3, Impl.Counter, Value);
   end Set_Counter;

   function Get_Counter (Object : in Counter_Ref)
                  return Integer is
      Impl : constant Counter_Access
         := Counter_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Counter;
   end Get_Counter;


   procedure Set_Definition_Id (Object : in out Counter_Ref;
                                Value  : in Integer) is
      Impl : Counter_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 4, ADO.Identifier (Value));
   end Set_Definition_Id;

   function Get_Definition_Id (Object : in Counter_Ref)
                  return Integer is
      Impl : constant Counter_Access
         := Counter_Impl (Object.Get_Object.all)'Access;
   begin
      return Integer (ADO.Identifier '(Impl.Get_Key_Value));
   end Get_Definition_Id;

   --  Copy of the object.
   procedure Copy (Object : in Counter_Ref;
                   Into   : in out Counter_Ref) is
      Result : Counter_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Counter_Access
              := Counter_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Counter_Access
              := new Counter_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Object_Id := Impl.Object_Id;
            Copy.Date := Impl.Date;
            Copy.Counter := Impl.Counter;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Counter_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Counter_Access := new Counter_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Counter_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in Integer) is
      Impl  : constant Counter_Access := new Counter_Impl;
      Found : Boolean;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("definition_id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
         raise ADO.Objects.NOT_FOUND;
      end if;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Load;

   procedure Load (Object  : in out Counter_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in Integer;
                   Found   : out Boolean) is
      Impl  : constant Counter_Access := new Counter_Impl;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("definition_id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
      else
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      end if;
   end Load;

   procedure Save (Object  : in out Counter_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Counter_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Counter_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : constant ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl /= null then
         Impl.Delete (Session);
      end if;
   end Delete;

   --  --------------------
   --  Free the object
   --  --------------------
   procedure Destroy (Object : access Counter_Impl) is
      type Counter_Impl_Ptr is access all Counter_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Counter_Impl, Counter_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Counter_Impl_Ptr := Counter_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Counter_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, COUNTER_DEF'Access);
   begin
      Stmt.Execute;
      if Stmt.Has_Elements then
         Object.Load (Stmt, Session);
         Stmt.Next;
         Found := not Stmt.Has_Elements;
      else
         Found := False;
      end if;
   end Find;

   overriding
   procedure Load (Object  : in out Counter_Impl;
                   Session : in out ADO.Sessions.Session'Class) is
      Found : Boolean;
      Query : ADO.SQL.Query;
      Id    : constant Integer := Integer (ADO.Identifier '(Object.Get_Key_Value));
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("definition_id = ?");
      Object.Find (Session, Query, Found);
      if not Found then
         raise ADO.Objects.NOT_FOUND;
      end if;
   end Load;

   procedure Save (Object  : in out Counter_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (COUNTER_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  object_id
                          Value => Object.Object_Id);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_1_NAME, --  date
                          Value => Object.Date);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  counter
                          Value => Object.Counter);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  definition_id
                          Value => Object.Get_Key);
         Object.Clear_Modified (4);
      end if;
      if Stmt.Has_Save_Fields then
         Stmt.Set_Filter (Filter => "definition_id = ?");
         Stmt.Add_Param (Value => Object.Get_Key);
         declare
            Result : Integer;
         begin
            Stmt.Execute (Result);
            if Result /= 1 then
               if Result /= 0 then
                  raise ADO.Objects.UPDATE_ERROR;
               end if;
            end if;
         end;
      end if;
   end Save;

   procedure Create (Object  : in out Counter_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (COUNTER_DEF'Access);
      Result : Integer;
   begin
      Query.Save_Field (Name  => COL_0_1_NAME, --  object_id
                        Value => Object.Object_Id);
      Query.Save_Field (Name  => COL_1_1_NAME, --  date
                        Value => Object.Date);
      Query.Save_Field (Name  => COL_2_1_NAME, --  counter
                        Value => Object.Counter);
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_3_1_NAME, --  definition_id
                        Value => Object.Get_Key);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Counter_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (COUNTER_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "definition_id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   --  ------------------------------
   --  Get the bean attribute identified by the name.
   --  ------------------------------
   overriding
   function Get_Value (From : in Counter_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Counter_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Counter_Impl (Obj.all)'Access;
      if Name = "object_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Object_Id));
      elsif Name = "date" then
         return Util.Beans.Objects.Time.To_Object (Impl.Date);
      elsif Name = "counter" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Counter));
      elsif Name = "definition_id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Counter_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
      pragma Unreferenced (Session);
   begin
      Object.Object_Id := Stmt.Get_Identifier (0);
      Object.Date := Stmt.Get_Time (1);
      Object.Counter := Stmt.Get_Integer (2);
      Object.Set_Key_Value (Stmt.Get_Unbounded_String (3));
      ADO.Objects.Set_Created (Object);
   end Load;
   function Counter_Definition_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => COUNTER_DEFINITION_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Counter_Definition_Key;

   function Counter_Definition_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => COUNTER_DEFINITION_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Counter_Definition_Key;

   function "=" (Left, Right : Counter_Definition_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Counter_Definition_Ref'Class;
                        Impl   : out Counter_Definition_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Counter_Definition_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Counter_Definition_Ref) is
      Impl : Counter_Definition_Access;
   begin
      Impl := new Counter_Definition_Impl;
      Impl.Entity_Type := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Counter_Definition
   -- ----------------------------------------

   procedure Set_Name (Object : in out Counter_Definition_Ref;
                        Value : in String) is
      Impl : Counter_Definition_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 1, Impl.Name, Value);
   end Set_Name;

   procedure Set_Name (Object : in out Counter_Definition_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : Counter_Definition_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 1, Impl.Name, Value);
   end Set_Name;

   function Get_Name (Object : in Counter_Definition_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Name);
   end Get_Name;
   function Get_Name (Object : in Counter_Definition_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant Counter_Definition_Access
         := Counter_Definition_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Name;
   end Get_Name;


   procedure Set_Id (Object : in out Counter_Definition_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Counter_Definition_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 2, Value);
   end Set_Id;

   function Get_Id (Object : in Counter_Definition_Ref)
                  return ADO.Identifier is
      Impl : constant Counter_Definition_Access
         := Counter_Definition_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_Entity_Type (Object : in out Counter_Definition_Ref;
                              Value  : in ADO.Entity_Type) is
      Impl : Counter_Definition_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Entity_Type (Impl.all, 3, Impl.Entity_Type, Value);
   end Set_Entity_Type;

   function Get_Entity_Type (Object : in Counter_Definition_Ref)
                  return ADO.Entity_Type is
      Impl : constant Counter_Definition_Access
         := Counter_Definition_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity_Type;
   end Get_Entity_Type;

   --  Copy of the object.
   procedure Copy (Object : in Counter_Definition_Ref;
                   Into   : in out Counter_Definition_Ref) is
      Result : Counter_Definition_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Counter_Definition_Access
              := Counter_Definition_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Counter_Definition_Access
              := new Counter_Definition_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Name := Impl.Name;
            Copy.Entity_Type := Impl.Entity_Type;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Counter_Definition_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Counter_Definition_Access := new Counter_Definition_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Counter_Definition_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Counter_Definition_Access := new Counter_Definition_Impl;
      Found : Boolean;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
         raise ADO.Objects.NOT_FOUND;
      end if;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Load;

   procedure Load (Object  : in out Counter_Definition_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Counter_Definition_Access := new Counter_Definition_Impl;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
      else
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      end if;
   end Load;

   procedure Save (Object  : in out Counter_Definition_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Counter_Definition_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Counter_Definition_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : constant ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl /= null then
         Impl.Delete (Session);
      end if;
   end Delete;

   --  --------------------
   --  Free the object
   --  --------------------
   procedure Destroy (Object : access Counter_Definition_Impl) is
      type Counter_Definition_Impl_Ptr is access all Counter_Definition_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Counter_Definition_Impl, Counter_Definition_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Counter_Definition_Impl_Ptr := Counter_Definition_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Counter_Definition_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, COUNTER_DEFINITION_DEF'Access);
   begin
      Stmt.Execute;
      if Stmt.Has_Elements then
         Object.Load (Stmt, Session);
         Stmt.Next;
         Found := not Stmt.Has_Elements;
      else
         Found := False;
      end if;
   end Find;

   overriding
   procedure Load (Object  : in out Counter_Definition_Impl;
                   Session : in out ADO.Sessions.Session'Class) is
      Found : Boolean;
      Query : ADO.SQL.Query;
      Id    : constant ADO.Identifier := Object.Get_Key_Value;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Object.Find (Session, Query, Found);
      if not Found then
         raise ADO.Objects.NOT_FOUND;
      end if;
   end Load;

   procedure Save (Object  : in out Counter_Definition_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (COUNTER_DEFINITION_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_2_NAME, --  name
                          Value => Object.Name);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_2_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_2_NAME, --  entity_type
                          Value => Object.Entity_Type);
         Object.Clear_Modified (3);
      end if;
      if Stmt.Has_Save_Fields then
         Stmt.Set_Filter (Filter => "id = ?");
         Stmt.Add_Param (Value => Object.Get_Key);
         declare
            Result : Integer;
         begin
            Stmt.Execute (Result);
            if Result /= 1 then
               if Result /= 0 then
                  raise ADO.Objects.UPDATE_ERROR;
               end if;
            end if;
         end;
      end if;
   end Save;

   procedure Create (Object  : in out Counter_Definition_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (COUNTER_DEFINITION_DEF'Access);
      Result : Integer;
   begin
      Query.Save_Field (Name  => COL_0_2_NAME, --  name
                        Value => Object.Name);
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_1_2_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_2_2_NAME, --  entity_type
                        Value => Object.Entity_Type);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Counter_Definition_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (COUNTER_DEFINITION_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   --  ------------------------------
   --  Get the bean attribute identified by the name.
   --  ------------------------------
   overriding
   function Get_Value (From : in Counter_Definition_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Counter_Definition_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Counter_Definition_Impl (Obj.all)'Access;
      if Name = "name" then
         return Util.Beans.Objects.To_Object (Impl.Name);
      elsif Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "entity_type" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Entity_Type));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Counter_Definition_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Name := Stmt.Get_Unbounded_String (0);
      Object.Set_Key_Value (Stmt.Get_Identifier (1));
      Object.Entity_Type := ADO.Entity_Type (Stmt.Get_Integer (2));
      ADO.Objects.Set_Created (Object);
   end Load;


end AWA.Counters.Models;