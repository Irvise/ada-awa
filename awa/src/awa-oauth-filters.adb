-----------------------------------------------------------------------
--  awa-oauth-filters -- OAuth filter
--  Copyright (C) 2017 Stephane Carrez
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
with Security;
with Security.OAuth.Servers;
with Util.Beans.Objects;
with ASF.Principals;
with AWA.Applications;
with AWA.Services.Contexts;
package body AWA.OAuth.Filters is

   --  Initialize the filter.
   overriding
   procedure Initialize (Filter  : in out Auth_Filter;
                         Config  : in ASF.Servlets.Filter_Config) is
   begin
      null;
   end Initialize;

   function Get_Access_Token (Req : in ASF.Requests.Request'Class) return String is
   begin
      return "";
   end Get_Access_Token;

   --  The Do_Filter method of the Filter is called by the container each time
   --  a request/response pair is passed through the chain due to a client request
   --  for a resource at the end of the chain.  The Filter_Chain passed in to this
   --  method allows the Filter to pass on the request and response to the next
   --  entity in the chain.
   --
   --  Before passing the control to the next filter, initialize the service
   --  context to give access to the current application, current user and
   --  manage possible transaction rollbacks.
   overriding
   procedure Do_Filter (F        : in Auth_Filter;
                        Request  : in out ASF.Requests.Request'Class;
                        Response : in out ASF.Responses.Response'Class;
                        Chain    : in out ASF.Servlets.Filter_Chain) is
      use type AWA.OAuth.Services.Auth_Manager_Access;

      use type ASF.Principals.Principal_Access;

      type Context_Type is new AWA.Services.Contexts.Service_Context with null record;

      --  Get the attribute registered under the given name in the HTTP session.
      overriding
      function Get_Session_Attribute (Ctx  : in Context_Type;
                                      Name : in String) return Util.Beans.Objects.Object;

      --  Set the attribute registered under the given name in the HTTP session.
      overriding
      procedure Set_Session_Attribute (Ctx   : in out Context_Type;
                                       Name  : in String;
                                       Value : in Util.Beans.Objects.Object);

      overriding
      function Get_Session_Attribute (Ctx  : in Context_Type;
                                      Name : in String) return Util.Beans.Objects.Object is
         pragma Unreferenced (Ctx);
      begin
         return Request.Get_Session.Get_Attribute (Name);
      end Get_Session_Attribute;

      --  Set the attribute registered under the given name in the HTTP session.
      overriding
      procedure Set_Session_Attribute (Ctx   : in out Context_Type;
                                       Name  : in String;
                                       Value : in Util.Beans.Objects.Object) is
         pragma Unreferenced (Ctx);
         S : ASF.Sessions.Session := Request.Get_Session;
      begin
         S.Set_Attribute (Name, Value);
      end Set_Session_Attribute;

      App : constant ASF.Servlets.Servlet_Registry_Access
        := ASF.Servlets.Get_Servlet_Context (Chain);
      Bearer : constant String := Get_Access_Token (Request);
      Auth   : Security.Principal_Access;
      Grant  : Security.OAuth.Servers.Grant_Type;
   begin
      if F.Realm = null then
         return;
      end if;
      F.Realm.Authenticate (Bearer, Grant);

      declare
         Context     : aliased Context_Type;
         Application : AWA.Applications.Application_Access;
      begin
         --  Get the application
         if App.all in AWA.Applications.Application'Class then
            Application := AWA.Applications.Application'Class (App.all)'Access;
         else
            Application := null;
         end if;
--         Context.Set_Context (Application, Grant.Auth);
         
         --  Give the control to the next chain up to the servlet.
         ASF.Servlets.Do_Filter (Chain    => Chain,
                                 Request  => Request,
                                 Response => Response);

         --  By leaving this scope, the active database transactions are rollbacked
         --  (finalization of Service_Context)
      end;
   end Do_Filter;

end AWA.OAuth.Filters;
