-----------------------------------------------------------------------
--  awa-events -- AWA Events
--  Copyright (C) 2012, 2015 Stephane Carrez
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

package body AWA.Events is

   --  ------------------------------
   --  Set the event type which identifies the event.
   --  ------------------------------
   procedure Set_Event_Kind (Event : in out Module_Event;
                             Kind  : in Event_Index) is
   begin
      Event.Kind := Kind;
   end Set_Event_Kind;

   --  ------------------------------
   --  Get the event type which identifies the event.
   --  ------------------------------
   function Get_Event_Kind (Event : in Module_Event) return Event_Index is
   begin
      return Event.Kind;
   end Get_Event_Kind;

   --  ------------------------------
   --  Set a parameter on the message.
   --  ------------------------------
   procedure Set_Parameter (Event  : in out Module_Event;
                            Name   : in String;
                            Value  : in String) is
   begin
      Event.Props.Include (Name, Util.Beans.Objects.To_Object (Value));
   end Set_Parameter;

   --  ------------------------------
   --  Get the parameter with the given name.
   --  ------------------------------
   function Get_Parameter (Event : in Module_Event;
                           Name  : in String) return String is
      Pos : constant Util.Beans.Objects.Maps.Cursor := Event.Props.Find (Name);
   begin
      if Util.Beans.Objects.Maps.Has_Element (Pos) then
         return Util.Beans.Objects.To_String (Util.Beans.Objects.Maps.Element (Pos));
      else
         return "";
      end if;
   end Get_Parameter;

   --  ------------------------------
   --  Get the value that corresponds to the parameter with the given name.
   --  ------------------------------
   function Get_Value (Event : in Module_Event;
                       Name  : in String) return Util.Beans.Objects.Object is
   begin
      if Event.Props.Contains (Name) then
         return Event.Props.Element (Name);
      else
         return Util.Beans.Objects.Null_Object;
      end if;
   end Get_Value;

   --  ------------------------------
   --  Get the entity identifier associated with the event.
   --  ------------------------------
   function Get_Entity_Identifier (Event : in Module_Event) return ADO.Identifier is
   begin
      return Event.Entity;
   end Get_Entity_Identifier;

   --  ------------------------------
   --  Set the entity identifier associated with the event.
   --  ------------------------------
   procedure Set_Entity_Identifier (Event : in out Module_Event;
                                    Id    : in ADO.Identifier) is
   begin
      Event.Entity := Id;
   end Set_Entity_Identifier;

   --  ------------------------------
   --  Copy the event properties to the map passed in <tt>Into</tt>.
   --  ------------------------------
   procedure Copy (Event : in Module_Event;
                   Into  : in out Util.Beans.Objects.Maps.Map) is
   begin
      Into := Event.Props;
   end Copy;

   --  ------------------------------
   --  Make and return a copy of the event.
   --  ------------------------------
   function Copy (Event : in Module_Event) return Module_Event_Access is
      Result : constant Module_Event_Access := new Module_Event;
   begin
      Result.Kind := Event.Kind;
      Result.Props := Event.Props;
      return Result;
   end Copy;

end AWA.Events;
