<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EDM_DailyStatus.Default" %>

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

    <link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet" />
    <script src="jquery-ui-1.12.1/jquery-ui.min.js"></script>
    <link href="jquery-ui-1.12.1/jquery-ui.theme.css" rel="stylesheet" />

    <script src="js/html2canvas.min.js"></script>


    <script type="text/javascript">
        function ConvertToImage(btnExport) {
            html2canvas($("#dvEDMStatus")[0]).then(function (canvas) {
                var base64 = canvas.toDataURL();
                $("[id*=hfImageData]").val(base64);
                __doPostBack(btnExport.name, "");
            });
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <!------ Popup Confirm Form------>
            <div class="modal fade" id="myModalConfirmSub" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Please Login TD.
                            </h4>
                        </div>
                        <div class="modal-body">

                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">Username</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txt_User" runat="server" CssClass="form-control" data-toggle="tooltip" data-placement="top" title="Username" placeholder="Username"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txt_Pass" runat="server" TextMode="Password" CssClass="form-control" data-toggle="tooltip" data-placement="top" title="Password" placeholder="Password"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btn_Confirm" runat="server" Text="Login" CssClass="btn btn-success btn-sm" OnClick="btn_Confirm_Click" />
                            <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">
                                Cancel</button>
                        </div>
                    </div>
                </div>
            </div>

            <!------ Popup ------>

            <div class="row">
                <div class="col-lg-11">
                    <h3><i class="fa fa-laptop" aria-hidden="true"></i>EDM DAILY STATUS</h3>
                </div>
                <div class="col-lg-1">
                    <h3>
                        <asp:LinkButton ID="lnk_Logout" runat="server" OnClick="lnk_Logout_Click" Visible="false">Logout</asp:LinkButton>
                        <asp:LinkButton ID="lnk_Login" runat="server" OnClick="lnk_Login_Click">Login</asp:LinkButton>
                    </h3>
                </div>
            </div>

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

            <%--            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">EDM Daily Status</a></li>
                <li><a data-toggle="tab" href="#menu1">EDM Stream Dependency</a></li>

            </ul>--%>

            <div class="tab-content">
                <div class="panel panel-default" style="font-weight: bold; margin-bottom: 1px;">
                    <div id="pn_footer" class="panel-heading" style="text-align: center; font-size: 14px;">
                        <asp:Literal ID="lt_footer" runat="server"></asp:Literal>
                    </div>
                </div>
                <div id="home" class="tab-pane fade in active">
                    <p>
                        <div class="panel panel-primary col-md-6">
                            <div class="panel-heading" style="font-weight: bold;">TIER_1</div>
                            <div id="dvTire1" class="panel-body" style="padding-left: 0px; padding-right: 0px; min-height: 550px;">
                                <asp:Literal ID="lt_Tier1" runat="server"></asp:Literal>
                                <script>
                                    //document.body.innerHTML
                                    //document.getElementById("dvTire1").innerHTML += ("<button type='button' onclick=\"window.open('http://www.plus2net.com/')\" >Link</button>  <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;' title='T1_BTMU&#13;MIN : 2017-06-27&#13;MAX : 2017-06-27&#13;Stream: 16&#13;Percent: 100%'>T1_BTMU</button> <button type='button' class='btn-lg btn-warning' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_BANC</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_ATM</button> <button type='button' class='btn-lg btn-danger' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_CLS</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_SIERRA</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;' title='T1_BTMU&#13;MIN : 2017-06-27&#13;MAX : 2017-06-27&#13;Stream: 16&#13;Percent: 100%'>T1_BBS</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_ALSCOM</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_SIERRA</button>")

                                </script>
                            </div>
                        </div>

                        <div class="panel panel-primary col-md-3">
                            <div class="panel-heading" style="font-weight: bold;">TIER_2</div>
                            <div id="dvTire2" class="panel-body" style="padding-left: 0px; padding-right: 0px; min-height: 550px;">
                                <asp:Literal ID="lt_Tier2" runat="server"></asp:Literal>
                            </div>
                        </div>

                        <div class="panel panel-primary col-md-3">
                            <div class="panel-heading" style="font-weight: bold;">TIER_3</div>
                            <div id="dvTire3" class="panel-body" style="padding-left: 0px; padding-right: 0px; min-height: 550px;">
                                <asp:Literal ID="lt_Tier3" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </p>
                </div>

                <%--                <div id="menu1" class="tab-pane fade">
                    <p>
                        <button type='button' onclick="window.open('http://www.plus2net.com/')" >Link</button> 
                        
                        <button type="button" onclick="location.href='http://www.stackoverflow.com'">ABC</button>
                    </p>
                </div>--%>
            </div>
    </form>
</body>
</html>
