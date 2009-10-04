<!-----------------------------------------------------------------------********************************************************************************Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corpwww.coldboxframework.com | www.luismajano.com | www.ortussolutions.com********************************************************************************Author      :	Sana UllahDate        :	March 05 2008Description :	General events like contact-user, privacy, home page etc.-----------------------------------------------------------------------><cfcomponent name="ehGeneral" extends="coldbox.system.EventHandler" output="false">		<!--- This init format is mandatory if you are writing init code else is optional, include the super.init(arguments.controller). ---> 	<cffunction name="init" access="public" returntype="any" output="false">		<cfargument name="controller" type="any">		<cfset super.init(arguments.controller)>		<!--- Any constructor code here --->		<cfreturn this>	</cffunction>	<cffunction name="index" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<!--- Do Your Logic Here to prepare a view --->		<cfset Event.setValue("welcomeMessage","Welcome to ColdBox!")>			<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwHome")>	</cffunction>	</cfcomponent>