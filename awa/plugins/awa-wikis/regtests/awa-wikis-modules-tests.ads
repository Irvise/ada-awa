-----------------------------------------------------------------------
--  awa-wikis-modules-tests -- Unit tests for wikis service
--  Copyright (C) 2015, 2017 Stephane Carrez
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

with Util.Tests;
with AWA.Tests;
with ADO;

package AWA.Wikis.Modules.Tests is

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite);

   type Test is new AWA.Tests.Test with record
      Manager    : AWA.Wikis.Modules.Wiki_Module_Access;
      Wiki_Id    : ADO.Identifier := ADO.NO_IDENTIFIER;
      Public_Id  : ADO.Identifier := ADO.NO_IDENTIFIER;
      Private_Id : ADO.Identifier := ADO.NO_IDENTIFIER;
   end record;

   --  Test creation of a wiki space.
   procedure Test_Create_Wiki_Space (T : in out Test);

   --  Test creation of a wiki page.
   procedure Test_Create_Wiki_Page (T : in out Test);

   --  Test creation of a wiki page content.
   procedure Test_Create_Wiki_Content (T : in out Test);

   procedure Test_Wiki_Page (T : in out Test);

end AWA.Wikis.Modules.Tests;
