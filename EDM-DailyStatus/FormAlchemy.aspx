<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormAlchemy.aspx.cs" Inherits="EDM_DailyStatus.FormAlchemy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- js alchemy -->
    <%--<script src="js_alchemy/alchemy.js"></script>--%>
    
    <%--   <script src="scripts/vendor.js"></script>--%>

    <!-- css bootstrap -->
    <link rel="stylesheet" href="css/bootstrap-4-navbar.css" />

    <!-- css alchemy -->
   <%-- <link rel="stylesheet" href="css_alchemy/alchemy-white.css" />--%>
   <%-- <link rel="stylesheet" href="css_alchemy/alchemy.css" />--%>
    <link rel="stylesheet" href="css_alchemy/alchemy.min.css" />
    <%-- <link rel="stylesheet" href="styles/vendor.css" />--%> 
    <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>

</head>
<body>
    <%--<script src="js_alchemy/alchemy.min.js"></script>--%>
    <script src="js_alchemy/alchemy.js"></script>
    <script>

        var config = {

            forceLocked: false,
            graphHeight: function () { return 400; },
            graphWidth: function () { return 400; },
            linkDistance: function () { return 40; },
            nodeTypes: {
                "node_type": ["Maintainer",
                    "Contributor"]
            },
            nodeCaption: function (node) {
                return node.caption + " " + node.fun_fact;
            }
        };

        var alchemy = new Alchemy(config)

          


    </script>

</body>
</html>



