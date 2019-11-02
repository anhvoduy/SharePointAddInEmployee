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
            <%--<SharePoint:PeopleEditor ID="spPeoplePicker" runat="server" CssClass="ms-multiple-viewer" SelectionSet="User" />--%>
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

<script type="text/javascript" src="/Style%20Library/SiteAssets/libs/angular/angular.min.js"></script>
<script type="text/javascript" src="/Style%20Library/SiteAssets/apps/welcomeAngular/welcomeAngular.js"></script>
