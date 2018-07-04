<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormEDW_v3.aspx.cs" Inherits="EDM_DailyStatus.FormEDW_v3" %>

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
        var dataMrrisDonut = vaDataMrrisDonut;
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

        $(document).ready(function () {
            templatePlugins.init();
            setCurrentTimeline();

            page_time_reload(300000);

            //--- ajax Morris Line chart ---
            $.ajax({
                type: "POST",
                url: "FormEDW_v3.aspx/getDataMorrisLineChart",
                // data: '{"project":"' + project + '","tier":"' + tier + '","status":"' + status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    dataLineChart = JSON.parse(response.d);
                    intMorrisChart();
                },
                failure: function (response) {
                    alert('ajax failed');
                    alert(response.d);
                }
            });
            intMorrisPie(dataMrrisDonut);


        }); //-- end document ready ----



        function intMorrisChart() {
            new Morris.Area({
                // ID of the element in which to draw the chart.
                element: 'morris_line_chart',
                // Chart data records -- each entry in this array corresponds to a point on
                // the chart.
                lineColors: ['#55cdb4'],
                pointSize: '0px',
                data: dataLineChart,
                // The name of the data record attribute that contains x-values.

                xkey: 'Name',
                // A list of names of data record attributes that contain y-values.
                ykeys: ['Value'],
                // Labels for the ykeys -- will be displayed when you hover over the
                // chart.
                labels: ['Value'],
                //xLabels: true,
                hideHover: true,
                parseTime: false
            });
        }

        function intMorrisPie(vaComplete) {
            objMorrisDonut = new Morris.Donut({
                element: 'morris_pie_chart',
                colors: ['#1bb394', '#cacaca'],
                data: [
                    { value: vaComplete, label: vaComplete + '%', formatted: 'Completed' },
                    { value: 100 - vaComplete, label: (100 - vaComplete) + '%', formatted: '' }
                ],
                formatter: function (x, data) { return data.formatted; }

            });
            //objMorrisDonut.select(1);

        }

    </script>

    <script src="js/echarts.min.js"></script>

    <!-- lib morris.js Line Chart -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>

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
                height: 430px;
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
                    font-size: 12px;
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
                    border-bottom-color: black;
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
                    color: dimgray
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



        #hr {
            background-color: #00A27A;
            color: #C80000;
            -webkit-transform: rotate(35deg);
            position: absolute;
            width: 40px;
            height: 2px;
            left: 160px;
            border: 2px;
            margin: -38px 31px;
        }

        #hr2 {
            background-color: #00A27A;
            color: #C80000;
            -webkit-transform: rotate(0deg);
            position: absolute;
            width: 155px;
            height: 2px;
            left: -14px;
            border: 2px;
            margin-top: 19%;
        }
    </style>


</head>

<script type="text/javascript">


    $(document).ready(function () {

        var dataSeries = vaSeries;
        var dataLegendData = vaLegendData;

        var dataSeriesSla = vaSeriesSla;
        var dataLegendDataSla = vaLegendDataSla;

       
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
                            <div style="margin-top: 4px;" class="widget-subtitle">version dashboard v.1.0.0</div>
                            <div style="margin-top: 4px;" class="widget-subtitle">release june 2018</div>
                            <%--<div style="margin-top: 4px;" class="widget-subtitle">Production Support Team.</div>--%>
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
                            <div class="widget widget-default widget-carousel" onclick="#">
                                <div style="font-weight: 600; margin-top: -3px; margin-left: 0px; position: absolute;">Concurrent job.</div>
                                <div class="row justify-content-center">
                                    <div class="col-4">
                                        <div class="widget-subtitle" style="margin-top: 27px;">Yesterday</div>
                                        <div id="div_yesterday" runat="server" class="widget-int text-muted" style="font-weight: 100; font-size: 25px; margin-top: -10px;">-</div>
                                    </div>
                                    <div class="col-2">
                                        <div class="widget-subtitle" style="margin-top: 27px;">Today</div>
                                        <div id="div_today" runat="server" class="widget-int text-muted" style="font-weight: 100; font-size: 25px; margin-top: -10px;">-</div>
                                    </div>
                                    <div class="col-4">
                                        <div class="widget-subtitle" style="margin-top: 27px;">Average</div>
                                        <div id="div_average" runat="server" class="widget-int text-muted" style="font-weight: 100; font-size: 25px; margin-top: -10px;">-</div>
                                    </div>
                                </div>
                                <div id="morris_line_chart" style="height: 180px;"></div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <!-- card pie chart and num summary on below -->
                            <div class="card rounded-0">
                                <div class="card-body rounded-0 text-center">
                                    <div class="row">
                                        <div class="col-md-12 col-lg-12 col-xl-12">
                                            <div class="widget-title" style="font-weight: 600; margin-top: -5px; margin-left: 180px; position: absolute;">Production Support Team.</div>
                                        </div>
                                    </div>
                                    <%--<br />--%>
                                    <div class="row justify-content-center">
                                        <div class="col-md-7 col-lg-7 col-xl-7">
                                            <div id="morris_pie_chart" style="height: 200px"></div>
                                            <hr id="hr" />
                                        </div>
                                        <div class="col-md-4 col-lg-4 col-xl-4 align-self-center text-left">
                                            <span class="text-success" style="font-weight: 600">Total</span>
                                            <h2 id="h_total_on_pie" runat="server" style="font-weight: 400">-</h2>
                                            <span class="text-muted">Live Statistics</span>
                                            <hr id="hr2" />
                                        </div>
                                    </div>
                                </div>
                                <span style="margin-top: -40px !important; padding: 5px 10px 10px 225px; font-size: 12px;" class="text-muted">Notification Completed Job <b id="b_completed_job" runat="server">-</b></span>
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

            </div>            

            <!-- dash board timeline -->
        </form>
    </div>
</body>
</html>
