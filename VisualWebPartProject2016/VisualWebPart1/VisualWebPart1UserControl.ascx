<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VisualWebPart1UserControl.ascx.cs" Inherits="VisualWebPartProject2016.VisualWebPart1.VisualWebPart1UserControl" %>

<div id="welcomeApp">    
    <div>
        <h3>Server Side People Picker</h3>
        <div>
            <asp:TextBox ID="txtTitle" runat="server" MaxLength="250"></asp:TextBox>
        </div>
        <h3>Viewers</h3>
        <div>
            <SharePoint:PeopleEditor ID="spPeoplePicker" Name="spPeoplePicker" runat="server" CssClass="ms-multiple-viewer" SelectionSet="User" />

            <SharePoint:ClientPeoplePicker ID="peoplePickerMultiple"
                                           Name="peoplePickerMultiple"
                                           ValidationEnabled="true"                                           
                                           VisibleSuggestions="5"                                           
                                           MaximumEntities="10"
                                           AllowMultipleEntities="True"
                                           Width="80%"
                                           Rows="3"                                           
                                           Required="true"
                                           runat="server" />
    
            <SharePoint:ClientPeoplePicker ID="peoplePickerSingle"
                                           Name="peoplePickerSingle"
                                           ValidationEnabled="true"                                           
                                           VisibleSuggestions="5"                                           
                                           MaximumEntities="10"
                                           AllowMultipleEntities="False"
                                           Width="80%"
                                           Rows="3"                                           
                                           Required="true"
                                           runat="server" />
        </div>
        <div>
            <asp:Button runat="server" Text="Save" OnClick="Save_Click"></asp:Button>
        </div>
    </div>

</div>


<div id="welcomeApp" ng-app="app">    
    <div>
        <h3>Client Side People Picker</h3>
    </div>       
    <div ng-controller="appCtrlr as vm">
        <div id="peoplePickerDivAP" data-ng-disabled="{{false}}" ui-people ng-model="vm.data.mu" pp-is-multiuser="{{true}}" pp-width="100%" pp-account-type="User" pp-web-url="{{vm.webUrl}}"></div>
    </div>
</div>


<!-- Load third party scripts required by the people picker -->
<script type="text/ecmascript" src="/_layouts/15/SP.UI.Controls.js"></script>
<script type="text/ecmascript" src="/_layouts/15/clienttemplates.js"></script>
<script type="text/ecmascript" src="/_layouts/15/clientforms.js"></script>
<script type="text/ecmascript" src="/_layouts/15/clientpeoplepicker.js"></script>
<script type="text/ecmascript" src="/_layouts/15/autofill.js"></script>
<script type="text/ecmascript" src="/_layouts/15/sp.RequestExecutor.js"></script>

<!-- AngularJS-->
<script type="text/javascript" src="/Style%20Library/SiteAssets/libs/angular/angular.min.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/libs/angular/angular-resource.min.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/libs/angular/angular-sanitize.min.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/libs/angular/angular-route.min.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/apps/peoplePicker/app.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/apps/peoplePicker/config.peoplepicker.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/apps/peoplePicker/controllers.js"></script>

<style>
    /* People Picker Modifications */
    div#strk .sp-peoplepicker-autoFillContainer{
	    z-index: 20;
	    background-color:#fff;
    }
    div#strk .sp-peoplepicker-topLevel{
	    background-color:#fff;
    }
    div#strk .sp-peoplepicker-topLevel{
	    min-height: 100px;
    }

    div#peoplePicker_peoplePickerDivAP_TopSpan {
        width: 80%;
        min-height: 100px;
    }
    input#peoplePicker_peoplePickerDivAP_TopSpan_EditorInput{
        border: none;
    }
</style>