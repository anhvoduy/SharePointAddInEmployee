<%-- The following 4 lines are ASP.NET directives needed when using SharePoint components --%>

<%@ Page Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" MasterPageFile="~masterurl/default.master" Language="C#" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%-- The markup and script in the following Content element will be placed in the <head> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <!-- jquery -->
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>

    <!-- bootstrap -->
    <link rel="Stylesheet" type="text/css" href="../Content/bootstrap/css/bootstrap.min.css" />
    <script type="text/javascript" src="../Content/bootstrap/js/bootstrap.min.js"></script>

    <!-- angularjs -->
    <script type="text/javascript" src="../Content/angularjs/angular.min.js"></script>
    <script type="text/javascript" src="../Content/angularjs/angular-resource.min.js"></script>
    <script type="text/javascript" src="../Content/angularjs/angular-route.min.js"></script>
    <script type="text/javascript" src="../Content/angularjs/angular-cookies.min.js"></script>
    <script type="text/javascript" src="../Content/angularjs/angular-sanitize.min.js"></script>
    <script type="text/javascript" src="../Content/angularjs/angular-touch.min.js"></script>
    <script type="text/javascript" src="../Content/angularjs/angular-animate.min.js"></script>

    <!-- momentjs -->
    <script type="text/javascript" src="../Content/momentjs/moment.min.js"></script>
    
    <!-- sharepoint -->
    <SharePoint:ScriptLink name="sp.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <meta name="WebPartPageExpansion" content="full" />

    <!-- Add your CSS styles to the following file -->
    <link rel="Stylesheet" type="text/css" href="../Content/App.css" />

    <!-- Add your JavaScript to the following file -->
    <script type="text/javascript" src="../Scripts/App.js"></script>
    <script type="text/javascript" src="../Scripts/AppDocument.js"></script>
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    SharePoint App Documents
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div class="container">
        <div id="appDocument">
            <div search-container>
                <!-- The following content will be replaced with the user name when you run the app - see App.js -->
                initializing...
            </div>
        </div>
        <div id="message">
            <!-- The following content will be replaced with the user name when you run the app - see App.js -->
            App is initializing...
        </div>
    </div>
</asp:Content>
