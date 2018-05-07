<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormDailyAll.aspx.cs" Inherits="EDM_DailyStatus.FormDailyAll" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EDM Status</title>
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


    <!-- js for chart --->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <!-- js chart common -->
    <script src="js_chart/chart_common.js"></script>


    <!-- js angular -->
    <script src="js/angular.min.js"></script>

    <script>
        var table_data;

        //-- get data stream for helthly. when project change ---
        function StreamChange(project, tier, status, tbl_name) {
            $('#' + tbl_name).dataTable().fnClearTable();
            console.log('in function ==' + status);

            $.ajax({
                type: "POST",
                url: "streamAjax.aspx/GetStreamAjax",
                data: '{"project":"' + project + '","tier":"' + tier + '","status":"' + status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    OnSuccess(response, tbl_name);
                },
                failure: function (response) {
                    alert('ajax failed');
                    alert(response.d);
                }
            });
        }

        function OnSuccess(response, tbl_name) {
            console.log('success');
            var dataJson = JSON.parse(response.d);
            console.log(tbl_name + 'json row = ' + dataJson.length);
            $('#' + tbl_name).dataTable().fnClearTable();

            if (dataJson.length != 0) {
                $('#' + tbl_name).dataTable().fnAddData(dataJson);
            }
        }

        //-- get data status for chart. when project change ----
        function StatusChange(project) {

            console.log('in StatusChange ==' + project);

            $.ajax({
                type: "POST",
                url: "streamAjax.aspx/GetStatusAjax",
                data: '{"project":"' + project + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var str_status = JSON.parse(response.d);
                    console.log('chart === ' + str_status[0]);
                    console.log('chart === 00 ---- ' + str_status[0].Completed);

                    var complete = str_status[0].Completed;
                    var running = str_status[0].Running;
                    var failed = str_status[0].Failed;
                    var notstart = str_status[0].Notstarted;
                    var total = str_status[0].Total;
                    //updateChart(complete, running, failed, notstart);

                    var complete_p = str_status[0].Completed_percent;
                    var running_p = str_status[0].Running_percent;
                    var failed_p = str_status[0].Failed_percent;
                    var notstart_p = str_status[0].Notstarted_percent;

                    //-- update status ---

                    $('#h_num_completed').text(complete); $('#p_completed_p').text(Math.round(complete_p,-1)+'%');
                    $('#h_num_running').text(running); $('#p_running_p').text(Math.round(running_p,-1)+'%');
                    $('#h_num_failed').text(failed); $('#p_failed_p').text(Math.round(failed_p,-1)+'%');
                    $('#h_num_notstart').text(notstart); $('#p_notstarted_p').text(Math.round(notstart_p,-1)+'%');
                    $('#h_num_total').text(total); $('#p_total_p').text('100%');

                    console.log('complete=' + complete);
                    console.log('running=' + running);
                    console.log('failed=' + failed);
                    console.log('notstart=' + notstart);

                    console.log('complete_p=' + complete_p);
                    console.log('running_p=' + running_p);
                    console.log('failed_p=' + failed_p);
                    console.log('notstart_p=' + notstart_p);



                    $("#probar_completed").css("width", complete_p + "%");
                    $("#probar_running").css("width", ((running_p < 5 && running_p != 0) ? 5 : running_p) + "%");
                    $("#probar_failed").css("width", ((failed_p < 5 && failed_p != 0) ? 5 : failed_p) + "%");
                    $("#probar_notstart").css("width", ((notstart_p < 5 && notstart_p != 0) ? 5 : notstart_p) + "%");

                },
                failure: function (response) {
                    alert('ajax failed');
                    alert(response.d);
                }
            });
        }

        $(document).ready(function () {
              $('#table_today_error').DataTable();
            initTableStream();
            //initCanvasChartStatus();
        });

        $(window).on('load', function () {
            //initChartStatus();
            StatusChange('');
        });

        function setVaTotable() {
            //  updateChart(50, 50, 50);
        }

        function streamInfo(stream_key) {

            $.ajax({
                type: "POST",
                url: "streamAjax.aspx/GetProjectInfotAjax",
                data: '{"stream_key":"' + stream_key + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var json_project = JSON.parse(response.d);
                    console.log('stream info ----------------- ' + json_project.length);

                    $('#modal_stream_title').text("Stream Key : " + stream_key);

                    var str_show = '';
                    if (json_project.length != 0) {
                        for (var i = 0; i < json_project.length; i++) {
                            str_show += json_project[i];
                            console.log('pro=' + json_project[i])
                        }
                    } else {
                        str_show = 'Not Project...';
                    }
                    console.log('str_show ---' + str_show);
                    $('#p_modal_body_stream').html("<ul>" + str_show + "</ul>");

                    $('#modal_stream_info_project').modal({ show: true });
                },
                failure: function (response) {
                    alert('ajax streamInfo failed');
                }
            });
        }


    </script>

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

        #div_table_alert {
            /*display: block !important;*/
            height: 700px !important;
            /*overflow-y: scroll !important;*/
        }

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

    <!-- Modal info stream use in project -->
    <div class="modal fade" id="modal_stream_info_project" tabindex="-1" role="dialog" aria-labelledby="modal_center_title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modal_stream_title"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Use In Project : </p>
                    <p id="p_modal_body_stream"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container-fluid ">
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

        <!-- end menu bar -->


        <form id="formDailyAll" runat="server">
            <div class="row">

                <!-- left content -->
                <div class="col-md-9">

                    <!-- dash board -->
                    <div class="row p-1">
                        <div class="col-md-12">
                            <div class="card rounded-0 bg-white">
                                <div class="card-body">
                                    <div class="form-group row">
                                        <div class="col-sm-2 border-right border-bottom text-center">
                                            <h6>TIER 1</h6>
                                        </div>
                                        <div class="col-sm-5 border-bottom">
                                            <h6 id="cur_date" runat="server"></h6>
                                        </div>
                                        <div class="col-sm-5">
                                            <select class="form-control col-md-6 ml-auto rounded-0 font-weight-bold" id="selectProject" style="font-size: 12px;">
                                                <option value="notwork">ALERT</option>
                                                <option value="proAll">ALL PROJECT</option>
                                                <asp:Literal ID="lt_select_project" runat="server"></asp:Literal>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Tab Header -->
                                    <script type="text/javascript">

                                        $(document).ready(function () {
                                            $('.allobj').hide();
                                            $('.notwork').show();

                                        });

                                        $('#selectProject').change(function () {

                                            var vaSelect = $('#selectProject').val();

                                            $('.allobj').hide();

                                            $('.' + vaSelect).show();

                                            setVaTotable();
                                            if (vaSelect != "notwork") {
                                                if (vaSelect == "proAll") {
                                                    $('#h_porject').text("ALL PROJECT");

                                                    StreamChange('', 'TIER1', 'ALL', 'table_all_stream');
                                                    StreamChange('', 'TIER1', 'btn btn-success', 'table_finish_stream');
                                                    StreamChange('', 'TIER1', 'btn btn-warning', 'table_process_stream');
                                                    StreamChange('', 'TIER1', 'btn btn-danger', 'table_failed_stream');
                                                    StreamChange('', 'TIER1', 'btn', 'table_notstart_stream');
                                                    StreamChange('', 'TIER1', 'EXCEPTION', 'table_exception_stream');
                                                    StatusChange('');

                                                } else {
                                                    $('#h_porject').text(vaSelect);
                                                    StreamChange(vaSelect, 'TIER1', 'ALL', 'table_all_stream');
                                                    StreamChange(vaSelect, 'TIER1', 'btn btn-success', 'table_finish_stream');
                                                    StreamChange(vaSelect, 'TIER1', 'btn btn-warning', 'table_process_stream');
                                                    StreamChange(vaSelect, 'TIER1', 'btn btn-danger', 'table_failed_stream');
                                                    StreamChange(vaSelect, 'TIER1', 'btn', 'table_notstart_stream');
                                                    StreamChange(vaSelect, 'TIER1', 'EXCEPTION', 'table_exception_stream');

                                                    StatusChange(vaSelect);

                                                }
                                            }


                                        });

                                    </script>

                                    <ul class="nav nav-tabs" id="myTab" role="tablist" style="font-size: 12px;">
                                        <li class="nav-item">
                                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#daily" role="tab" aria-controls="daily" aria-selected="true">Daily</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#monthly" role="tab" aria-controls="monthly" aria-selected="false">Monthly</a>
                                        </li>
                                        <%--<li class="nav-item">
                                            <a class="nav-link" id="contact-tab" data-toggle="tab" href="#day_failed" role="tab" aria-controls="day_failed" aria-selected="false">Daily Failed </a>

                                        </li>--%>
                                    </ul>

                                    <div class="tab-content" id="myTabContent">
                                        <div class="tab-pane fade show active p-1" id="daily" role="tabpanel" aria-labelledby="daily-tab">

                                            <!--   <button onclick="window.location.href='FormStreamKey.aspx?id=RM.1'" type="button" class="btn btn-info col-md-2 mb-1 notwork proAll">ddddd</button> -->
                                            <asp:Literal ID="lt_tier_daily" runat="server"></asp:Literal>

                                        </div>

                                        <div class="tab-pane fade" id="monthly" role="tabpanel" aria-labelledby="monthly-tab">



                                            <asp:Literal ID="lt_tier_monthly" runat="server"></asp:Literal>


                                            <!-- 
                                            <button type="button" class="btn btn-info col-md-2 mb-1 proA proAll">ProA</button>                                           
                                                -->

                                        </div>
                                        <%--<div class="tab-pane fade" id="day_failed" role="tabpanel" aria-labelledby="day_failed-tab">
                                        </div>--%>
                                    </div>
                                </div>
                            </div>



                        </div>

                    </div>

                    <!-- table summary group -->
                    <div class="row p-1">
                        <div class="col-md-12">
                            <div class="card rounded-0 bg-white" style="font-size: 12px">
                                <div class="card-header h-25 bg-white">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <h6>Group Summary</h6>
                                        </div>

                                        <div class="col-md-2 text-right">
                                            <a class="active text-dark" data-toggle="collapse" href="#collapse_tbl_sum_grp">
                                                <i class="fa fa-chevron-circle-down"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="collapse" id="collapse_tbl_sum_grp">
                                    <div class="card-body">
                                        <div class="container" style="font-size: 12px">
                                            <table id="tbl_group_sum" class="table table-sm table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Group</th>
                                                        <th>Completed</th>
                                                        <th>Running</th>
                                                        <th>Failed</th>
                                                        <th>Not Started</th>
                                                        <th>Exception</th>
                                                        <th>Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Literal runat="server" ID="lt_tbl_sum_group"></asp:Literal>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- table detail by All or group -->
                    <div class="row p-1">
                        <div class="col-md-12">
                            <div class="card rounded-0 bg-white" style="font-size: 12px">
                                <div class="card-header bg-white">
                                    <%--<div class="container">--%>
                                    <div class="row">
                                        <div class="col-md-2 mr-auto border-right">
                                            <h6>Stream</h6>
                                        </div>
                                        <div class="col-md-8 mr-auto">
                                            <h6 id="h_porject"></h6>
                                        </div>

                                        <div class="col-md-2 text-right">
                                            <a class="active text-dark" data-toggle="collapse" href="#collapseTable"><i class="fa fa-chevron-circle-down"></i></a>
                                        </div>
                                    </div>
                                    <%--</div>--%>
                                    <%--<ul class="nav">
                                        <li class="ml-auto"><a class="active" data-toggle="collapse" href="#collapseTable"><i class="fa fa-chevron-circle-down"></i></a>
                                        </li>
                                    </ul>--%>
                                </div>
                                <div class="collapse show" id="collapseTable">
                                    <div class="card-body">

                                        <!--  tab head -->
                                        <ul class="nav nav-tabs" id="tab-helthly" role="tablist" style="font-size: 12px;">
                                            <li class="nav-item">
                                                <a class="nav-link show active" id="alert-tab" data-toggle="tab" href="#div_table_alert" role="tab" aria-controls="div_table_alert" aria-selected="true">Alert <span id="bdg_alert" runat="server" class="badge badge-pill badge-danger"></span></a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="all-tab" data-toggle="tab" href="#tab_all_stream" role="tab" aria-controls="tab_all_stream" aria-selected="false">All</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="finish-tab" data-toggle="tab" href="#tab_finish_stream" role="tab" aria-controls="tab_finish_stream" aria-selected="false">completed</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="process-tab" data-toggle="tab" href="#tab_process_stream" role="tab" aria-controls="tab_process_stream" aria-selected="false">Running</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="failed-tab" data-toggle="tab" href="#tab_failed_stream" role="tab" aria-controls="tab_failed_stream" aria-selected="false">Failed</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="notstart-tab" data-toggle="tab" href="#tab_notstart_stream" role="tab" aria-controls="tab_notstart_stream" aria-selected="false">Not Start</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="exception-tab" data-toggle="tab" href="#tab_exception_stream" role="tab" aria-controls="tab_exception_stream" aria-selected="false">Exception</a>
                                            </li>
                                        </ul>

                                        <div class="tab-content">
                                            <!-- table tab Alert -->

                                            <!-- table tab alert -->
                                            <div class="tab-pane fade show active" id="div_table_alert" role="tabpanel" aria-labelledby="div_table_alert_tab">
                                                <table id="table_alert_stream" class="table table-sm table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">STREAM KEY</th>
                                                            <th scope="col">STREAM NAME</th>
                                                            <th scope="col">ERROR LOG</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="table_tbody" runat="server">
                                                        <asp:Literal runat="server" ID="lt_table_alert"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab alert -->

                                            <!-- table tab All -->
                                            <div class="tab-pane fade" id="tab_all_stream" role="tabpanel" aria-labelledby="tab_all_stream_tab">
                                                <table class="table table-sm table-hover" id="table_all_stream">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Stream_Key</th>
                                                            <th scope="col">Stream_Name</th>
                                                            <th scope="col">Group</th>
                                                            <th scope="col">Business_Date</th>
                                                            <th scope="col">Start_Time</th>
                                                            <th scope="col">End_Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Literal ID="lt_table_tab_all" runat="server"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab All -->

                                            <!-- table tab finish -->
                                            <div class="tab-pane fade" id="tab_finish_stream" role="tabpanel" aria-labelledby="tab_finish_stream_tab">
                                                <table class="table table-sm table-hover" id="table_finish_stream">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Stream_Key</th>
                                                            <th scope="col">Stream_Name</th>
                                                            <th scope="col">Group</th>
                                                            <th scope="col">Business_Date</th>
                                                            <th scope="col">Start_Time</th>
                                                            <th scope="col">End_Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Literal ID="lt_table_tab_finish" runat="server"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab finish -->

                                            <!-- table tab process -->
                                            <div class="tab-pane fade" id="tab_process_stream" role="tabpanel" aria-labelledby="tab_process_stream_tab">
                                                <table class="table table-sm table-hover" id="table_process_stream">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Stream_Key</th>
                                                            <th scope="col">Stream_Name</th>
                                                            <th scope="col">Group</th>
                                                            <th scope="col">Business_Date</th>
                                                            <th scope="col">Start_Time</th>
                                                            <th scope="col">End_Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Literal ID="lt_table_tab_process" runat="server"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab process -->

                                            <!-- table tab failed -->
                                            <div class="tab-pane fade" id="tab_failed_stream" role="tabpanel" aria-labelledby="tab_failed_stream_tab">
                                                <table class="table table-sm table-hover" id="table_failed_stream">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Stream_Key</th>
                                                            <th scope="col">Stream_Name</th>
                                                            <th scope="col">Group</th>
                                                            <th scope="col">Business_Date</th>
                                                            <th scope="col">Start_Time</th>
                                                            <th scope="col">End_Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Literal ID="lt_table_tab_failed" runat="server"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab failed -->

                                            <!-- table tab notstart -->
                                            <div class="tab-pane fade" id="tab_notstart_stream" role="tabpanel" aria-labelledby="tab_notstart_stream_tab">
                                                <table class="table table-sm table-hover" id="table_notstart_stream">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Stream_Key</th>
                                                            <th scope="col">Stream_Name</th>
                                                            <th scope="col">Group</th>
                                                            <th scope="col">Business_Date</th>
                                                            <th scope="col">Start_Time</th>
                                                            <th scope="col">End_Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Literal ID="lt_table_tab_notstart" runat="server"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab notstart -->

                                            <!-- table tab exception -->
                                            <div class="tab-pane fade" id="tab_exception_stream" role="tabpanel" aria-labelledby="tab_exception_stream_tab">
                                                <table class="table table-sm table-hover" id="table_exception_stream">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Stream_Key</th>
                                                            <th scope="col">Stream_Name</th>
                                                            <th scope="col">Group</th>
                                                            <th scope="col">Business_Date</th>
                                                            <th scope="col">Start_Time</th>
                                                            <th scope="col">End_Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Literal ID="lt_table_tab_exception" runat="server"></asp:Literal>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- End table tab exception -->

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                   <%-- <div class="row p-1">
                        <div class="col-md-12">
                            <div class="card rounded-0 bg-white" style="font-size: 12px">
                                <div class="card-body">
                                    <table class="table table-sm table-hover" id="table_today_error">
                                        <thead>
                                            <tr>

                                                <th style="width:20%;">update_ts</th>
                                                <th>stream_key</th>
                                                <th>process_name</th>
                                                <th>auto_analyze_log</th>
                                                <th>sys_log</th>


                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Literal ID="lt_today_error" runat="server"></asp:Literal>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>--%>


                </div>

                <!-- end left -->

                <!-- right content-->
                <div class="col-md-3">

                    <!-- summary status -->
                    <div class="row p-1">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-white">
                                    <h6>EDM Progress</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row p-2">
                                        <div class="col-sm-6 border-primary" style="display: block;">

                                            <h4 id="h_num_completed">0</h4>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Completed</td>
                                                    <td id="p_completed_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div id="probar_completed" class="progress-bar bg-success" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <h4 id="h_num_running">0</h4>
                                            <%--<div class="text-muted" style="padding: 5px;">Running</div>--%>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Running</td>
                                                    <td id="p_running_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div id="probar_running" class="progress-bar bg-warning" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 id="h_num_failed">0</h4>
                                            <%--<div class="text-muted" style="padding: 5px;">Failed</div>--%>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Failed</td>
                                                    <td id="p_failed_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div id="probar_failed" class="progress-bar bg-danger" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <h4 id="h_num_notstart">0</h4>
                                            <%--<div class="text-muted" style="padding: 5px;">Not Started</div>--%>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Not Started</td>
                                                    <td id="p_notstarted_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div id="probar_notstart" class="progress-bar bg-secondary" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 id="h_num_total">0</h4>
                                            <%--<div class="text-muted" style="padding: 5px;">Total</div>--%>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Total</td>
                                                    <td id="p_total_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div id="probar_total" class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- summary SLA -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-table">
                                <div class="card-body table-responsive">
                                    <div class="title">
                                        <h6>SLA PROJECT</h6>
                                    </div>
                                    <table class="table table-striped table-borderless" style="width: 100%; font-size: 11px">
                                        <thead>
                                            <tr>
                                                <th style="width: 30%;">Project</th>
                                                <th>Miss</th>
                                                <th>Meet</th>
                                                <th>Total</th>
                                                <th>State</th>

                                            </tr>
                                        </thead>
                                        <tbody class="no-border-x">
                                            <asp:Literal ID="lt_table_sum_sla_project" runat="server"></asp:Literal>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--  <div class="row">
                        <div class="col-md-12">
                            <div class="card rounded-0">
                                <div class="card-body">
                                    <div id="canvas-holder" style="width: 100%">
                                        <canvas id="doughnut-chart" style="display: block" />
                                        <div id="canvas-holder" style="width: 100%">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>
                </div>

                <!-- end right content -->

            </div>
        </form>
    </div>

</body>
</html>
