-----------------------------------------------------------------------
--  awa-sysadmin-modules -- Module sysadmin
--  Copyright (C) 2019 Stephane Carrez
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
with ASF.Applications;

with AWA.Modules;
private with Servlet.Core.Rest;
private with AWA.Sysadmin.Filters;
package AWA.Sysadmin.Modules is

   --  The name under which the module is registered.
   NAME : constant String := "sysadmin";

   --  ------------------------------
   --  Module sysadmin
   --  ------------------------------
   type Sysadmin_Module is new AWA.Modules.Module with private;
   type Sysadmin_Module_Access is access all Sysadmin_Module'Class;

   --  Initialize the sysadmin module.
   overriding
   procedure Initialize (Plugin : in out Sysadmin_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config);

   --  Get the sysadmin module.
   function Get_Sysadmin_Module return Sysadmin_Module_Access;

private

   type Sysadmin_Module is new AWA.Modules.Module with record
      API_Servlet : aliased Servlet.Core.Rest.Rest_Servlet;
      API_Filter  : aliased AWA.Sysadmin.Filters.Auth_Filter;
   end record;

end AWA.Sysadmin.Modules;
