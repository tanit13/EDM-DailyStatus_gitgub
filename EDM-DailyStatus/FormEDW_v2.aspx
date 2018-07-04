<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormEDW_v2.aspx.cs" Inherits="EDM_DailyStatus.FormEDW_v2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EDW</title>
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

    <!-- js google chart -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <%--<script type="text/javascript" src="js_chart/chart_edw.js"></script>--%>

    <script type="text/javascript" src="js/js_common.js"></script>

    <link rel="stylesheet" href="css/css_edw.css?n=1" />

    <asp:Literal ID="lt_json_status_all" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_monitor" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_running" runat="server"></asp:Literal>
    <asp:Literal ID="lt_json_completed" runat="server"></asp:Literal>

    <asp:Literal ID="lt_dataBarChart" runat="server"></asp:Literal>
    <asp:Literal ID="lt_dataPieChart" runat="server"></asp:Literal>

    <script>

        var templatePlugins = function () {

            var tp_clock = function () {

                function tp_clock_time() {
                    var now = new Date();
                    var hour = now.getHours();
                    var minutes = now.getMinutes();

                    hour = hour < 10 ? '0' + hour : hour;
                    minutes = minutes < 10 ? '0' + minutes : minutes;

                    $(".plugin-clock").html(hour + ":" + minutes);
                }
                if ($(".plugin-clock").length > 0) {

                    tp_clock_time();

                    window.setInterval(function () {
                        tp_clock_time();
                    }, 10000);

                }
            }

            var tp_date = function () {

                if ($(".plugin-date").length > 0) {

                    var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                    var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

                    var now = new Date();
                    var day = days[now.getDay()];
                    var date = now.getDate();
                    var month = months[now.getMonth()];
                    var year = now.getFullYear();

                    $(".plugin-date").html(day + ", " + month + " " + date + ", " + year);
                }
            }

            return {
                init: function () {
                    tp_clock();
                    tp_date();
                }
            }
        }();

        function setCurrentTimeline() {
            var now = new Date();
            var hour = now.getHours();
            var minutes = now.getMinutes();

            if (hour <= 3 && minutes <= 59) {
                $("#li_timeline1").removeClass("blue");
                $("#li_timeline1").addClass("orange");
                $("#li_timeline_sla1").removeClass("blue");
                $("#li_timeline_sla1").addClass("orange");

            } else if (hour <= 7 && minutes <= 59) {
                $("#li_timeline2").removeClass("blue");
                $("#li_timeline2").addClass("orange");
                $("#li_timeline_sla2").removeClass("blue");
                $("#li_timeline_sla2").addClass("orange");

            } else if (hour <= 11 && minutes <= 59) {
                $("#li_timeline3").removeClass("blue");
                $("#li_timeline3").addClass("orange");
                $("#li_timeline_sla3").removeClass("blue");
                $("#li_timeline_sla3").addClass("orange");

            } else if (hour <= 15 && minutes <= 59) {
                $("#li_timeline4").removeClass("blue");
                $("#li_timeline4").addClass("orange");
                $("#li_timeline_sla4").removeClass("blue");
                $("#li_timeline_sla4").addClass("orange");

            } else if (hour <= 19 && minutes <= 59) {
                $("#li_timeline5").removeClass("blue");
                $("#li_timeline5").addClass("orange");
                $("#li_timeline_sla5").removeClass("blue");
                $("#li_timeline_sla5").addClass("orange");

            } else {
                $("#li_timeline6").removeClass("blue");
                $("#li_timeline6").addClass("orange");
                $("#li_timeline_sla6").removeClass("blue");
                $("#li_timeline_sla6").addClass("orange");
            }
        }

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
                '<th style="text-align:right;">Status : </th>' +
                '<td>' + d.Status_name + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Sla : </th>' +
                '<td>' + d.Sla + '</td>' +
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
                '<td>' + d.First_supportor_id + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Wait App : </th>' +
                '<td>' + d.Wait_appl + '</td>' +
                '</tr>' +
                '<tr>' +
                '<th style="text-align:right;">Impact App : </th>' +
                '<td>' + d.Impact_appl + '</td>' +
                '</tr>' +
                '</table>';
        }

        $(document).ready(function () {
            templatePlugins.init();
            setCurrentTimeline();

            page_time_reload(300000);

            var dataJsonStatusAll = va_all;
            var dataJsonStatusAllMonitor = va_monitor;
            var dataJsonStatusAllRunning = va_running;
            var dataJsonStatusAllCompleted = va_completed;

            var column_status = [
                { data: 'Status_pic' },
                { data: 'First_supportor_id' },
                //{ data: 'Status' },

                //{ data: 'Sla' },
                //{ data: 'C_sla' },
                { data: 'Work_name' },
                { data: 'Batch_name' },
                { data: 'Business_date' },
                { data: 'Job_start_date' },
                //{ data: 'Job_end_date' },
                { data: 'Frequency' }
                // { data: 'Est_hours' },
                //{ data: 'Avg_c' }
            ];

            $('#tbl_edw_all_frequency').DataTable();
            $('#tbl_edw_daily').DataTable();
            $('#tbl_edw_workdays').DataTable();
            $('#tbl_edw_weekly').DataTable();
            $('#tbl_edw_monthly').DataTable();

            var tbl_all_status = $('#tbl_edw_all_status').DataTable({ columns: column_status });
            var tbl_monitor = $('#tbl_edw_monitor').DataTable({ columns: column_status });
            var tbl_running = $('#tbl_edw_running').DataTable({ columns: column_status });
            var tbl_finished = $('#tbl_edw_finished').DataTable({ columns: column_status });

            // init table status
            //    $('#tbl_edw_all_status').dataTable().fnClearTable();
            $('#tbl_edw_all_status').dataTable().fnAddData(dataJsonStatusAll);
            //   $('#tbl_edw_monitor').dataTable().fnClearTable();
            if(dataJsonStatusAllMonitor !="")
            $('#tbl_edw_monitor').dataTable().fnAddData(dataJsonStatusAllMonitor);
            //     $('#tbl_edw_running').dataTable().fnClearTable();
            if(dataJsonStatusAllRunning !="")
            $('#tbl_edw_running').dataTable().fnAddData(dataJsonStatusAllRunning);
            //    $('#tbl_edw_finished').dataTable().fnClearTable();
            $('#tbl_edw_finished').dataTable().fnAddData(dataJsonStatusAllCompleted);

            //Add event listener for opening and closing details
            $('#tbl_edw_all_status tbody').on('click', 'td div img', function () {
                var tr = $(this).closest('tr');
                var row = tbl_all_status.row(tr);
                rowEven(tr, row);
            });

            $('#tbl_edw_monitor tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_monitor.row(tr);
                rowEven(tr, row);
            });

            $('#tbl_edw_running tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_running.row(tr);
                rowEven(tr, row);
            });

            $('#tbl_edw_finished tbody').on('click', 'td .button_status', function () {
                var tr = $(this).closest('tr');
                var row = tbl_finished.row(tr);
                rowEven(tr, row);
            });

        });

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

    <script src="js/echarts.min.js"></script>

    <style>
        .button_status {
            border: none;
            color: white;
            padding: 6px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 0px 0px -20px -7px;
            cursor: pointer;
            max-height: 5px;
            border-radius: 50%;
        }

        .button_status_timeline {
            border: none;
            color: white;
            padding: 3px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 0px 0px 2px 0px;
            cursor: pointer;
            max-height: 5px;
            border-radius: 50%;
        }

        a.menu-links {
            cursor: pointer;
        }


        .carousel-indicators {
            bottom: -42px;
        }

            .carousel-indicators li {
                display: inline-block;
                width: 12px;
                height: 12px;
                margin: 10px;
                text-indent: 0;
                cursor: pointer;
                border: none;
                border-radius: 50%;
                background-color: #D3D3D3;
                /*box-shadow: inset 1px 1px 1px 1px rgba(0,0,0,0.5);*/
            }

            .carousel-indicators .active {
                width: 12px;
                height: 12px;
                margin: 10px;
                background-color: #919191;
            }


        /* timeline chart */

        html {
            font-family: helvetica, arial;
        }

        .htimeline {
            list-style: none;
            padding: 0;
            margin: 0px 0 0;
        }

            .htimeline .step {
                float: left;
                border-bottom-style: solid;
                border-bottom-width: 5px;
                position: relative;
                margin-bottom: 10px;
                text-align: left;
                padding: 0px 0 5px 0px;
                background-color: #F5F5F5;
                color: #333;
                height: 330px;
                vertical-align: middle;
                border-right: solid 1px #bbb;
                transition: all 0.5s ease;
            }

                .htimeline .step:nth-child(odd) {
                    background-color: #eee;
                }

                .htimeline .step:first-child {
                    border-left: solid 1px #bbb;
                }

                .htimeline .step:hover {
                    background-color: #ccc;
                    border-bottom-width: 6px;
                }

                .htimeline .step div {
                    margin: 1px 5px;
                    font-size: 9px;
                    vertical-align: top;
                    padding: 0px;
                }

                .htimeline .step.green {
                    border-bottom-color: #348F50;
                }

                .htimeline .step.orange {
                    border-bottom-color: #F09819;
                }

                .htimeline .step.red {
                    border-bottom-color: #C04848;
                }

                .htimeline .step.blue {
                    /*border-bottom-color: #49a09d;*/
                    border-bottom-color: #00A27A;
                }

                .htimeline .step::before {
                    width: 15px;
                    height: 15px;
                    border-radius: 50px;
                    content: ' ';
                    background-color: white;
                    position: absolute;
                    bottom: -10px;
                    left: 0px;
                    border-style: solid;
                    border-width: 3px;
                    transition: all 0.5s ease;
                }

                .htimeline .step:hover::before {
                    width: 18px;
                    height: 18px;
                    bottom: -12px;
                }

                .htimeline .step.green::before {
                    border-color: #348F50;
                }

                .htimeline .step.orange::before {
                    border-color: #F09819;
                }

                .htimeline .step.red::before {
                    border-color: #C04848;
                }

                .htimeline .step.blue::before {
                    border-color: #49a09d;
                }

                .htimeline .step::after {
                    content: attr(data-date);
                    position: absolute;
                    bottom: 0px;
                    left: 17px;
                    font-size: 11px;
                    font-style: italic;
                    color: #888
                }
        /* end timeline chart */

        /*PULSING BUTTON */
        .pulse-button {
            box-shadow: 0 0 0 0 #d39e00;
            -webkit-animation: pulse 1.5s infinite;
        }

            .pulse-button:hover {
                -webkit-animation: none;
            }

        @-webkit-keyframes pulse {
            0% {
                -moz-transform: scale(1);
                -ms-transform: scale(1);
                -webkit-transform: scale(1);
                transform: scale(1);
            }

            70% {
                -moz-transform: scale(1);
                -ms-transform: scale(1);
                -webkit-transform: scale(1);
                transform: scale(1);
                box-shadow: 0 0 0 8px rgba(90, 153, 212, 0);
            }

            100% {
                -moz-transform: scale(1);
                -ms-transform: scale(1);
                -webkit-transform: scale(1);
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(90, 153, 212, 0);
            }
        }
        /*END PULSING BUTTON */
    </style>


