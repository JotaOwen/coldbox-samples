<!-----------------------------------------------------------------------Author 	 :	Your NameDate     :	September 25, 2005Description : 				This is a ColdBox event handler for general methods.Please note that the extends needs to point to the eventhandler.cfcin the ColdBox system directory.extends = coldbox.system.EventHandler	-----------------------------------------------------------------------><cfcomponent name="general" extends="coldbox.system.EventHandler" output="false">		<!--- This init format is mandatory if you are writing init code else is optional, 	      include the super.init(arguments.controller). 	<cffunction name="init" access="public" returntype="any" output="false">		<cfargument name="controller" type="any">		<cfset super.init(arguments.controller)>		<!--- Any constructor code here --->		<cfreturn this>	</cffunction>	--->	<cffunction name="index" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<cfscript>			var rc = event.GetCollection();						rc.cfcViewer = getPlugin("cfcViewer").setup(dirpath="/coldbox/system",dirLink="#getSetting('sesBaseURL')#/general?");						event.setView("home");		</cfscript>	</cffunction>		<cffunction name="output" access="public" returntype="void" output="false">		<cfargument name="Event" type="any">		<cfset var dir = expandPath('./output/')>		<Cfset var rc = event.getCollection()>				<!--- Create output Directory --->		<cfif directoryExists(dir)>			<cfdirectory action="delete" directory="#dir#" recurse="true">		</cfif>				<cfdirectory action="create" directory="#dir#">				<cfscript>			rc.cfcviewer = getPlugin("cfcViewer").setup(dirpath="/coldbox/system",dirLink="index.html");			rc.aPacks = rc.cfcviewer.getaPacks();						//Write Root Package			event.setView('home');			rc.content = getPlugin("renderer").renderLayout();									/* Parse rc.content */			rc.content = cleanContent(rc.content);							/* Output content */			getPlugin("Utilities").saveFile(dir & "index.html", rc.content);						/* Loop through packages */			for( rc.x = 1; rc.x lte ArrayLen(rc.aPacks); rc.x = x + 1){				/* Set Package */				rc._cfcviewer_package =reReplacenocase(rc.aPacks[rc.x],"\s\(\d*\)$","");				rc._cfcviewer_package = replace(rc._cfcviewer_package,".","/","all");								rc.cfcViewer = rc.cfcviewer.setup(dirpath="/coldbox/system",dirLink="index.html");				rc.content = getPlugin("renderer").renderLayout();										/* Parse rc.content */				rc.content = cleanContent(rc.content);									/* Output content */				getPlugin("Utilities").saveFile(dir & "#replace(rc._cfcviewer_package,"/",".","all")#.html", rc.content); 			}				</cfscript>						<cfdirectory action="create" directory="#dir#includes">		<Cffile action="copy" source="#expandPath('includes/poweredby_120.gif')#" destination="#dir#includes">				<!--- No Render --->		<cfset event.noRender(true)>	</cffunction>		<cffunction name="cleanContent" access="private" returntype="any" hint="clean content" output="true" >		<cfargument name="content" required="true" type="any" hint="">
		<cfscript>		var x = 1;		var matches = ArrayNew(1);		var newcontent = "";				newcontent  = replace(content,"%2F", ".","all");		matches = rematchnocase("index.html&_cfcviewer_package=[a-zA-Z][^=""]*", newcontent);		for(x=1; x lte arrayLen(matches); x = x + 1){			newcontent = replacenocase(newcontent, matches[x], listlast(matches[x],"=") & ".html");		}		return newcontent;		</cfscript>	</cffunction>	</cfcomponent>