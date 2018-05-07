<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StreamKey.aspx.cs" Inherits="EDM_DailyStatus.StreamKey" %>

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


            <div class="row">
                <div class="col-lg-12"> 
                    <b>
                        <h3><i class="fa fa-laptop" aria-hidden="true"></i>EDM DAILY STATUS </h3>
                    </b>

                    <div class="form-inline">
                        <div class="form-group">
                            <asp:TextBox ID="txt_StreamName" runat="server" class="form-control" placeholder="Stream name" Visible="false"></asp:TextBox>
                        </div>
                        <asp:Button ID="btn_GetStreamStatus" runat="server" Text="Get Stream Status" CssClass="btn btn-success" Visible="false" />
                    </div>
                </div>
            </div>
            <!-- Main -->
            <div class="row">
                <div class="col-lg-12 form-group">
<%--                
                    <hr />
                    <div class="col-lg-12 form-group">
                    <asp:GridView ID="GV_Test1" runat="server" BackColor="White" PageSize="20" AllowPaging="True" 
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" 
                        GridLines="Horizontal" OnPageIndexChanging="GV_Test_PageIndexChanging">
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="#333333" ForeColor="White" Font-Bold="True" Width="1000px" Wrap="False" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                        <SortedDescendingHeaderStyle BackColor="#242121" />
                    </asp:GridView> 
                    <hr />                        
                    <asp:GridView ID="GV_Test" runat="server"
                        CssClass="table table-hover table-striped" GridLines="None"
                        AutoGenerateColumns="True">
                        <RowStyle CssClass="cursor-pointer" />
                    </asp:GridView>
--%>
                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#dvEDMStatus">EDM status&nbsp;<span id="iStatusCount" class="badge" runat="server"></span></a></li>
                        <li><a data-toggle="tab" href="#dvSpecialStatus">Special status&nbsp;<span id="iSpecialCount" class="badge" runat="server" style="background-color:#FF0000;"></span></a></li>
                    </ul>
                    <!-- tab -->
                    <div class="tab-content" style="padding-left: 15px; padding-right: 15px;">
                        <!-- dvEDMStatus -->
                        <div id="dvEDMStatus" class="tab-pane fade in active">
                            <table class="table table-hover" style="font-size: 14px; font-family: arial, sans-serif;">
                                <thead>
                                    <tr style="font-size: 16px; font-weight: bold;">
                                        <th>Status</th>
                                        <th>Stream_Key</th>
                                        <th>Stream_Name</th>
                                        <th>Group</th>
                                        <th>Business_Date</th>
                                        <th>Start_Time</th>
                                        <th>End_Time</th>
                                        <th>ESP App</th>
                                    </tr>
                                </thead>
                                <tbody>
<%--                            
                                    <tr>
                                        <td><asp:Button runat="server" Class="button" Style="background-color: red;" /></td>
                                        <td>Mark</td>
                                        <td>Otto</td>
                                        <td>Test</td>
                                        <td>@mdo</td>
                                        <td>Mark</td>
                                        <td>Otto</td>
                                        <td>@mdo</td>
                                    </tr>
--%>
                                    <asp:Literal ID="lt_GroupTable" runat="server"></asp:Literal>
                                </tbody>
                            </table>
                        </div>
                        <!-- dvEDMStatus -->
                        <!-- dvSpecialStatus -->
                        <div id="dvSpecialStatus" class="tab-pane fade">
                            <table class="table table-hover" style="font-size: 14px; font-family: arial, sans-serif;">
                                <thead>
                                    <tr style="font-size: 16px; font-weight: bold;">
                                        <th>Status</th>
                                        <th>Stream_Key</th>
                                        <th>Stream_Name</th>
                                        <th>Group</th>
                                        <th>Business_Date</th>
                                        <th>Start_Time</th>
                                        <th>End_Time</th>
                                        <th>ESP App</th>
                                    </tr>
                                </thead>
                                <tbody>
<%--                            
                                    <tr>
                                        <td><asp:Button runat="server" Class="button" Style="background-color: red;" /></td>
                                        <td>Mark</td>
                                        <td>Otto</td>
                                        <td>Test</td>
                                        <td>@mdo</td>
                                        <td>Mark</td>
                                        <td>Otto</td>
                                        <td>@mdo</td>
                                    </tr>
--%>
                                    <asp:Literal ID="lt_GroupTableSpecial" runat="server"></asp:Literal>
                                </tbody>
                            </table>
                        </div>
                        <!-- dvSpecialStatus -->
                    </div>
                    <!-- tab -->
                </div>
            </div>
            <!-- Main -->
        </div>
    </form>
</body>
</html>
