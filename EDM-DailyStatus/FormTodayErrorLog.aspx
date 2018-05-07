<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormTodayErrorLog.aspx.cs" Inherits="EDM_DailyStatus.FormTodayErrorLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Today Error Log</title>
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

    <!-- css common -->
    <link rel="stylesheet" href="css_status/common.css" />

    <!-- js and css for datepicker -->
    <%-- <script src="js/bootstrap-datepicker.js"></script>
    <link rel="stylesheet" href="css/datepicker.css" />--%>

    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.6/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.6/css/gijgo.min.css" rel="stylesheet" />

    <script>
        $(document).ready(function () {
            $('#tbl_today_error').DataTable({
                columns: [
                    { data: 'Update_ts' },
                    { data: 'Stream_key' },
                    { data: 'Process_name' },
                    { data: 'Auto_analyze_log' },
                    { data: 'Sys_log' }
                ]
            });


            $('#dte_start').datepicker({
                uiLibrary: 'bootstrap4'
                , format: 'yyyy-mm-dd'
            });
            $('#dte_end').datepicker({
                uiLibrary: 'bootstrap4'
                , format: 'yyyy-mm-dd'
            });

        });


        //-- get data stream for helthly. when project change ---
        function btn_search() {
            var va_start_date = $('#dte_start').val();
            var va_end_date = $('#dte_end').val();

            console.log('va_start_date =' + va_start_date);
            console.log('va_end_date =' + va_end_date);


            $.ajax({
                type: "POST",
                url: "streamAjax.aspx/searchLogErrorToday",
                data: '{"start_date":"' + va_start_date + '","end_date":"' + va_end_date + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log('ajax btn_success..');
                    var datajson = JSON.parse(response.d);
                    $('#tbl_today_error').dataTable().fnClearTable();
                    if (datajson.length != 0) {
                        $('#tbl_today_error').dataTable().fnAddData(datajson);
                    }

                },
                failure: function (response) {
                    alert('ajax failed btn_search');
                    alert(response.d);
                }
            });
        }

    </script>

</head>
<body style="padding-top: 70px;" class="bg-light">
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
                        <a class="nav-link" href="#"><i class="fa fa-home">&nbsp;Main   </i></a>
                    </li>
                    <li class="nav-item dropdown px-3">
                        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"><i class="fa fa-dashboard"></i>&nbsp; Dashboard Management</a>
                        <ul class="dropdown-menu" aria-labelledby="dropdown01">
                            <li><a class="dropdown-item dropdown-toggle">EDM</a>
                                <ul class="dropdown-menu" style="top: 104px; left: 156px;">
                                    <li><a class="dropdown-item dropdown-toggle" href="#">Report</a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="FormDaily.aspx">Daily</a></li>
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
        <!-- main -->
    </div>
    <form id="frmTodayError" runat="server">
        <div class="row p-2">
            <div class="col-md-11">
                <div class="card rounded-0">
                    <div class="card-header">
                        <h6><strong>Error Log</strong></h6>
                        <%--<div class="input-group input-daterange">
                            <input id="dte_start"" />
                            <div class="input-group-addon">to</div>
                            <input id="dte_end" type="text" class="form-control" value="2012-04-19" />
                        </div>--%>
                    </div>
                    <div class="card-body">
                        <div class="card-title">
                            <div class="row align-items-end">
                                <div class="col-sm-3">
                                    <label for="dte_start"><strong>start date</strong></label>
                                    <input class="form-control " id="dte_start" runat="server" readonly />
                                </div>
                                <div class="col-sm-3">
                                    <label for="dte_start"><strong>end date</strong></label>
                                    <input class="form-control" id="dte_end" runat="server" readonly />
                                </div>
                                <div class="col-sm-1">
                                    <button class="btn btn-primary" type="button" onclick="btn_search();">Search</button>
                                </div>
                            </div>
                        </div>
                        <div class="container-fluid" style="font-size: 12px;">
                            <table id="tbl_today_error" class="table table-sm table-hover">
                                <thead>
                                    <tr>
                                        <th style="width: 20%;">update_ts</th>
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
            </div>
        </div>
    </form>
</body>
</html>