</head>

<script type="text/javascript">


    $(document).ready(function () {

        var dataBatch = vaBatch_name;
        var dataCsla = vaC_sla;
        var dataEstHours = vaEst_hours;

        var optionBarChart = {
            legend: {
                show: true,
                data: [{ name: 'OPFOXPRO' }]

            },
            title: {
                x: 'center',
                text: 'Status',
                subtext: 'Service Level Agreement.',
                x: '50%'

            },
            tooltip: {
                trigger: 'item'
            },
            toolbox: {
                show: false,
                feature: {
                    dataView: { show: true, readOnly: false },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            grid: {
                borderWidth: 0,
                y: 80,
                y2: 60
            },

            xAxis: [
                {
                    type: 'category',
                    show: true,
                    //data: ['OPFOXPRO', 'OPEDWAML', 'OPEDWI'],
                    data: dataBatch,
                    axisLabel: { rotate: 90 }
                }

            ],
            yAxis: [
                {
                    type: 'value',
                    show: true
                }
            ],
            grid: [
                { height: 215 }
            ],
            series: [
                {
                    type: 'bar',

                    itemStyle: {
                        normal: {
                            color: function (params) {
                                // build a color map as your need.
                                //var colorList = ['#C1232B', '#B5C134', '#dc3545'];
                                var colorList = dataCsla;
                                return colorList[params.dataIndex]
                            },
                            label: {
                                show: true,
                                position: 'top',
                                //formatter: '{b}\n{c}'
                                formatter: '{c}'
                            }
                        }
                    },
                    //data: ["5", "21", "10"],
                    data: dataEstHours,
                    markPoint: {
                        tooltip: {
                            trigger: 'item',
                            backgroundColor: 'rgba(0,0,0,0)',
                            formatter: function (params) {
                                return '<img src="'
                                    + params.data.symbol.replace('image://', '')
                                    + '"/>';
                            }
                        }
                        //,
                        //data: [
                        //    { xAxis: 0, name: 'OPFOXPRO' },
                        //    { xAxis: 1, name: 'OPEDWAML' },
                        //    { xAxis: 2, name: 'OPEDWI' }

                        //]
                    }
                }
            ]
        };


        var dataSeries = vaSeries;
        var dataLegendData = vaLegendData;

        var dataSeriesSla = vaSeriesSla;
        var dataLegendDataSla = vaLegendDataSla;

        var optionPieChart = {

            title: {
                text: 'Live Statistics',
                subtext: 'Production Support.',
                x: '5%'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: '60%',

                //data: ['Monitor: 10', 'Running: 4', 'Complete: 44']
                data: dataLegendData
            },
            toolbox: {
                show: false,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    magicType: {
                        show: true,
                        type: ['pie', 'funnel'],
                        option: {
                            funnel: {
                                x: '25%',
                                width: '100%',
                                funnelAlign: 'left',
                                max: 1548
                            }
                        }
                    },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            series: [
                {
                    name: 'test',
                    type: 'pie',
                    radius: ['50', '80'],
                    center: ['50%', '55%'],
                    //data: [
                    //    { "value": "54", "name": 'Monitor: 54' },
                    //    { value: 4, name: 'Running: 4' },
                    //    { value: 44, name: 'Complete: 44' }
                    //],
                    data: dataSeries,
                    color: ['#33414e', '#fea223', '#1caf9a']
                }
            ]
        };

        var optionPieChartSla = {

            title: {
                text: 'Live Statistics',
                subtext: 'Service Level Agreement.',
                x: '5%'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: '60%',

                //data: ['Monitor: 10', 'Running: 4', 'Complete: 44']
                data: dataLegendDataSla
            },
            toolbox: {
                show: false,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    magicType: {
                        show: true,
                        type: ['pie', 'funnel'],
                        option: {
                            funnel: {
                                x: '25%',
                                width: '100%',
                                funnelAlign: 'left',
                                max: 1548
                            }
                        }
                    },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            series: [
                {
                    name: 'test',
                    type: 'pie',
                    radius: ['50', '80'],
                    center: ['50%', '55%'],
                    //data: [
                    //    { "value": "54", "name": 'Monitor: 54' },
                    //    { value: 4, name: 'Running: 4' },
                    //    { value: 44, name: 'Complete: 44' }
                    //],
                    data: dataSeriesSla,
                    color: ['#33414e', '#c82333', '#1caf9a']
                }
            ]
        };



        var pieChart = echarts.init(document.getElementById('pieChart'));
        var pieChartSla = echarts.init(document.getElementById('pieChartSla'));
        var barChart = echarts.init(document.getElementById('barChart'));


        // Load data into the ECharts instance 
        pieChart.setOption(optionPieChart);
        pieChartSla.setOption(optionPieChartSla);
        barChart.setOption(optionBarChart);
    });



</script>
<body style="padding-top: 70px;" class="bg-light">

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

        <form id="frmEDW" runat="server">
            <!-- dash board head -->
            <div class="row">
                <!-- 2 display .Now display data HML -->
                <div class="col-3">
                    <!-- summary job now display = none -->
                    <div style="display: none;" class="widget widget-default widget-carousel">
                        <div id="demo" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div>
                                        <div class="widget-title">Monitor</div>
                                        <div class="widget-subtitle">Job</div>
                                        <div id="div_num_monitor" runat="server" class="widget-int"></div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div>
                                        <div class="widget-title">Running</div>
                                        <div class="widget-subtitle">Job</div>
                                        <div id="div_num_running" runat="server" class="widget-int"></div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div>
                                        <div class="widget-title">Completed</div>
                                        <div class="widget-subtitle">Job</div>
                                        <div id="div_num_completed" runat="server" class="widget-int"></div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div>
                                        <div class="widget-title">Total</div>
                                        <div class="widget-subtitle">Job</div>
                                        <div id="div_num_total" runat="server" class="widget-int"></div>
                                    </div>
                                </div>
                            </div>
                            <ul class="carousel-indicators ">
                                <li data-target="#demo" data-slide-to="0" class="active"></li>
                                <li data-target="#demo" data-slide-to="1"></li>
                                <li data-target="#demo" data-slide-to="2"></li>
                                <li data-target="#demo" data-slide-to="3"></li>
                            </ul>
                        </div>
                    </div>
                    <!-- End summary job now display = none -->

                    <!-- data H M L   -->
                    <div class="widget widget-default widget-carousel">
                        <div id="hml" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="widget-subtitle">High</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Medium</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Low</div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div id="monitor_h" runat="server" class="widget-int">50</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="monitor_m" runat="server" class="widget-int">18</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="monitor_l" runat="server" class="widget-int">24</div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="widget-title">Monitor</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="widget-subtitle">High</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Medium</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Low</div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div id="running_h" runat="server" class="widget-int">50</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="running_m" runat="server" class="widget-int">18</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="running_l" runat="server" class="widget-int">24</div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <div class="widget-title">Running</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="widget-subtitle">High</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Medium</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Low</div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div id="complete_h" runat="server" class="widget-int">50</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="complete_m" runat="server" class="widget-int">18</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="complete_l" runat="server" class="widget-int">24</div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <div class="widget-title">Completed</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="widget-subtitle">High</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Medium</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="widget-subtitle">Low</div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <div id="total_h" runat="server" class="widget-int">50</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="total_m" runat="server" class="widget-int">18</div>
                                            </div>
                                            <div class="col-4">
                                                <div id="total_l" runat="server" class="widget-int">24</div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <div class="widget-title">Total</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <ul class="carousel-indicators ">
                                <li data-target="#hml" data-slide-to="0" class="active"></li>
                                <li data-target="#hml" data-slide-to="1"></li>
                                <li data-target="#hml" data-slide-to="2"></li>
                                <li data-target="#hml" data-slide-to="3"></li>
                            </ul>
                        </div>
                    </div>
                    <!-- End data H M L   -->
                </div>

                <!-- summary Meet Miss -->
                <div class="col-3">
                    <div class="widget widget-default widget-item-icon" onclick="#">
                        <div class="widget-item-left">
                            <span class="fa fa-envelope"></span>
                        </div>
                        <div class="widget-data">
                            <div class="row">
                                <div class="col-6">
                                    <div style="text-align: center !important;" id="div_num_meet" runat="server" class="widget-int num-count"></div>
                                </div>
                                <div class="col-6">
                                    <div id="div_num_miss" runat="server" class="widget-int num-count"></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div style="text-align: center !important;" class="widget-title">MEET</div>
                                </div>
                                <div class="col-6">
                                    <div class="widget-title">MISS</div>
                                </div>
                            </div>
                            <div class="row justify-content-around">
                                <div class="col-8">
                                    <div style="margin-top: 7px;" class="widget-subtitle">Service Level Agreement.</div>
                                </div>

                            </div>
                        </div>
                        <div class="widget-controls">
                            <%-- <a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="top" title="Remove Widget"><span class="fa fa-times"></span></a>--%>
                        </div>
                    </div>
                </div>
                <!--End summary Meet Miss -->

                <!-- display person production support team or logo -->
                <div class="col-3">
                    <div class="widget widget-default widget-item-icon" onclick="#">
                        <div class="widget-item-left">
                            <span class="fa fa-user"></span>
                        </div>
                        <div class="widget-data">
                            <div runat="server" class="widget-int num-count">
                                <img width="100" height="20" class="media-object" src="pic/logo_oracle.svg" alt="Generic placeholder image">
                            </div>
                            <%-- <div style="margin-top: 3px;" class="widget-title">Mr.EIM</div>--%>
                            <div style="margin-top: 4px;" class="widget-subtitle">Production Support Team.</div>
                        </div>
                        <div class="widget-controls">
                        </div>
                    </div>
                </div>
                <!-- End display person production support team -->

                <!-- display current date time -->
                <div class="col-3">
                    <div class="widget widget-info widget-padding-sm">
                        <div class="widget-big-int plugin-clock">14<span>:</span>47</div>
                        <div class="widget-subtitle plugin-date">Thursday, May 17, 2018</div>
                        <div class="widget-controls">
                            <%--<a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="left" title="Remove Widget"><span class="fa fa-times"></span></a>--%>
                        </div>
                        <div class="widget-buttons widget-c3">
                            <div class="col">
                                <a href="#"><span class="fa fa-clock-o"></span></a>
                            </div>
                            <div class="col">
                                <a href="#"><span class="fa fa-bell"></span></a>
                            </div>
                            <div class="col">
                                <a href="#"><span class="fa fa-calendar"></span></a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End display current date time -->

            </div>

            <!-- dash board pie and line -->
            <div class="row">
                <!-- timeline chart -->
                <div class="col-8">
                    <div class="card card-body rounded-0">
                        <!-- Main Slide Timeline -->
                        <div id="slide_timeline" class="carousel slide" data-ride="carousel" data-interval="20000">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <!-- Container Timeline all -->
                                    <div class='container-fluid'>
                                        <div class="row">
                                            <div class="col-8">
                                                <h6>Timeline        
                                                    <div>
                                                        <button type='button' style='background-color: #212529;' class='button_status_timeline btn '></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Monitor</strong>
                                                        <button type='button' class='button_status_timeline btn btn-warning'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Running</strong>
                                                        <button type='button' class='button_status_timeline btn btn-success'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Completed</strong>
                                                    </div>
                                                </h6>
                                            </div>
                                        </div>
                                        <ul class="htimeline">
                                            <li id="li_timeline6" data-date='20:00 - 23:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_6" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline1" data-date='00:00 - 03:59' class='step col-sm-2 blue'>                                                
                                                    <asp:Literal ID="lt_timeline_1" runat="server"></asp:Literal>                                                
                                            </li>
                                            <li id="li_timeline2" data-date='04:00 - 07:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_2" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline3" data-date='08:00 - 11:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_3" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline4" data-date='12:00 - 15:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_4" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline5" data-date='16:00 - 19:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_5" runat="server"></asp:Literal>
                                            </li>
                                            
                                        </ul>
                                    </div>
                                    <!-- End Container Timeline all -->
                                </div>
                                <div class="carousel-item">
                                    <!-- Container Timeline Sla -->
                                    <div class='container-fluid'>
                                        <div class="row">
                                            <div class="col-8">
                                                <h6>Service Level Agreement
                                                    <div>
                                                        <button type='button' style='background-color: #212529;' class='button_status_timeline btn '></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Na</strong>
                                                        <button type='button' class='button_status_timeline btn btn-danger'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Miss</strong>
                                                        <button type='button' class='button_status_timeline btn btn-success'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Meet</strong>
                                                    </div>
                                                </h6>
                                            </div>
                                        </div>
                                        <ul class="htimeline">
                                            <li id="li_timeline_sla6" data-date='20:00 - 23:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_6" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline_sla1" data-date='00:00 - 03:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_1" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline_sla2" data-date='04:00 - 07:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_2" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline_sla3" data-date='08:00 - 11:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_3" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline_sla4" data-date='12:00 - 15:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_4" runat="server"></asp:Literal>
                                            </li>
                                            <li id="li_timeline_sla5" data-date='16:00 - 19:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_5" runat="server"></asp:Literal>
                                            </li>
                                            
                                        </ul>
                                    </div>
                                    <!-- End Container Timeline Sla-->
                                </div>
                            </div>
                            <ul class="carousel-indicators ">
                                <li data-target="#slide_timeline" data-slide-to="0" class="active"></li>
                                <li data-target="#slide_timeline" data-slide-to="1"></li>
                            </ul>
                        </div>
                        <!-- End Main Slide Timeline -->
                    </div>
                </div>
                <!-- pie chart -->
                <div class="col-4">
                    <div class="row">
                        <div class="col-12">
                            <!-- pie chart on slide -->
                            <div style="display: none" class="card rounded-0">
                                <div class="card card-body rounded-0">
                                    <div id="slide_pieChart" class="carousel slide" data-ride="carousel" data-interval="20000">
                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <div id="pieChart" style="width: 100%; height: 370px;"></div>
                                            </div>
                                            <div class="carousel-item">
                                                <div id="pieChartSla" style="width: 376px; height: 370px;"></div>
                                            </div>
                                        </div>
                                        <ul class="carousel-indicators ">
                                            <li data-target="#slide_pieChart" data-slide-to="0" class="active"></li>
                                            <li data-target="#slide_pieChart" data-slide-to="1"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- pie chart 4 chart -->
                            <div style="display: none" class="card rounded-0">
                                <div class="card-header bg-white">
                                    <h6 style="text-align: center;">Live Statistics</h6>
                                </div>
                                <div class="card card-body rounded-0">
                                    <div class="row">
                                        <div class="col-5">
                                            <div class="progress-circle over50 p56">
                                                <span style="margin-top: -10px; color: #33414e !important;">58
                                                    <h6 style="margin-top: -40px;">Monitor</h6>
                                                </span>

                                                <div class="left-half-clipper">
                                                    <div style="background-color: #33414e !important;" class="first50-bar text-red"></div>
                                                    <div style="border-color: #33414e !important;" class="value-bar"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="progress-circle p4">
                                                <span style="margin-top: -10px; color: #fea223 !important;">4
                                                    <h6 style="margin-top: -40px;">Running</h6>
                                                </span>
                                                <div class="left-half-clipper">
                                                    <div style="border-color: #fea223 !important" class="first50-bar"></div>
                                                    <div style="border-color: #fea223 !important" class="value-bar"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-5">
                                            <div class="progress-circle p40">
                                                <span style="margin-top: -10px; color: #1caf9a !important;">41
                                                    <h6 style="margin-top: -40px;">Complete</h6>
                                                </span>
                                                 
                                                <div class="left-half-clipper">
                                                    <div style="background-color: #1caf9a !important;" class="first50-bar"></div>
                                                    <div style="border-color: #1caf9a !important;" class="value-bar"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="progress-circle over50 p100">
                                                <span style="margin-top: -10px;">1305
                                                    <h6 style="margin-top: -35px;">Total</h6>
                                                </span>
                                                <div class="left-half-clipper">
                                                    <div class="first50-bar"></div>
                                                    <div class="value-bar"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- style sheet custom line for pie chart  -->
                            <style>
                                #hr {
                                    background-color: #00A27A;
                                    color: #C80000;
                                    -webkit-transform: rotate(35deg);
                                    position: absolute;
                                    width: 50px;
                                    height: 2px;
                                    left: 160px;
                                    border: 2px;
                                    margin: -45px 20px;
                                }

                                #hr2 {
                                    background-color: #00A27A;
                                    color: #C80000;
                                    -webkit-transform: rotate(0deg);
                                    position: absolute;
                                    width: 170px;
                                    height: 2px;
                                    left: -14px;
                                    border: 2px;
                                    margin-top: 17px;
                                }
                            </style>
                            
                            <!-- card pie chart and num summary on below -->
                            <div class="card rounded-0">
                                <div class="card-body rounded-0 text-center">
                                    <div class="card-header mb-2 border-0 bg-white">
                                    </div>
                                    <div class="row justify-content-center">
                                        <div class="col-7">
                                            <div runat="server" id="div_bar_circle" class="">
                                                <span runat="server" id="span_bar_circle" style="font-size: 60px !important; margin-left: -75px; margin-top: -85px; color: #00A27A !important;">90
                                                    <%--<h6 style="margin-top: -120px">Completed</h6>--%>
                                                </span>
                                                <span style="position:absolute;margin-top:30px; margin-left:65px; font-size: 20px; font-weight:400; color:#00A27A;">%</span>
                                                <span style="font-size: 16px !important; margin-left: 35px; margin-top: 70px; color: #00A27A !important;">Completed</span>
                                                <div class="left-half-clipper">
                                                    <div style="background-color: #00A27A !important;" class="first50-bar"></div>
                                                    <div style="border-color: #00A27A !important;" class="value-bar"></div>
                                                </div>
                                            </div>
                                            <hr id="hr" />
                                        </div>
                                        <div class="col-5 align-self-center text-left">

                                            <span class="text-success">Total</span>
                                            <h2 id="h_total_on_pie" runat="server" style="font-weight: 400" class="text-muted">1308</h2>
                                            <span>Live Statistics</span>
                                            <hr id="hr2" />
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-4 border-right">
                                            <h3 id="h_complete_on_pie" runat="server" style="font-weight: 400">65%</h3>                                           
                                            <span class="text-success">Completed
                                            </span>
                                        </div>
                                        <div class="col-4 border-right">
                                            <h3 id="h_running_on_pie" runat="server" style="font-weight: 400">25%</h3>
                                            <span class="text-warning">Running</span>
                                        </div>
                                        <div class="col-4">
                                            <h3 id="h_monitor_on_pie" runat="server" style="font-weight: 400">10%</h3>
                                            <span class="text-secondary">Monitor</span>
                                        </div>
                                    </div>

                                </div>
                                <br />
                                <br />
                                <br />
                            </div>

                        </div>
                    </div>
                </div>
                <style>
                    /* css-circular-prog-bar.css */

                    .progress-circle {
                        font-size: 30px;
                        margin: 20px;
                        position: relative; /* so that children can be absolutely positioned */
                        padding: 0;
                        width: 5em;
                        height: 5em;
                        background-color: #F2E9E1;
                        border-radius: 50%;
                        line-height: 5em;
                    }

                        .progress-circle:after {
                            border: none;
                            position: absolute;
                            top: 0.35em;
                            left: 0.35em;
                            text-align: center;
                            display: block;
                            border-radius: 50%;
                            width: 4.3em;
                            height: 4.3em;
                            background-color: white;
                            content: "";
                        }
                        /* Text inside the control */
                        .progress-circle span {
                            position: absolute;
                            line-height: 5em;
                            width: 5em;
                            text-align: center;
                            display: block;
                            color: #53777A;
                            z-index: 2;
                        }

                    .left-half-clipper {
                        /* a round circle */
                        border-radius: 50%;
                        width: 5em;
                        height: 5em;
                        position: absolute; /* needed for clipping */
                        clip: rect(0, 5em, 5em, 2.5em); /* clips the whole left half*/
                    }
                    /* when p>50, don't clip left half*/
                    .progress-circle.over50 .left-half-clipper {
                        clip: rect(auto,auto,auto,auto);
                    }

                    .value-bar {
                        /*This is an overlayed square, that is made round with the border radius,
   then it is cut to display only the left half, then rotated clockwise
   to escape the outer clipping path.*/
                        position: absolute; /*needed for clipping*/
                        clip: rect(0, 2.5em, 5em, 0);
                        width: 5em;
                        height: 5em;
                        border-radius: 50%;
                        border: 0.45em solid #53777A; /*The border is 0.35 but making it larger removes visual artifacts */
                        /*background-color: #4D642D;*/ /* for debug */
                        box-sizing: border-box;
                    }
                    /* Progress bar filling the whole right half for values above 50% */
                    .progress-circle.over50 .first50-bar {
                        /*Progress bar for the first 50%, filling the whole right half*/
                        position: absolute; /*needed for clipping*/
                        clip: rect(0, 5em, 5em, 2.5em);
                        background-color: #53777A;
                        border-radius: 50%;
                        width: 5em;
                        height: 5em;
                    }

                    .progress-circle:not(.over50) .first50-bar {
                        display: none;
                    }


                    /* Progress bar rotation position */
                    .progress-circle.p0 .value-bar {
                        display: none;
                    }

                    .progress-circle.p1 .value-bar {
                        transform: rotate(4deg);
                    }

                    .progress-circle.p2 .value-bar {
                        transform: rotate(7deg);
                    }

                    .progress-circle.p3 .value-bar {
                        transform: rotate(11deg);
                    }

                    .progress-circle.p4 .value-bar {
                        transform: rotate(14deg);
                    }

                    .progress-circle.p5 .value-bar {
                        transform: rotate(18deg);
                    }

                    .progress-circle.p6 .value-bar {
                        transform: rotate(22deg);
                    }

                    .progress-circle.p7 .value-bar {
                        transform: rotate(25deg);
                    }

                    .progress-circle.p8 .value-bar {
                        transform: rotate(29deg);
                    }

                    .progress-circle.p9 .value-bar {
                        transform: rotate(32deg);
                    }

                    .progress-circle.p10 .value-bar {
                        transform: rotate(36deg);
                    }

                    .progress-circle.p11 .value-bar {
                        transform: rotate(40deg);
                    }

                    .progress-circle.p12 .value-bar {
                        transform: rotate(43deg);
                    }

                    .progress-circle.p13 .value-bar {
                        transform: rotate(47deg);
                    }

                    .progress-circle.p14 .value-bar {
                        transform: rotate(50deg);
                    }

                    .progress-circle.p15 .value-bar {
                        transform: rotate(54deg);
                    }

                    .progress-circle.p16 .value-bar {
                        transform: rotate(58deg);
                    }

                    .progress-circle.p17 .value-bar {
                        transform: rotate(61deg);
                    }

                    .progress-circle.p18 .value-bar {
                        transform: rotate(65deg);
                    }

                    .progress-circle.p19 .value-bar {
                        transform: rotate(68deg);
                    }

                    .progress-circle.p20 .value-bar {
                        transform: rotate(72deg);
                    }

                    .progress-circle.p21 .value-bar {
                        transform: rotate(76deg);
                    }

                    .progress-circle.p22 .value-bar {
                        transform: rotate(79deg);
                    }

                    .progress-circle.p23 .value-bar {
                        transform: rotate(83deg);
                    }

                    .progress-circle.p24 .value-bar {
                        transform: rotate(86deg);
                    }

                    .progress-circle.p25 .value-bar {
                        transform: rotate(90deg);
                    }

                    .progress-circle.p26 .value-bar {
                        transform: rotate(94deg);
                    }

                    .progress-circle.p27 .value-bar {
                        transform: rotate(97deg);
                    }

                    .progress-circle.p28 .value-bar {
                        transform: rotate(101deg);
                    }

                    .progress-circle.p29 .value-bar {
                        transform: rotate(104deg);
                    }

                    .progress-circle.p30 .value-bar {
                        transform: rotate(108deg);
                    }

                    .progress-circle.p31 .value-bar {
                        transform: rotate(112deg);
                    }

                    .progress-circle.p32 .value-bar {
                        transform: rotate(115deg);
                    }

                    .progress-circle.p33 .value-bar {
                        transform: rotate(119deg);
                    }

                    .progress-circle.p34 .value-bar {
                        transform: rotate(122deg);
                    }

                    .progress-circle.p35 .value-bar {
                        transform: rotate(126deg);
                    }

                    .progress-circle.p36 .value-bar {
                        transform: rotate(130deg);
                    }

                    .progress-circle.p37 .value-bar {
                        transform: rotate(133deg);
                    }

                    .progress-circle.p38 .value-bar {
                        transform: rotate(137deg);
                    }

                    .progress-circle.p39 .value-bar {
                        transform: rotate(140deg);
                    }

                    .progress-circle.p40 .value-bar {
                        transform: rotate(144deg);
                    }

                    .progress-circle.p41 .value-bar {
                        transform: rotate(148deg);
                    }

                    .progress-circle.p42 .value-bar {
                        transform: rotate(151deg);
                    }

                    .progress-circle.p43 .value-bar {
                        transform: rotate(155deg);
                    }

                    .progress-circle.p44 .value-bar {
                        transform: rotate(158deg);
                    }

                    .progress-circle.p45 .value-bar {
                        transform: rotate(162deg);
                    }

                    .progress-circle.p46 .value-bar {
                        transform: rotate(166deg);
                    }

                    .progress-circle.p47 .value-bar {
                        transform: rotate(169deg);
                    }

                    .progress-circle.p48 .value-bar {
                        transform: rotate(173deg);
                    }

                    .progress-circle.p49 .value-bar {
                        transform: rotate(176deg);
                    }

                    .progress-circle.p50 .value-bar {
                        transform: rotate(180deg);
                    }

                    .progress-circle.p51 .value-bar {
                        transform: rotate(184deg);
                    }

                    .progress-circle.p52 .value-bar {
                        transform: rotate(187deg);
                    }

                    .progress-circle.p53 .value-bar {
                        transform: rotate(191deg);
                    }

                    .progress-circle.p54 .value-bar {
                        transform: rotate(194deg);
                    }

                    .progress-circle.p55 .value-bar {
                        transform: rotate(198deg);
                    }

                    .progress-circle.p56 .value-bar {
                        transform: rotate(202deg);
                    }

                    .progress-circle.p57 .value-bar {
                        transform: rotate(205deg);
                    }

                    .progress-circle.p58 .value-bar {
                        transform: rotate(209deg);
                    }

                    .progress-circle.p59 .value-bar {
                        transform: rotate(212deg);
                    }

                    .progress-circle.p60 .value-bar {
                        transform: rotate(216deg);
                    }

                    .progress-circle.p61 .value-bar {
                        transform: rotate(220deg);
                    }

                    .progress-circle.p62 .value-bar {
                        transform: rotate(223deg);
                    }

                    .progress-circle.p63 .value-bar {
                        transform: rotate(227deg);
                    }

                    .progress-circle.p64 .value-bar {
                        transform: rotate(230deg);
                    }

                    .progress-circle.p65 .value-bar {
                        transform: rotate(234deg);
                    }

                    .progress-circle.p66 .value-bar {
                        transform: rotate(238deg);
                    }

                    .progress-circle.p67 .value-bar {
                        transform: rotate(241deg);
                    }

                    .progress-circle.p68 .value-bar {
                        transform: rotate(245deg);
                    }

                    .progress-circle.p69 .value-bar {
                        transform: rotate(248deg);
                    }

                    .progress-circle.p70 .value-bar {
                        transform: rotate(252deg);
                    }

                    .progress-circle.p71 .value-bar {
                        transform: rotate(256deg);
                    }

                    .progress-circle.p72 .value-bar {
                        transform: rotate(259deg);
                    }

                    .progress-circle.p73 .value-bar {
                        transform: rotate(263deg);
                    }

                    .progress-circle.p74 .value-bar {
                        transform: rotate(266deg);
                    }

                    .progress-circle.p75 .value-bar {
                        transform: rotate(270deg);
                    }

                    .progress-circle.p76 .value-bar {
                        transform: rotate(274deg);
                    }

                    .progress-circle.p77 .value-bar {
                        transform: rotate(277deg);
                    }

                    .progress-circle.p78 .value-bar {
                        transform: rotate(281deg);
                    }

                    .progress-circle.p79 .value-bar {
                        transform: rotate(284deg);
                    }

                    .progress-circle.p80 .value-bar {
                        transform: rotate(288deg);
                    }

                    .progress-circle.p81 .value-bar {
                        transform: rotate(292deg);
                    }

                    .progress-circle.p82 .value-bar {
                        transform: rotate(295deg);
                    }

                    .progress-circle.p83 .value-bar {
                        transform: rotate(299deg);
                    }

                    .progress-circle.p84 .value-bar {
                        transform: rotate(302deg);
                    }

                    .progress-circle.p85 .value-bar {
                        transform: rotate(306deg);
                    }

                    .progress-circle.p86 .value-bar {
                        transform: rotate(310deg);
                    }

                    .progress-circle.p87 .value-bar {
                        transform: rotate(313deg);
                    }

                    .progress-circle.p88 .value-bar {
                        transform: rotate(317deg);
                    }

                    .progress-circle.p89 .value-bar {
                        transform: rotate(320deg);
                    }

                    .progress-circle.p90 .value-bar {
                        transform: rotate(324deg);
                    }

                    .progress-circle.p91 .value-bar {
                        transform: rotate(328deg);
                    }

                    .progress-circle.p92 .value-bar {
                        transform: rotate(331deg);
                    }

                    .progress-circle.p93 .value-bar {
                        transform: rotate(335deg);
                    }

                    .progress-circle.p94 .value-bar {
                        transform: rotate(338deg);
                    }

                    .progress-circle.p95 .value-bar {
                        transform: rotate(342deg);
                    }

                    .progress-circle.p96 .value-bar {
                        transform: rotate(346deg);
                    }

                    .progress-circle.p97 .value-bar {
                        transform: rotate(349deg);
                    }

                    .progress-circle.p98 .value-bar {
                        transform: rotate(353deg);
                    }

                    .progress-circle.p99 .value-bar {
                        transform: rotate(356deg);
                    }

                    .progress-circle.p100 .value-bar {
                        transform: rotate(360deg);
                    }
                </style>
                <!-- chart all status -->
                <%--<link rel="stylesheet" href="css/css-circular-prog-bar.css" />--%>


                <!-- summary progress bar -->
                <div class="col-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-6">
                                    <div class="progress-circle p40">
                                        <span style="margin-top: -10px; color: #1caf9a !important;">41
                                                    <h6 style="margin-top: -60px">Conplete</h6>
                                        </span>                                        
                                        <div class="left-half-clipper">
                                            <div style="background-color: #1caf9a !important;" class="first50-bar"></div>
                                            <div style="border-color: #1caf9a !important;" class="value-bar"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 align-self-center">
                                    <span class="text-muted">Live Statistics</span>
                                    <h2 style="font-weight: 400" class="text-muted">1308</h2>
                                    <span class="text-success">Total</span>

                                </div>
                            </div>



                            <!-- porgress bar -->
                            <div class="row">
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-3 text-right">
                                            <span class="text-secondary">Monitor</span>
                                        </div>
                                        <div class="col-6">
                                            <div class="progress" style="height: 10px; margin-top: 8px;">
                                                <div class="progress-bar bg-secondary" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <h6 class="text-secondary">30</h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3 text-right">
                                            <span class="text-warning">Running</span>
                                        </div>
                                        <div class="col-6">
                                            <div class="progress" style="height: 10px; margin-top: 8px;">
                                                <div class="progress-bar bg-warning" role="progressbar" style="width: 15%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <h6 class="text-secondary">15</h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3 text-right">
                                            <span class="text-success">Completed</span>
                                        </div>
                                        <div class="col-6">
                                            <div class="progress" style="height: 10px; margin-top: 8px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <h6 class="text-secondary">65</h6>
                                        </div>
                                    </div>

                                </div>



                            </div>
                        </div>
                    </div>


                </div>

            </div>

            <br />

            <!-- dash board timeline -->
            <div class="row">


                <!-- bar chart -->
                <div class="col-4">
                    <div class="card rounded-0">
                        <div class="card card-body rounded-0">
                            
                            <div id="barChart" style="width: 100%; height: 370px; overflow: scroll;"></div>
                            
                        </div>
                    </div>
                </div>

                <!-- none -->
                <%--<div class="col-4">
                    <div class="card card-body rounded-0">ffffffff</div>
                </div>--%>
            </div>

            <br />

            <!-- table detail -->
            <div class="row">
                <div class="col-sm-12">
                    <!-- status  -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card rounded-0">
                                <div class="card-header bg-white">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <div class="row">
                                                <div class="col-sm-1">
                                                    <img class="justify-content-start" width="80" src="pic/logo_oracle.svg" />
                                                </div>
                                                <div class="col-sm-5 align-items-end">
                                                    <h6 style="font-size: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status</h6>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_edw_status">
                                                <i class="fa fa-chevron-circle-down"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="collapse show" id="collapse_tbl_edw_status">
                                    <div class="card-body">

                                        <!--  tab head status -->
                                        <ul class="nav nav-tabs" id="tab_edw_status" role="tablist" style="font-size: 12px;">
                                            <li class="nav-item">
                                                <a class="nav-link show active" id="tab_edw_all_status" data-toggle="tab" href="#div_tbl_edw_all_status" role="tab" aria-controls="div_tbl_edw_all_status" aria-selected="true">All</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_monitor" data-toggle="tab" href="#div_tbl_edw_monitor" role="tab" aria-controls="div_tbl_edw_monitor" aria-selected="true">Monitor</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_running" data-toggle="tab" href="#div_tbl_edw_running" role="tab" aria-controls="div_tbl_edw_running" aria-selected="true">Running</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_finished" data-toggle="tab" href="#div_tbl_edw_finished" role="tab" aria-controls="div_tbl_edw_finished" aria-selected="true">Completed</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <!-- table edw daily in tab status -->
                                            <div class="tab-pane fade show active" id="div_tbl_edw_all_status" role="tabpanel" aria-labelledby="div_tbl_edw_all_status">
                                                <div class="container-fluid" style="font-size: 11px;">
                                                    <table id="tbl_edw_all_status" class="table table-sm table-hover ">
                                                        <thead>
                                                            <tr>
                                                                <th width="5%">#</th>
                                                                <th width="10%">Person</th>
                                                                <%--<th>Status</th>--%>
                                                                <%--<th>Sla</th>
                                                                <th>C_Sla</th>--%>
                                                                <th>Work_Name</th>
                                                                <th width="10%">Batch_Name</th>
                                                                <th width="10%">Business_Date</th>
                                                                <th>Job_Start_Date</th>
                                                                <%--<th>Job_End_Date</th>--%>
                                                                <th>Frequency</th>
                                                                <%-- <th>Est_hours</th>
                                                                <th>Avg_c</th>--%>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_edw_all_status" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_monitor" role="tabpanel" aria-labelledby="div_tbl_edw_monitor">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_monitor" class="table table-sm table-hover ">
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
                                                                <%-- <th>Est_hours</th>
                                                                <th>Avg_c</th>--%>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_edw_monitor" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_running" role="tabpanel" aria-labelledby="div_tbl_edw_running">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_running" class="table table-sm table-hover ">
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
                                                                <%-- <th>Est_hours</th>
                                                                <th>Avg_c</th>--%>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_edw_running" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_finished" role="tabpanel" aria-labelledby="div_tbl_edw_finished">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_finished" class="table table-sm table-hover ">
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
                                                                <%--<th>Est_hours</th>
                                                                <th>Avg_c</th>--%>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Literal ID="lt_tbl_edw_finished" runat="server"></asp:Literal>
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
                    <!-- Frequency -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card rounded-0">
                                <div class="card-header bg-white">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <h6>EDW Frequency</h6>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <a class="text-dark" data-toggle="collapse" href="#collapse_tbl_edw_frequency">
                                                <i class="fa fa-chevron-circle-down"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="collapse" id="collapse_tbl_edw_frequency">
                                    <div class="card-body">

                                        <!--  tab head frequency -->
                                        <ul class="nav nav-tabs" id="tab_edw_frequency" role="tablist" style="font-size: 12px;">
                                            <li class="nav-item">
                                                <a class="nav-link show active" id="tab_edw_all_frequency" data-toggle="tab" href="#div_tbl_edw_all_frequency" role="tab" aria-controls="div_tbl_edw_all_frequency" aria-selected="true">All</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_daily" data-toggle="tab" href="#div_tbl_edw_daily" role="tab" aria-controls="div_tbl_edw_daily" aria-selected="true">Daily</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_workdays" data-toggle="tab" href="#div_tbl_edw_workdays" role="tab" aria-controls="div_tbl_edw_workdays" aria-selected="true">Workdays</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_weekly" data-toggle="tab" href="#div_tbl_edw_weekly" role="tab" aria-controls="div_tbl_edw_weekly" aria-selected="true">Weekly</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab_edw_monthly" data-toggle="tab" href="#div_tbl_edw_monthly" role="tab" aria-controls="div_tbl_edw_monthly" aria-selected="true">Monthly</a>
                                            </li>

                                        </ul>
                                        <div class="tab-content">
                                            <!-- table edw daily in tab frequency  -->
                                            <div class="tab-pane fade show active" id="div_tbl_edw_all_frequency" role="tabpanel" aria-labelledby="div_tbl_edw_all_frequency">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_all_frequency" class="table table-sm table-hover ">
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
                                                            <asp:Literal ID="lt_tbl_edw_all_frequency" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_daily" role="tabpanel" aria-labelledby="div_tbl_edw_daily">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_daily" class="table table-sm table-hover ">
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
                                                            <asp:Literal ID="lt_tbl_edw_daily" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_workdays" role="tabpanel" aria-labelledby="div_tbl_edw_workdays">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_workdays" class="table table-sm table-hover ">
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
                                                            <asp:Literal ID="lt_tbl_edw_workdays" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_weekly" role="tabpanel" aria-labelledby="div_tbl_edw_weekly">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_weekly" class="table table-sm table-hover ">
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
                                                            <asp:Literal ID="lt_tbl_edw_weekly" runat="server"></asp:Literal>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="div_tbl_edw_monthly" role="tabpanel" aria-labelledby="div_tbl_edw_monthly">
                                                <div class="container" style="font-size: 11px;">
                                                    <table id="tbl_edw_monthly" class="table table-sm table-hover ">
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
                                                            <asp:Literal ID="lt_tbl_edw_monthly" runat="server"></asp:Literal>
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

                <div class="col-sm-3" style="display: none;">
                    <!-- summary status -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-white">
                                    <table>
                                        <tr>
                                            <td><i class="fa fa-bar-chart fa-2x text-info"></i></td>
                                            <td>
                                                <h6>&nbsp;&nbsp;EDW Progress</h6>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="card-body">
                                    <div class="row p-2">
                                        <div class="col-sm-6 border-primary" style="display: block;">
                                            <h4 runat="server" id="h_num_monitor">0</h4>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="font-size: 12px;">Monitor</td>
                                                    <td runat="server" id="p_monitor_p" style="font-size: 10px; text-align: right;"></td>
                                                </tr>
                                            </table>
                                            <div class="progress" style="height: 3px;">
                                                <div runat="server" id="probar_monitor" class="progress-bar bg-dark" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <h4 runat="server" id="h_num_running">0</h4>
                                            <%--<div class="text-muted" style="padding: 5px;">Running</div>--%>
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
                    <!-- end summary status  -->
                    <br />
                    <!-- summary sla -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-white">
                                    <table>
                                        <tr>
                                            <td><i class="fa fa-line-chart fa-2x text-info"></i></td>
                                            <td>
                                                <h6>&nbsp;&nbsp;SLA Progress</h6>
                                            </td>
                                        </tr>
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
                                                <div runat="server" id="probar_na" class="progress-bar bg-dark" role="progressbar" style="width: 0%" aria-valuemin="0" aria-valuemax="100"></div>
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
