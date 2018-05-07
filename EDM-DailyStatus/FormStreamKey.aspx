<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormStreamKexy.aspx.cs" Inherits="EDM_DailyStatus.FormStreamKexy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>


    <!-- lib for Data table -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css" rel="stylesheet" />




    <!-- js and css for multi dropdown menu -->
    <script src="js/bootstrap-4-navbar.js"></script>
    <link rel="stylesheet" href="css/bootstrap-4-navbar.css" />



    <style>
        .bd-content {
            padding: 1.5rem;
            margin-right: 0;
            margin-left: 0;
            border-width: .2rem;
        }

        .btn-custom {
            font-size: 11px !important;
            width: 72px !important;
            height: 30px !important;
        }
    </style>
    <title></title>
</head>
<body style="padding-top: 70px;" class="bg-light">
     <form id="form_streamkey" runat="server">
    <div class="container-fluid">
        <!-- --- menu bar ---->
        <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Service Management</a>
            <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="navbar-collapse offcanvas-collapse align-items-center" id="navbarsExampleDefault">
                <ul class="navbar-nav mr-auto px-3">
                    <li class="nav-item">
                        <a class="nav-link" href="FormMain.aspx"><i class="fa fa-home">&nbsp;Main   </i></a>
                    </li>
                    <li class="nav-item dropdown px-3">
                        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"><i class="fa fa-dashboard"></i>&nbsp; Dashboard Management</a>
                        <ul class="dropdown-menu" aria-labelledby="dropdown01">
                            <li><a class="dropdown-item dropdown-toggle">EDM</a>
                                <ul class="dropdown-menu" style="top: 104px; left: 156px;">
                                    <li><a class="dropdown-item dropdown-toggle" href="#">Report</a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#">Daily</a></li>
                                            <li><a class="dropdown-item" href="#">Historical</a></li>
                                        </ul>
                                    </li>
                                    <li><a class="dropdown-item" href="FormLogging.aspx">Logging</a></li>
                                    <li><a class="dropdown-item" href="#">Fix Problem</a></li>



                                    <li><a class="dropdown-item dropdown-toggle" href="#">Utility</a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#">File Landing</a></li>
                                            <li><a class="dropdown-item" href="#">Dependency</a></li>
                                        </ul>
                                    </li>
                                </ul>

                            </li>

                            <li><a class="dropdown-item">EDW</a></li>
                            <li><a class="dropdown-item">SAS</a></li>
                            <li><a class="dropdown-item">BIG & DV</a></li>

                        </ul>

                    </li>
                    <li class="nav-item dropdown px-3">
                        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"><i class="fa fa-retweet">&nbsp;MA</i></a>
                        <div class="dropdown-menu" aria-labelledby="dropdown01">
                            <a class="dropdown-item">Backup</a>
                            <a class="dropdown-item">Clear Log</a>
                        </div>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa fa-sign-in">&nbsp;Sign in   </i></a>
                    </li>
                </ul>
            </div>
        </nav>

          <!------ Popup Msg------>
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <asp:Literal ID="Ltl_Popup_msg" runat="server"></asp:Literal>
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
                            <asp:TextBox ID="txt_StreamName_popup" runat="server" class="form-control" placeholder="Stream name" Visible="false"></asp:TextBox>
                        </div>
                        <asp:Button ID="btn_GetStreamStatus_popup" runat="server" Text="Get Stream Status" CssClass="btn btn-success" Visible="false" />
                    </div>
                </div>
            </div>

        <div class="row">
            <div class="col-sm">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-12 form-group">                                
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#dvEDMStatus">EDM status&nbsp;<span id="iStatusCountEDM" class="badge" runat="server"></span></a></li>
                                    <li><a data-toggle="tab" href="#dvSpecialStatus">Special status&nbsp;<span id="iSpecialCountStatus" class="badge" runat="server" style="background-color: #FF0000;"></span></a></li>
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
                                                <%--<asp:Literal ID="lt_GroupTable" runat="server"></asp:Literal>--%>
                                                <asp:Literal ID="lt_groupTbAllStreamKey" runat="server"></asp:Literal>
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
                                                <asp:Literal ID="lt_GroupTableSpecialStatus" runat="server"></asp:Literal>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- dvSpecialStatus -->
                                </div>
                                <!-- tab -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>


    </div>

   
    </form>
</body>
</html>
