<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormSAS.aspx.cs" Inherits="EDM_DailyStatus.FormSAS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SAS</title>
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


     <asp:Literal ID="lt_json_status_all" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_monitor" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_running" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_completed" runat="server"></asp:Literal>

    <script>
         /**
         * Formatting function for row details-modify as you need
         *  'd' is the original data object for the row
         */
        function formatTable(d) {

            return '<table cellpadding="2" cellspacing="0" border="0" style="padding-left:50px;background-color:whitesmoke;" >' +
                '<tr>' +
                '<th style="text-align:right; width:80px;">Batch Name : </th>' +
                '<td>' + d.Batch_name + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Work Name : </th>' +
                '<td>' + d.Work_name + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Duration : </th>' +
                '<td>' + d.Est_hours + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Min : </th>' +
                '<td>' + d.Min + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Max : </th>' +
                '<td>' + d.Max + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Avg : </th>' +
                '<td>' + d.Avg_c + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Avg_ : </th>' +
                '<td>' + d.Avg + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Person : </th>' +
                '<td>'+ d.First_supportor_id +'</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Wait App : </th>' +
                '<td>'+ d.Wait_appl +'</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Impact App : </th>' +
                '<td>'+ d.Impact_appl +'</td>' +
                '</tr>' +
                '</table>';
        }

        $(document).ready(function () {

            page_time_reload(300000);

            var dataJsonStatusAll = va_all;
            var dataJsonStatusAllMonitor = va_monitor;
            var dataJsonStatusAllRunning = va_running;
            var dataJsonStatusAllCompleted = va_completed;
           
            var column_status = [
                { data: 'Status' },
                { data: 'Status_name' },
                { data: 'Sla' },
                { data: 'C_sla' },
                { data: 'Work_name' },
                { data: 'Batch_name' },
                { data: 'Business_date' },
                { data: 'Job_start_date' },
                { data: 'Job_end_date' },
                { data: 'Frequency' }
                //  { data: 'Est_hours' },
                //  { data: 'Avg_c' }
            ];

            $('#tbl_sas_all_frequency').DataTable();
            $('#tbl_sas_daily').DataTable();
            $('#tbl_sas_workdays').DataTable();
            $('#tbl_sas_weekly').DataTable();
            $('#tbl_sas_monthly').DataTable();

            var tbl_all_status = $('#tbl_sas_all_status').DataTable({ columns: column_status });
            var tbl_monitor = $('#tbl_sas_monitor').DataTable({ columns: column_status });
            var tbl_running = $('#tbl_sas_running').DataTable({ columns: column_status });
            var tbl_finished = $('#tbl_sas_finished').DataTable({ columns: column_status });

            // init table status
            //    $('#tbl_edw_all_status').dataTable().fnClearTable();        
            if(dataJsonStatusAll != "")
            $('#tbl_sas_all_status').dataTable().fnAddData(dataJsonStatusAll);
            //   $('#tbl_edw_monitor').dataTable().fnClearTable();
            if(dataJsonStatusAllMonitor != "")
            $('#tbl_sas_monitor').dataTable().fnAddData(dataJsonStatusAllMonitor);
            //     $('#tbl_edw_running').dataTable().fnClearTable();
            if(dataJsonStatusAllRunning != "")
            $('#tbl_sas_running').dataTable().fnAddData(dataJsonStatusAllRunning);
            //    $('#tbl_edw_finished').dataTable().fnClearTable();
            if(dataJsonStatusAllCompleted != "")
            $('#tbl_sas_finished').dataTable().fnAddData(dataJsonStatusAllCompleted);

            //Add event listener for opening and closing details
            $('#tbl_sas_all_status tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_all_status.row(tr);
                rowEven(tr, row);
            });

            $('#tbl_sas_monitor tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_monitor.row(tr);
                rowEven(tr, row);
            });

            $('#tbl_sas_running tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_running.row(tr);
                rowEven(tr, row);
            });

            $('#tbl_sas_finished tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_finished.row(tr);
                rowEven(tr, row);
            });
        });//-- end document.ready

        function rowEven(tr, row) {
            if (row.child.isShown()) {
                //This row is already row-cose it
                row.child.hide();
                tr.removeClass('shown');
            }
            else {
                // Open this row
                row.child(formatTable(row.data())).show();
                tr.addClass('shown');
            }
        }

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

    <div class="container-fluid ">
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

        <form id="frmSAS" runat="server">
            <div class="row">
                <div class="col-sm-9">

                    <div class="row">
                        <div class="col-12">
                            <div class="card rounded-0">
                                <div class="card-header bg-white">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <div class="row">
                                                <div class="col-sm-1"><img class="justify-content-start" width="65" src="pic/logo_sas.png" /></div>
                                                <div class="col-sm-5 align-items-end"><h6><small>&nbsp;Status</small></h6></div>
                                            </div>
                                           <%-- <table class="p-2">
                                                <tr><td><img width="65" src="pic/logo_sas.png" /></td><td><h6><span class="badge badge-secondary">Status</span></h6></td></tr>                                                
                                            </table>--%>

                                            <%--<div><img width="65px" src="pic/logo_sas.png" /></div><div><h6>Status</h6></div>--%>
                                            
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_sas_status">
                                                <i class="fa fa-chevron-circle-down"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="collapse show" id="collapse_tbl_sas_status">
                                    <div class="card-body">

                                        <!--  tab head status -->
                                        <ul class="nav nav-tabs" id="tab_sas_status" role="tablist" style="font-size: 12px;">
                                            <li class="nav-item">
                                                <a class="nav-link show active" id="tab_sas_all_status" data-toggle="tab" href="#div_tbl_sas_all_status" role="tab" aria-controls="div_tbl_sas_all_status" aria-selected="true">All</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_monitor" data-toggle="tab" href="#div_tbl_sas_monitor" role="tab" aria-controls="div_tbl_sas_monitor" aria-selected="true">Monitor</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_running" data-toggle="tab" href="#div_tbl_sas_running" role="tab" aria-controls="div_tbl_sas_running" aria-selected="true">Running</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_finished" data-toggle="tab" href="#div_tbl_sas_finished" role="tab" aria-controls="div_tbl_sas_finished" aria-selected="true">Completed</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <!-- table sas daily in tab status -->
                                            <div class="tab-pane fade show active" id="div_tbl_sas_all_status" role="tabpanel" aria-labelledby="div_tbl_sas_all_status">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_all_status" class="table table-sm table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>C_Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                                <th>Frequency</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_all_status" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_monitor" role="tabpanel" aria-labelledby="div_tbl_sas_monitor">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_monitor" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>C_Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                                <th>Frequency</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_monitor" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_running" role="tabpanel" aria-labelledby="div_tbl_sas_running">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_running" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>C_Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                                <th>Frequency</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_running" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_finished" role="tabpanel" aria-labelledby="div_tbl_sas_finished">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_finished" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>C_Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                                <th>Frequency</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_finished" runat="server"></asp:Literal>
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
                    <br />
                    <div class="row">
                        <div class="col-12">
                            <div class="card rounded-0">
                                <div class="card-header bg-white">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <h6>SAS Frequency</h6>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_sas_frequency">
                                                <i class="fa fa-chevron-circle-down"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="collapse" id="collapse_tbl_sas_frequency">
                                    <div class="card-body">

                                        <!--  tab head frequency -->
                                        <ul class="nav nav-tabs" id="tab_sas_frequency" role="tablist" style="font-size: 12px;">
                                            <li class="nav-item">
                                                <a class="nav-link show active" id="tab_sas_all_frequency" data-toggle="tab" href="#div_tbl_sas_all_frequency" role="tab" aria-controls="div_tbl_sas_all_frequency" aria-selected="true">All</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_daily" data-toggle="tab" href="#div_tbl_sas_daily" role="tab" aria-controls="div_tbl_sas_daily" aria-selected="true">Daily</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_workdays" data-toggle="tab" href="#div_tbl_sas_workdays" role="tab" aria-controls="div_tbl_sas_workdays" aria-selected="true">Workdays</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_weekly" data-toggle="tab" href="#div_tbl_sas_weekly" role="tab" aria-controls="div_tbl_sas_weekly" aria-selected="true">Weekly</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_sas_monthly" data-toggle="tab" href="#div_tbl_sas_monthly" role="tab" aria-controls="div_tbl_sas_monthly" aria-selected="true">Monthly</a>
                                            </li>

                                        </ul>
                                        <div class="tab-content">
                                            <!-- table sas daily in tab frequency  -->
                                            <div class="tab-pane fade show active" id="div_tbl_sas_all_frequency" role="tabpanel" aria-labelledby="div_tbl_sas_all_frequency">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_all_frequency" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                                <th>Frequency</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_all_frequency" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_daily" role="tabpanel" aria-labelledby="div_tbl_sas_daily">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_daily" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_daily" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_workdays" role="tabpanel" aria-labelledby="div_tbl_sas_workdays">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_workdays" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_workdays" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_weekly" role="tabpanel" aria-labelledby="div_tbl_sas_weekly">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_weekly" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_weekly" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_sas_monthly" role="tabpanel" aria-labelledby="div_tbl_sas_monthly">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_sas_monthly" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Status</th>
                                                                <th>Sla</th>
                                                                <th>Work_Name</th>
                                                                <th>Batch_Name</th>
                                                                <th>Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <th>Job_End_Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_sas_monthly" runat="server"></asp:Literal>
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

                </div>

                <div class="col-sm-3">
                    <!-- summary status -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-white">
                                    <table>
                                        <tr><td><i class="fa fa-bar-chart fa-2x text-info"></i></td><td><h6>&nbsp;&nbsp;SAS Progress</h6></td></tr>
                                    </table>                                    
                                </div>
                                <div class="card-body">
                                    <div class="row p-2">

                                        <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 runat="server" id="h_num_monitor">0</h4>                                            
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Monitor</td>
                                                    <td id="p_monitor_p" runat="server" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_monitor" class="progress-bar bg-dark" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>                 

                                        <div class="col-6">
                                            <h4 runat="server" id="h_num_running">0</h4>                                            
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Running</td>
                                                    <td runat="server" id="p_running_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_running" class="progress-bar bg-warning" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row p-2">

                                        
                                          <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 runat="server" id="h_num_completed">0</h4>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Completed</td>
                                                    <td runat="server" id="p_completed_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_completed" class="progress-bar bg-success" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>

                                        <div class="col-6">
                                            <h4 runat="server" id="h_num_total">0</h4>                                            
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Total</td>
                                                    <td runat="server" id="p_total_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_total" class="progress-bar bg-info" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end summary status -->
                    <br />
                    <!-- summary sla -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-white">                                  
                                    <table>
                                        <tr><td><i class="fa fa-line-chart fa-2x text-info"></i></td><td><h6>&nbsp;&nbsp;SLA Progress</h6></td></tr>
                                    </table>   
                                </div>
                                <div class="card-body">
                                    <div class="row p-2">

                                        <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 runat="server" id="h_num_meet">0</h4>                                            
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">MEET</td>
                                                    <td id="p_meet_p" runat="server" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_meet" class="progress-bar bg-success" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>                 

                                        <div class="col-6">
                                            <h4 runat="server" id="h_num_miss">0</h4>                                            
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">MISS</td>
                                                    <td runat="server" id="p_miss_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_miss" class="progress-bar bg-danger" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row p-2">

                                        
                                          <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 runat="server" id="h_num_na">0</h4>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">NA</td>
                                                    <td runat="server" id="p_na_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_na" class="progress-bar badge-dark" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>

                                        <div class="col-6">
                                            <h4 runat="server" id="h_num_total_sla">0</h4>                                            
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">SLA Total</td>
                                                    <td runat="server" id="p_total_sla_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_total_sla" class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end summary sla -->

                </div>


            </div>
        </form>
    </div>
</body>
</html>
