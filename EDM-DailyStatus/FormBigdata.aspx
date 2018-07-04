<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormBigdata.aspx.cs" Inherits="EDM_DailyStatus.FormBigdata" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Big Data & DV</title>
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

    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>

    <!-- js and css for multi dropdown menu -->
    <script src="js/bootstrap-4-navbar.js"></script>
    <link rel="stylesheet" href="css/bootstrap-4-navbar.css" />


    <script type="text/javascript" src="js/js_common.js"></script>

    <asp:Literal ID="lt_json_bigmonitorAll" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_bigmonitorComplete" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_bigmonitorError" runat="server"></asp:Literal>

    <asp:Literal ID="lt_json_dv_all" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_dv_complete" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_dv_error" runat="server"></asp:Literal>

    <asp:Literal ID="lt_json_bigdv" runat="server"></asp:Literal>

    <script>
        $(document).ready(function () {
            var jsonBigMonitorAll = va_bigmonitora_all;
            var jsonBigMonitorConplete = va_bigmonitora_complete;
            var jsonBigMonitorError = va_bigmonitora_error;

            var jsonDvMonitorAll = va_dv_all;
            var jsonDvMonitorConplete = va_dv_complete;
            var jsonDvMonitorError = va_dv_error;

            var jsonMonitorStatus = va_monitor_status;

            var column_big_monitor = [
                { data: 'Status' },
                { data: 'Work_name' },
                { data: 'First_supportor_id' },
                { data: 'Sla' },
                { data: 'Process_no' },
                { data: 'Process_id' },
                { data: 'Frequency' },
                { data: 'Business_date' },
                { data: 'Process_start_ts' },
                { data: 'Process_end_ts' }
            ];

            var column_dv_monitor = [
                { data: 'Status' },
                { data: 'Work_name' },
                { data: 'Sla' },
                { data: 'Frequency' },
                { data: 'Asofdate' },
                { data: 'Process_start_ts' },
                { data: 'Process_end_ts' }
            ];

            var column_bigdv = [
                { data: 'Work_name' },
                { data: 'Batch_name' },
                { data: 'Pg' },
                { data: 'Completed' },
                { data: 'Failed' },
                { data: 'Total' }
            ];

            var tbl_big_all = $('#tbl_big_all').DataTable({ columns: column_big_monitor });
            var tbl_big_complete = $('#tbl_big_complete').DataTable({ columns: column_big_monitor });
            var tbl_big_error = $('#tbl_big_error').DataTable({ columns: column_big_monitor });

            if (jsonBigMonitorAll != "")
                $('#tbl_big_all').dataTable().fnAddData(jsonBigMonitorAll);

            if (jsonBigMonitorConplete != "")
                $('#tbl_big_complete').dataTable().fnAddData(jsonBigMonitorConplete);

            if (jsonBigMonitorError != "")
                $('#tbl_big_error').dataTable().fnAddData(jsonBigMonitorError);


            var tbl_dv_all = $('#tbl_dv_all').DataTable({ columns: column_dv_monitor });
            var tbl_dv_complete = $('#tbl_dv_complete').DataTable({ columns: column_dv_monitor });
            var tbl_vd_error = $('#tbl_dv_error').DataTable({ columns: column_dv_monitor });

            if (jsonDvMonitorAll != "")
                $('#tbl_dv_all').dataTable().fnAddData(jsonDvMonitorAll);

            if (jsonDvMonitorConplete != "")
                $('#tbl_dv_complete').dataTable().fnAddData(jsonDvMonitorConplete);

            if (jsonDvMonitorError != "")
                $('#tbl_dv_error').dataTable().fnAddData(jsonDvMonitorError);


            var tbl_monitor_status = $('#tbl_monitor_status').DataTable({ columns: column_bigdv });
             (jsonMonitorStatus != "")
                $('#tbl_monitor_status').dataTable().fnAddData(jsonMonitorStatus);

        });
    </script>

    <style>
        .button_status {
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

        a.menu-links {
            cursor: pointer;
        }
    </style>
</head>
<body style="padding-top: 70px;" class="bg-light">

    <div class="container-fluid">
        <!-- menu bar -->
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

        <!-- end menu bar -->

        <%--<form id="frmBigData" runat="server">--%>
        <div class="row">
            <!-- table status -->
            <div class="col-lg-12">

                               
                <!-- table monitor status -->
                <div class="row">
                    <div class="col-12">
                        <div class="card rounded-0">
                            <div class="card-header bg-white">
                                <div class="row">
                                    <div class="col-md-10">
                                        <div class="row">
                                            <div class="col-sm-2 border-right text-center">
                                              <img class="justify-content-start" width="65" src="pic/logo_bigdata.svg" />
                                            </div>
                                            <div class="col-sm-2 align-items-end">
                                                <h6><strong>Status</strong></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-right">
                                        <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_monitor_status">
                                            <i class="fa fa-chevron-circle-down"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="collapse show" id="collapse_tbl_monitor_status">
                                <div class="card-body">                               

                                   <div style="font-size: 11px; width: 100%;">
                                        <!-- table dv monitor-->
                                        <table id="tbl_monitor_status" class="table table-sm table-hover">
                                            <thead>
                                                <tr>                                                   
                                                    <th>Work_name</th>
                                                    <th>Batch_name</th>
                                                    <th>Pg</th>
                                                    <th>Completed</th>
                                                    <th>Failed</th>
                                                    <th>Total</th>                                                    
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end table monitor status -->
                 <br />
                <!-- table big monitor -->
                <div class="row">
                    <div class="col-12">
                        <div class="card rounded-0">
                            <div class="card-header bg-white">
                                <div class="row">
                                    <div class="col-md-10">
                                        <div class="row">
                                            <div class="col-sm-1 text-center">
                                                <%--<img class="justify-content-start" width="65" src="pic/logo_bigdata.svg" />--%>                                                
                                                <i class="fa fa-database"></i>
                                            </div>
                                            <div class="col-sm-2 align-items-end">
                                                <h6><strong>Big Data Status</strong></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-right">
                                        <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_monitor_big">
                                            <i class="fa fa-chevron-circle-down"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="collapse show" id="collapse_tbl_monitor_big">
                                <div class="card-body">

                                    <!--  tab head status -->
                                    <ul class="nav nav-tabs" id="tab_monitor_big" role="tablist" style="font-size: 12px;">
                                        <li class="nav-item">
                                            <a class="nav-link show active" id="tab_big_all" data-toggle="tab" href="#div_tbl_big_all" role="tab" aria-controls="div_tbl_big_all" aria-selected="true">All</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="tab_big_complete" data-toggle="tab" href="#div_tbl_big_complete" role="tab" aria-controls="div_tbl_big_complete" aria-selected="true">Complete</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="tab_big_error" data-toggle="tab" href="#div_tbl_big_error" role="tab" aria-controls="div_tbl_big_error" aria-selected="true">Error</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <!-- table big monitor-->
                                        <div class="tab-pane fade show active" id="div_tbl_big_all" role="tabpanel" aria-labelledby="div_tbl_big_all">
                                            <div style="font-size: 11px; width: 100%;">
                                                <table id="tbl_big_all" class="table table-sm table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Work_name</th>
                                                            <th>First_supportor_id</th>
                                                            <th>Sla</th>
                                                            <th>Process_no</th>
                                                            <th>Process_id</th>
                                                            <th>Frequency</th>
                                                            <th>Business_date</th>
                                                            <th>Process_start_ts</th>
                                                            <th>Process_end_ts</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="div_tbl_big_complete" role="tabpanel" aria-labelledby="div_tbl_big_complete">
                                            <div class="container" style="font-size: 11px;">
                                                <table id="tbl_big_complete" class="table table-sm table-hover ">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Work_name</th>
                                                            <th>First_supportor_id</th>
                                                            <th>Sla</th>
                                                            <th>Process_no</th>
                                                            <th>Process_id</th>
                                                            <th>Frequency</th>
                                                            <th>Business_date</th>
                                                            <th>Process_start_ts</th>
                                                            <th>Process_end_ts</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="div_tbl_big_error" role="tabpanel" aria-labelledby="div_tbl_big_error">
                                            <div class="container" style="font-size: 11px;">
                                                <table id="tbl_big_error" class="table table-sm table-hover ">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Work_name</th>
                                                            <th>First_supportor_id</th>
                                                            <th>Sla</th>
                                                            <th>Process_no</th>
                                                            <th>Process_id</th>
                                                            <th>Frequency</th>
                                                            <th>Business_date</th>
                                                            <th>Process_start_ts</th>
                                                            <th>Process_end_ts</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end table big monitor -->
                <br />
                <!-- table dv -->
                <div class="row">
                    <div class="col-12">
                        <div class="card rounded-0">
                            <div class="card-header bg-white">
                                <div class="row">
                                    <div class="col-md-10">
                                        <div class="row">
                                            <div class="col-sm-1 text-center">
                                                <%-- <img class="justify-content-start" width="65" src="pic/logo_bigdata.svg" />--%>
                                                <i class="fa fa-server"></i>
                                            </div>
                                            <div class="col-sm-2 align-items-end">
                                                <h6><strong>DV Status</strong></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-right">
                                        <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_monitor_dv">
                                            <i class="fa fa-chevron-circle-down"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="collapse show" id="collapse_tbl_monitor_dv">
                                <div class="card-body">

                                    <!--  tab head status -->
                                    <ul class="nav nav-tabs" id="tab_monitor_dv" role="tablist" style="font-size: 12px;">
                                        <li class="nav-item">
                                            <a class="nav-link show active" id="tab_dv_all" data-toggle="tab" href="#div_tbl_dv_all" role="tab" aria-controls="div_tbl_dv_all" aria-selected="true">All</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="tab_dv_complete" data-toggle="tab" href="#div_tbl_dv_complete" role="tab" aria-controls="div_tbl_dv_complete" aria-selected="true">Complete</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="tab_dv_error" data-toggle="tab" href="#div_tbl_dv_error" role="tab" aria-controls="div_tbl_dv_error" aria-selected="true">Error</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <!-- table dv monitor-->
                                        <div class="tab-pane fade show active" id="div_tbl_dv_all" role="tabpanel" aria-labelledby="div_tbl_dv_all">
                                            <div style="font-size: 11px; width: 100%;">
                                                <table id="tbl_dv_all" class="table table-sm table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Work_name</th>
                                                            <th>Sla</th>
                                                            <th>Frequency</th>
                                                            <th>Asofdate</th>
                                                            <th>Process_start_ts</th>
                                                            <th>Process_end_ts</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="div_tbl_dv_complete" role="tabpanel" aria-labelledby="div_tbl_dv_complete">
                                            <div class="container" style="font-size: 11px;">
                                                <table id="tbl_dv_complete" class="table table-sm table-hover ">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Work_name</th>
                                                            <th>Sla</th>
                                                            <th>Frequency</th>
                                                            <th>Asofdate</th>
                                                            <th>Process_start_ts</th>
                                                            <th>Process_end_ts</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="div_tbl_dv_error" role="tabpanel" aria-labelledby="div_tbl_dv_error">
                                            <div class="container" style="font-size: 11px;">
                                                <table id="tbl_dv_error" class="table table-sm table-hover ">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Work_name</th>
                                                            <th>Sla</th>
                                                            <th>Frequency</th>
                                                            <th>Asofdate</th>
                                                            <th>Process_start_ts</th>
                                                            <th>Process_end_ts</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end table dv -->


            </div>
            <!-- end table status -->

        </div>
        <%--</form>--%>
    </div>
</body>
</html>

