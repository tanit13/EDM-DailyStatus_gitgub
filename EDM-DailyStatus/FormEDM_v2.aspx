<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormEDM_v2.aspx.cs" Inherits="EDM_DailyStatus.FormEDM_v2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EDM</title>

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
    <link rel="stylesheet" href="css/css_edw.css?n=1" />

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
                    /*font-weight: 800;*/
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
                    /*border-bottom-color: #00A27A;*/
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
                    /*border-color: #49a09d;*/
                    border-color: black;
                }

                .htimeline .step::after {
                    content: attr(data-date);
                    position: absolute;
                    bottom: 0px;
                    left: 17px;
                    font-size: 11px;
                    font-style: italic;
                    color: dimgray;
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

    <!-- style sheet custom line for pie chart  -->
    <style>
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

        .hr-header {
            background-color: #00A27A;
            color: #C80000;
            -webkit-transform: rotate(0deg);
            position: absolute;
            width: 100px;
            height: 2px;
            left: -14px;
            border: 2px;
            margin-top: 17px;
        }
    </style>

    <!-- style sheet pie chart progress circle -->
    <style>
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
            border-radius: 50%;
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

    <!-- style ibox -->
    <style>
        .ibox {
            clear: both;
            margin-bottom: 25px;
            margin-top: 0;
            padding: 0;
            box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.2);
        }

        .ibox-content {
            background-color: #ffffff;
            color: inherit;
            padding: 8px 20px 5px 20px;
            border-color: #e7eaec;
            border-image: none;
            border-style: solid solid none;
            border-width: 1px 0;
        }

        .ibox-title {
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            -moz-border-right-colors: none;
            -moz-border-top-colors: none;
            background-color: #ffffff;
            border-color: #e7eaec;
            border-image: none;
            /*border-style: solid solid none;*/
            border-width: 2px 0 0;
            color: inherit;
            margin-bottom: 0;
            padding: 15px 15px 7px;
            min-height: 48px;
        }

            .ibox-title h5 {
                display: inline-block;
                font-size: 14px;
                margin: 0 0 7px;
                padding: 0;
                text-overflow: ellipsis;
                float: left;
            }
    </style>

    <script>
        function setCurrentTimeline() {
            var now = new Date();
            var hour = now.getHours();
            var minutes = now.getMinutes();

            if (hour <= 3 && minutes <= 59) {
                $(".li_timeline1").removeClass("blue");
                $(".li_timeline1").addClass("orange");
                $("#li_timeline_sla1").removeClass("blue");
                $("#li_timeline_sla1").addClass("orange");

            } else if (hour <= 7 && minutes <= 59) {
                $(".li_timeline2").removeClass("blue");
                $(".li_timeline2").addClass("orange");
                $("#li_timeline_sla2").removeClass("blue");
                $("#li_timeline_sla2").addClass("orange");

            } else if (hour <= 11 && minutes <= 59) {
                $(".li_timeline3").removeClass("blue");
                $(".li_timeline3").addClass("orange");
                $("#li_timeline_sla3").removeClass("blue");
                $("#li_timeline_sla3").addClass("orange");

            } else if (hour <= 15 && minutes <= 59) {
                $(".li_timeline4").removeClass("blue");
                $(".li_timeline4").addClass("orange");
                $("#li_timeline_sla4").removeClass("blue");
                $("#li_timeline_sla4").addClass("orange");

            } else if (hour <= 19 && minutes <= 59) {
                $(".li_timeline5").removeClass("blue");
                $(".li_timeline5").addClass("orange");
                $("#li_timeline_sla5").removeClass("blue");
                $("#li_timeline_sla5").addClass("orange");

            } else {
                $(".li_timeline6").removeClass("blue");
                $(".li_timeline6").addClass("orange");
                $("#li_timeline_sla6").removeClass("blue");
                $("#li_timeline_sla6").addClass("orange");
            }

        }

        $(document).ready(function () {
            setCurrentTimeline();

        });



        $(document).ready(function () {

            slideTimeline(10000);

            $.ajax({
                type: "POST",
                url: "FormEDM.aspx/getDataSummaryProject",
                // data: '{"project":"' + project + '","tier":"' + tier + '","status":"' + status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    vaDataJson = JSON.parse(response.d);

                    slideSummaryProject();
                },
                failure: function (response) {
                    alert('ajax summary project');
                    alert(response.d);
                }
            });


        });


        //-- function for loo ----
        var vaIndex = 0;
        var textJson = 5;
        var vaDataJson;
        function slideSummaryProject() {
            if (vaIndex < vaDataJson.length) {


                document.getElementById("h_project").innerText = vaDataJson[vaIndex].Project_name;
                document.getElementById("h_sum_project").innerText = vaDataJson[vaIndex].Total;
                document.getElementById("span_completed_p").innerText = vaDataJson[vaIndex].Completed_p + "%";

                document.getElementById("span_project_meet_p").innerText = vaDataJson[vaIndex].Meet_p + "%";
                document.getElementById("span_project_miss_p").innerText = vaDataJson[vaIndex].Miss_p + "%";



                if (vaDataJson[vaIndex].Meet_p == 100) {
                    document.getElementById("div_project_meet_p").style.display = "";
                    document.getElementById("div_project_miss_p").style.display = "none";
                } else {
                    document.getElementById("div_project_meet_p").style.display = "none";
                    document.getElementById("div_project_miss_p").style.display = "";
                }


                if (vaDataJson[vaIndex].Completed_p < 100) {
                    document.getElementById("i_project_down").style.display = "";
                    document.getElementById("h_project_down").style.display = "";
                    document.getElementById("i_project_up").style.display = "none";
                    document.getElementById("h_project_up").style.display = "none";
                } else {
                    document.getElementById("i_project_down").style.display = "none";
                    document.getElementById("h_project_down").style.display = "none";
                    document.getElementById("i_project_up").style.display = "";
                    document.getElementById("h_project_up").style.display = "";
                }

                setTimeout(slideSummaryProject, 3000);
                vaIndex++;
            } else {
                vaIndex = 0;
                slideSummaryProject()
            }
        }


        function slideTimeline(vaTime) {  //div_timeline_tier1

            setTimeout(fadeTimelineT1, vaTime);
            setTimeout(fadeTimelineT2, vaTime * 2);
            setTimeout(fadeTimelineT3, vaTime * 3);

        }

        function fadeTimelineT1() {
            //$('#div_timeline_tier1').fadeOut();
            //$('#div_timeline_tier2').fadeIn();

            document.getElementById("div_timeline_tier1").style.display = "none";
            document.getElementById("div_timeline_tier2").style.display = "";

        }
        function fadeTimelineT2() {
            //$('#div_timeline_tier2').fadeOut();
            //$('#div_timeline_tier3').fadeIn();

            document.getElementById("div_timeline_tier2").style.display = "none";
            document.getElementById("div_timeline_tier3").style.display = "";

        }
        function fadeTimelineT3(vaT) {
            //$('#div_timeline_tier3').fadeOut();
            //$('#div_timeline_tier1').fadeIn();

            document.getElementById("div_timeline_tier3").style.display = "none";
            document.getElementById("div_timeline_tier1").style.display = "";

            slideTimeline(10000);
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

        <form id="frmEDM" runat="server">

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

                    <div class="ibox">
                        <div class="ibox-content">


                            <div class="row">
                                <div class="col-12">
                                    <h3 style="margin-top: 10px !important; font-weight: 200;" class="text-muted">Welcome To Teradata</h3>
                                    <%--<img src="pic/logo_teradata.png" style="width: 120px; height: 40px; margin-left: 10px;" />--%>
                                    <h4 style="margin-top: 20px !important; font-weight: 400; font-size: 11px;" class="text-muted">You have 10 messages and 6</h4>
                                    <h4 style="margin-top: 10px !important; font-weight: 400; font-size: 11px;" class="text-muted">notification.</h4>
                                </div>
                                <%-- <div class="col-6 text-center">
                                    <span class="badge badge-info" style="color: white; background-color: #ed5565 !important">Incident</span><br />
                                    <h3 style="margin-top: 10px !important; font-weight: 600;" class="text-muted">10</h3>
                                    <span style="font-weight: 400; font-size: 12px;" class="text-muted">you have a incident</span>

                                </div>--%>
                            </div>



                        </div>
                        <%-- <div class="ibox-title">--%>
                        <%-- <div class="row">
                                <div class="col-12">
                                    <h4 style="margin-top: 0px !important; font-weight: 400; font-size: 11px;" class="text-muted">you have a incident 10 </h4>

                                </div>
                            </div>
                            <div class="row" style="padding-bottom: 8px">
                                <div class="col-12">
                                    <h4 style="margin-top: 0px !important; font-weight: 400; font-size: 11px;" class="text-muted">notification 10 message</h4>
                                </div>
                            </div>--%>
                        <%--</div>--%>
                    </div>

                    <!-- data H M L  display none   -->
                    <div class="widget widget-default widget-carousel" style="display: none">
                        <div id="hml" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div>
                                        <div class="row">
                                            <div class="col-7">

                                                <div class="row">
                                                    <div class="col-12" style="align-items: ">
                                                        <div class="widget-title">Monitor</div>
                                                    </div>
                                                </div>
                                                <div class="row border-top border-success">
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

                                            </div>
                                            <div class="col-5 border-left">
                                                <div class="row">
                                                    <div class="col-4">
                                                        <div class="widget-subtitle">Medium</div>
                                                    </div>

                                                </div>
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


                <div class="col-md-3 col-lg-3 col-xl-3">


                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row justify-content-around">
                                <div class="col-6">
                                    <div style="padding-left: 20px">
                                        <h3 id="h_project" style="margin-top: 0 !important; font-weight: 600;" class="text-muted">Project</h3>
                                        <table>
                                            <tr>
                                                <td>
                                                    <i id="i_project_up" class="fa fa-caret-up fa-3x" style="margin-top: -10px !important; color: #1ab394 !important; display: none"></i>
                                                    <i id="i_project_down" class="fa fa-caret-down fa-3x" style="margin-top: -10px !important; color: #ed5565 !important; display: none"></i>
                                                </td>
                                                <td>
                                                    <h5 id="h_project_up" style="margin-top: 0 !important; font-weight: 400; color: #1ab394 !important; display: none">Up</h5>
                                                    <h5 id="h_project_down" style="margin-top: 0 !important; font-weight: 400; color: #ed5565 !important; display: none">Down</h5>
                                                </td>
                                            </tr>
                                        </table>
                                        <div class="row">
                                            <div class="col-12">
                                                <div id="div_project_meet_p" style="display: none">
                                                    <span id="span_project_meet_p" style="font-size: 12px; font-weight: 400; color: #1ab395 !important">98% </span>
                                                    <span style="font-size: 12px; font-weight: 400; color: #1ab395 !important"><i class="fa fa-level-up"></i>Meet</span>
                                                </div>
                                                <div id="div_project_miss_p" style="margin-top: 0px !important; display: none">
                                                    <span id="span_project_miss_p" style="font-size: 12px; font-weight: 400; color: #ed5565">20% </span>
                                                    <span style="font-size: 12px; font-weight: 400; color: #ed5565;"><i class="fa fa-level-down"></i>Miss</span>
                                                </div>
                                            </div>

                                        </div>
                                        <%--<span style="margin-top: -10px !important; font-size: 12px;" class="text-muted">Last Update</span>--%>
                                    </div>
                                </div>
                                <div class="col-6 text-center">

                                    <span class="badge badge-info" style="color: white; background-color: #1ab394; margin-top: 10px !important;">Today</span><br />
                                    <h3 id="h_sum_project" style="margin-top: 10px !important; font-weight: 600;" class="text-muted">-</h3>
                                    <span id="span_completed_p" style="font-weight: 400; font-size: 12px;" class="text-muted">-</span>
                                    <span style="font-weight: 400; font-size: 12px;" class="text-muted">Completed</span>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- display none -->

                </div>
                <!--End summary Meet Miss -->

                <!-- display person production support team or logo -->
                <div class="col-3">

                    <div class="ibox">
                        <div class="ibox-title">
                            <span class="badge badge-info pull-right" style="color: white; background-color: #1ab394">Today</span>
                            <h5 class="text-muted">Service Level Agreement.</h5>
                        </div>
                        <div class="ibox-content">
                            <div class="row justify-content-center">
                                <div class="col-5 text-center">
                                    <h3 id="h_meet" runat="server" style="margin: 0 !important; font-weight: 800;" class="text-muted">1,400</h3>
                                    <span id="span_meet_p" runat="server" style="font-size: 14px; font-weight: 400; color: #1ab395 !important">98% </span>
                                    <span style="font-size: 14px; font-weight: 400; color: #1ab395 !important"><i class="fa fa-level-up"></i>Meet</span>
                                </div>
                                <div class="col-5 text-center">
                                    <h3 id="h_miss" runat="server" style="margin: 0 !important; font-weight: 600;" class="text-muted">60</h3>
                                    <span id="span_miss_p" runat="server" style="font-size: 14px; font-weight: 400; color: #ed5565">2% </span>
                                    <span style="font-size: 14px; font-weight: 400; color: #ed5565"><i class="fa fa-level-down"></i>Miss</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- display none -->
                    <div class="widget widget-default widget-item-icon" onclick="#" style="display: none">
                        <div class="widget-item-left">
                            <span class="fa fa-user"></span>
                        </div>
                        <div class="widget-data">
                            <div runat="server" class="widget-int num-count">
                                <img width="110" height="40" class="media-object" src="pic/logo_teradata.png" alt="Generic placeholder image">
                            </div>
                            <div style="margin-top: 4px;" class="widget-subtitle">Enterprise Data Warehouse Management.</div>
                        </div>
                        <div class="widget-controls">
                        </div>
                    </div>
                </div>
                <!-- End display person production support team -->

                <!-- display current date time -->
                <div class="col-3">

                    <div class="ibox">

                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-12">
                                    <span style="font-size: 14px; font-weight: 500;" class="text-muted">Problem Management.</span>
                                </div>
                            </div>
                            <div class="row">

                                <div class="col-6">

                                    <h6 style="font-size: 12px; margin-top: 10px;" class="text-muted">
                                        <i class="fa fa-clock-o" style="padding-left: 10px"></i>
                                        <label style="padding-left: 5px;">Pending</label>
                                        <b class="pull-right">92</b>
                                    </h6>
                                    <h6 style="font-size: 12px; margin-top: -10px;" class="text-muted">
                                        <i class="fa fa-check-square-o" style="padding-left: 10px"></i>
                                        <label style="padding-left: 5px;">Fixed</label>
                                        <b class="pull-right">92</b>
                                    </h6>
                                    <h6 style="font-size: 12px; margin-top: -10px;" class="text-muted">
                                        <label style="padding-left: 10px"><i class="fa fa-gear fa-spin"></i></label>
                                        <label style="padding-left: 5px;">Investigate</label>
                                        <b class="pull-right">92</b>
                                    </h6>
                                    <%--  <span style="font-size: 12px;" class="text-muted">
                                        <i class="fa fa-check-square-o"  style="margin-top:-20px !important;"></i>
                                        <label>Fixed</label>
                                        <b>92</b>
                                    </span><br />
                                    <span style="font-size: 12px;" class="text-muted">
                                        <i class="fa fa-check-square-o"></i>
                                        <label>Investigate</label>
                                        <b>92</b>
                                    </span>--%>


                                    <%-- <div style="padding-left:20px;">
                                        <div class="col-12"><span style=" font-size: 12px;" class="text-muted">Pending <b>1,292</b></span></div>
                                        <div class="col-12"><span style=" font-size: 12px;" class="text-muted">Fixed <b>1,292</b></span></div>
                                        <div class="col-12"><span style=" font-size: 12px;" class="text-muted">Investigate <b>1,292</b></span></div>
                                            </div>--%>



                                    <%--<span style=" font-size: 12px;" class="text-muted">Fixed<b>1,292</b></span>
                                    <span style=" font-size: 12px;" class="text-muted">Investigate<b>1,292</b></span>--%>
                                </div>
                                <div class="col-6 text-center">
                                    <div style="margin-top: -18px">
                                        <span class="badge badge-info" style="color: white; background-color: #ed5565 !important">Monthly</span><br />
                                        <h3 style="margin-top: 10px !important; font-weight: 600;" class="text-muted">10</h3>
                                        <span style="font-weight: 400; font-size: 12px;" class="text-muted">You have a incident</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--  <div class="ibox-title">
                            <span class="badge badge-warning pull-right" style="color: white; background-color: #f8ac59;">Data has changed</span>
                            <h5 class="text-muted">Problem Management.</h5>
                        </div>
                        <div class="ibox-content">
                            <div class="row justify-content-center">
                                <div class="col-4 text-center">
                                    <span class="text-muted" style="font-size: 14px; font-weight: 600">Pending</span>
                                    <h3 style="margin: 0 !important; font-weight: 800;" class="text-muted">15</h3>
                                </div>
                                <div class="col-4 text-center">
                                    <span class="text-muted" style="font-size: 14px; font-weight: 600">Fixed</span>
                                    <h3 style="margin: 0 !important; font-weight: 800;" class="text-muted">8</h3>
                                </div>
                                <div class="col-4 text-center">
                                    <span class="text-muted" style="font-size: 14px; font-weight: 600">Investigate</span>
                                    <h3 style="margin: 0 !important; font-weight: 800;" class="text-muted">6</h3>
                                </div>
                            </div>
                        </div>--%>
                    </div>

                    <!-- display none -->
                    <div class="widget widget-info widget-padding-sm" style="display: none">
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

            <!-- timeline and pie chart -->
            <div class="row">
                <!-- timeline -->
                <div class="col-8">
                    <div class="card card-body rounded-0">
                        <!-- Main Slide Timeline -->
                        <div id="slide_timeline" class="carousel slide" data-ride="carousel" data-interval="20000">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <!-- Container Timeline all -->
                                    <!-- timeline tier1 -->
                                    <div class='container-fluid' id="div_timeline_tier1">
                                        <div class="row">
                                            <div class="col-6">
                                                <h5>Timeline
                                                    <div>
                                                        <button type='button' class='button_status_timeline btn btn-success'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Completed</strong>
                                                        <button type='button' class='button_status_timeline btn btn-warning'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Running</strong>
                                                        <button type='button' class='button_status_timeline btn btn-danger'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Failed</strong>
                                                        <button type='button' style="background-color: #212529;" class='button_status_timeline btn'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Monitor</strong>
                                                    </div>
                                                </h5>
                                            </div>
                                            <div class="col-6">
                                                <span class="badge badge-light pull-right" style="color: dimgrey; font-size: 25px;">TIER1</span>
                                            </div>
                                        </div>
                                        <ul class="htimeline">
                                            <li id="li_timeline6" data-date='20:00 - 23:59' class='step col-sm-2 blue li_timeline6'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_6" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li id="li_timeline1" data-date='00:00 - 03:59' class='step col-sm-2 blue li_timeline1'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_1" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li id="li_timeline2" data-date='04:00 - 07:59' class='step col-sm-2 blue li_timeline2'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li id="li_timeline3" data-date='08:00 - 11:59' class='step col-sm-2 blue li_timeline3'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li id="li_timeline4" data-date='12:00 - 15:59' class='step col-sm-2 blue li_timeline4'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_4" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li id="li_timeline5" data-date='16:00 - 19:59' class='step col-sm-2 blue li_timeline5'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_5" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                        </ul>
                                    </div>

                                    <!-- timeline tier2 -->
                                    <div class='container-fluid' id="div_timeline_tier2" style="display: none">
                                        <div class="row">
                                            <div class="col-6">
                                                <h5>Timeline        
                                                    <div>
                                                        <button type='button' class='button_status_timeline btn btn-success'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Completed</strong>
                                                        <button type='button' class='button_status_timeline btn btn-warning'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Running</strong>
                                                        <button type='button' class='button_status_timeline btn btn-danger'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Failed</strong>
                                                        <button type='button' style="background-color: #212529;" class='button_status_timeline btn'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Monitor</strong>
                                                    </div>
                                                </h5>
                                            </div>
                                            <div class="col-6">
                                                <span class="badge badge-light pull-right" style="color: dimgrey; font-size: 25px;">TIER2</span>
                                            </div>
                                        </div>
                                        <ul class="htimeline">
                                            <li data-date='20:00 - 23:59' class='step col-sm-2 blue li_timeline6'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_6_tier2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='00:00 - 03:59' class='step col-sm-2 blue li_timeline1'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_1_tier2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='04:00 - 07:59' class='step col-sm-2 blue li_timeline2'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_2_tier2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='08:00 - 11:59' class='step col-sm-2 blue li_timeline3'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_3_tier2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='12:00 - 15:59' class='step col-sm-2 blue li_timeline4'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_4_tier2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='16:00 - 19:59' class='step col-sm-2 blue li_timeline5'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_5_tier2" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                        </ul>
                                    </div>

                                    <!-- timeline tier3 -->
                                    <div class='container-fluid' id="div_timeline_tier3" style="display: none">
                                        <div class="row">
                                            <div class="col-6">
                                                <h5>Timeline        
                                                    <div>
                                                        <button type='button' class='button_status_timeline btn btn-success'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Completed</strong>
                                                        <button type='button' class='button_status_timeline btn btn-warning'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Running</strong>
                                                        <button type='button' class='button_status_timeline btn btn-danger'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Failed</strong>
                                                        <button type='button' style="background-color: #212529;" class='button_status_timeline btn'></button>
                                                        <strong style="font-size: 12px; padding-right: 2px;">Monitor</strong>
                                                    </div>
                                                </h5>
                                            </div>
                                            <div class="col-6">
                                                <span class="badge badge-light pull-right" style="color: dimgrey; font-size: 25px;">TIER3</span>
                                            </div>
                                        </div>
                                        <ul class="htimeline">
                                            <li data-date='20:00 - 23:59' class='step col-sm-2 blue li_timeline6'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_6_tier3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='00:00 - 03:59' class='step col-sm-2 blue li_timeline1'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_1_tier3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='04:00 - 07:59' class='step col-sm-2 blue li_timeline2'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_2_tier3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='08:00 - 11:59' class='step col-sm-2 blue li_timeline3'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_3_tier3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='12:00 - 15:59' class='step col-sm-2 blue li_timeline4'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_4_tier3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                            <li data-date='16:00 - 19:59' class='step col-sm-2 blue li_timeline5'>
                                                <table style="width: 100%; font-size: 12px;">
                                                    <asp:Literal ID="lt_timeline_5_tier3" runat="server"></asp:Literal>
                                                </table>
                                            </li>
                                        </ul>
                                    </div>


                                    <!-- End Container Timeline all -->
                                </div>
                                <%-- <div class="carousel-item" style="display:none">
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
                                            <li id="li_timeline_sla6" data-date='20:00 - 23:59' class='step col-sm-2 blue'>
                                                <asp:Literal ID="lt_timeline_sla_6" runat="server"></asp:Literal>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- End Container Timeline Sla-->
                                </div>--%>
                            </div>
                            <ul class="carousel-indicators" style="display: none">
                                <li data-target="#slide_timeline" data-slide-to="0" class="active"></li>
                                <%--<li data-target="#slide_timeline" data-slide-to="1" ></li>--%>
                            </ul>
                        </div>
                        <!-- End Main Slide Timeline -->
                    </div>
                </div>

                <!-- pie chart -->
                <div class="col-md-4 col-lg-4 col-xl-4">

                    <!-- test morris.js Line Chart -->
                    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css" />
                    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>--%>
                    <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
                    <script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
                    <script>
                        var dataLineChart;
                        var pieComplete;

                        $(document).ready(function () {

                            $.ajax({
                                type: "POST",
                                url: "FormEDM_v2.aspx/getDataMorrisLineChart",
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


                            $.ajax({
                                type: "POST",
                                url: "FormEDM_v2.aspx/getDataMorrisPie",                                
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    var dataPieChart = JSON.parse(response.d);                                   

                                    pieComplete = dataPieChart[0].Completed_percent;

                                    intMorrisPie(pieComplete);
                                    document.getElementById("h_total_on_pie").innerText = dataPieChart[0].Total_str;


                                },
                                failure: function (response) {
                                    alert('ajax failed');
                                    alert(response.d);
                                }
                            });



                        });

                        function intMorrisChart() {
                            new Morris.Area({
                                // ID of the element in which to draw the chart.
                                element: 'morris_line_chart',
                                // Chart data records -- each entry in this array corresponds to a point on
                                // the chart.
                                lineColors: ['#55cdb4'],
                                pointSize: '0px',
                                data: dataLineChart,
                                //[
                                //{ Name: '6/9/2018 00:00', Value: 635 },
                                //{ Name: '', Value: 300 },
                                //{ Name: '7/9/2018 00:00', Value: 500 },
                                //{ Name: null, Value: 200 },
                                //{ Name: '9/9/2018 00:00', Value: 800 }
                                //    ],                                  


                                //xLabelAngle: 90,

                                //   gridTextSize:10,

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
                                //,
                                //xLabelFormat: function (name) {


                                //    return name.toString();
                                //}
                            });
                        }

                        function intMorrisPie(vaComplete) {
                            new Morris.Donut({
                                element: 'morris_pie_chart',
                                colors: ['#1bb394', '#cacaca'],
                                data: [
                                    { value: vaComplete, label: vaComplete + '%', formatted: 'Completed' },
                                    { value: 100 - vaComplete, label: (100 - vaComplete) + '%', formatted: '' }
                                ],
                                formatter: function (x, data) { return data.formatted; }
                            });
                        }


                    </script>

                    <div class="widget widget-default widget-carousel" onclick="#">
                        <div class="row justify-content-center">
                            <div class="col-4">
                                <div class="widget-subtitle" style="margin-top: 10px;">Yesterday</div>
                                <div id="div_yesterday" runat="server" class="widget-int text-muted" style="font-weight: 100; font-size: 25px; margin-top: -5px;">-</div>
                            </div>
                            <div class="col-2">
                                <div class="widget-subtitle" style="margin-top: 10px;">Today</div>
                                <div id="div_today" runat="server" class="widget-int text-muted" style="font-weight: 100; font-size: 25px; margin-top: -5px;">-</div>
                            </div>
                            <div class="col-4">
                                <div class="widget-subtitle" style="margin-top: 10px;">Average</div>
                                <div id="div_average" runat="server" class="widget-int text-muted" style="font-weight: 100; font-size: 25px; margin-top: -5px;">-</div>
                            </div>
                        </div>


                        <div id="morris_line_chart" style="height: 180px;"></div>


                    </div>

                    <!-- card pie chart and num summary on below -->
                    <div class="card rounded-0">
                        <div class="card-body rounded-0 text-center">
                            <%--  <div class="card-header mb-2 border-0 bg-white">
                            </div>--%>


                            <div class="row">
                                <div class="col-md-12 col-lg-12 col-xl-12">

                                    <div class="widget-title" style="font-weight: 600; margin-top: 5px; margin-left: 180px; position: absolute;">Production Support Team.</div>

                                </div>
                            </div>
                            <br />

                            <div class="row justify-content-center">
                                <div class="col-md-7 col-lg-7 col-xl-7">


                                    <div id="morris_pie_chart" style="height: 200px"></div>

                                    <div runat="server" id="div_pie_circle" class="" style="display: none">

                                        <span runat="server" id="span_pie_circle" style="font-size: 55px !important; margin-left: -65px; margin-top: -72px; color: #00A27A !important;">90
                                                    <%--<h6 style="margin-top: -120px">Completed</h6>--%>
                                        </span>
                                        <span style="position: absolute; margin-top: 30px; margin-left: 65px; font-size: 20px; font-weight: 400; color: #00A27A;">%</span>
                                        <span style="font-size: 16px !important; margin-left: 35px; margin-top: 70px; color: #00A27A !important;">Completed</span>
                                        <div class="left-half-clipper">
                                            <div style="background-color: #00A27A !important;" class="first50-bar"></div>
                                            <div style="border-color: #00A27A !important;" class="value-bar"></div>
                                        </div>
                                    </div>
                                    <hr id="hr" />
                                </div>
                                <div class="col-md-4 col-lg-4 col-xl-4 align-self-center text-left">

                                    <span class="text-success" style="font-weight: 600">Total</span>
                                    <h2 id="h_total_on_pie" runat="server" style="font-weight: 400">-</h2>
                                    <span class="text-muted">Live Statistics</span>
                                    <hr id="hr2" />
                                </div>
                            </div>

                            <!-- display none -->
                            <div class="row" style="display: none">
                                <div class="col-md-4 col-lg-4 col-xl-4 border-right" style="text-align: right">
                                    <h3 id="h_running_on_pie" runat="server" style="font-weight: 400;">25%</h3>
                                    <span class="" style="font-weight: 600; color: #F09819;">Running</span>
                                    <hr style="margin-top: 5px; margin-left: 35px;" class="hr-header" />
                                    <h3 id="span_running" runat="server" style="font-weight: 400; margin-top: 10px;">308</h3>
                                </div>
                                <div class="col-md-4 col-lg-4 col-xl-4 border-right" style="text-align: right">
                                    <h3 id="h_failed_on_pie" runat="server" style="font-weight: 400">65%</h3>
                                    <span class="text-danger" style="font-weight: 600">Failed</span>
                                    <hr style="margin-top: 5px; margin-left: 35px;" class="hr-header" />
                                    <h3 id="span_failed" runat="server" style="font-weight: 400; margin-top: 10px;">508</h3>
                                </div>
                                <div class="col-md-4 col-lg-4 col-xl-4" style="text-align: right">
                                    <h3 id="h_notstart_on_pie" runat="server" style="font-weight: 400">10%</h3>
                                    <span class="text-muted" style="font-weight: 600">Monitor</span>
                                    <hr style="margin-top: 5px; margin-left: 35px;" class="hr-header" />
                                    <h3 id="span_monitor" runat="server" style="font-weight: 400; margin-top: 10px;">18</h3>
                                </div>
                            </div>

                        </div>

                        <span style="margin-top: -40px !important; padding: 5px 10px 10px 225px; font-size: 12px;" class="text-muted">Notification Completed Job <b id="b_completed_job" runat="server">-</b></span>
                    </div>
                </div>
            </div>

        </form>
    </div>
</body>
</html>
