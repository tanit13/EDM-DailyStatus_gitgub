<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="solutionToFix.aspx.cs" Inherits="EDM_DailyStatus.solutionToFix" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EDM-Daily Status</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0" />
    <link rel="shortcut icon" href="images/atom.ico" />

    <link href="css/bootstrap.css" rel="stylesheet" />


    <script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/popmenu.css" rel="stylesheet" />

    <script src="js/general.js" type="text/javascript"></script>
    <link href="css/control-style.css" rel="stylesheet" />
    <link href="css/callout.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script type="text/javascript" src="js/html5.js"></script>
    <script type="text/javascript" src="js/respond.js"></script>
    <![endif]-->

    <script src="js/html2canvas.min.js"></script>

    <script src="js/viz.js"></script>

    <script src="highchart/highcharts.js"></script>
    <script src="highchart/highcharts-3d.js"></script>
    <script src="highchart/modules/exporting.js"></script>


    <script type="text/javascript">
        function ConvertToImage(btnExport) {
            html2canvas($("#dvDepenApp")[0]).then(function (canvas) {
                var base64 = canvas.toDataURL();
                $("[id*=hfImageData]").val(base64);
                __doPostBack(btnExport.name, "");
            });
            return false;
        }
    </script>
    <style>
        .button {
            border: none;
            color: white;
            padding: 9px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            max-height: 5px;
            border-radius: 50%;
        }

        .button1 {
            border-radius: 2px;
        }

        .button2 {
            border-radius: 4px;
        }

        .button3 {
            background-color: Chartreuse;
        }

        .button4 {
            background-color: orange;
        }

        .button5 {
            background-color: red; /* Green */
        }

        .content {
            max-width: 500px;
            margin: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <!------ Popup Msg------>
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <asp:Literal ID="Ltl_Popup" runat="server"></asp:Literal>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------ Popup ------>
            <div class="col-lg-12">
                <b>
                    <h3><i class="fa fa-laptop" aria-hidden="true"></i> EIM-PRODUCTION SUPPORT </h3>
                </b>

                <div class="form-inline">
                    <div class="form-group">
                        <asp:TextBox ID="txt_errorJob" runat="server" class="form-control" placeholder="Error Stream_Key" Visible="true"></asp:TextBox>
                    </div>
                    <asp:Button ID="btn_Getjob" runat="server" Text="Cilck to Fix Error" CssClass="btn btn-success" Visible="true" />
                </div>
            </div>

            <div class="row content">
                <img src="images/ConstructionPage.png" />
            </div>
        </div>
    </form>
</body>
</html>
