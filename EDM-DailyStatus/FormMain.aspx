<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormMain.aspx.cs" Inherits="EDM_DailyStatus.FormMain" %>

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

    <!-- js and css for multi dropdown menu -->
    <script src="js/bootstrap-4-navbar.js"></script>
    <link rel="stylesheet" href="css/bootstrap-4-navbar.css" />


    <title></title>
</head>
<body style="padding-top: 55px;" class="bg-light">
    <div class="container-fluid ">

        <!-- --- menu bar ---->

        <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Service Management</a>
            <%--<button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
                <span class="navbar-toggler-icon"></span>
            </button>--%>
            <div class="navbar-collapse offcanvas-collapse align-items-center" id="navbarsExampleDefault">
                <ul class="navbar-nav mr-auto px-3">
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa fa-home">&nbsp;Main   </i></a>
                    </li>
                    <li class="nav-item dropdown px-3">
                        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"><i class="fa fa-bar-chart"></i>&nbsp; Dashboard Management</a>
                        <ul class="dropdown-menu" aria-labelledby="dropdown01">
                            <li><a class="dropdown-item dropdown-toggle">EDM</a>
                                <ul class="dropdown-menu" style="top: 104px; left: 156px;">
                                    <li><a class="dropdown-item dropdown-toggle" href="#">Report</a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="FormDaily.aspx">Daily</a></li>
                                            <li><a class="dropdown-item" href="#">Historical</a></li>
                                        </ul>
                                    </li>
                                    <li><a class="dropdown-item" href="FormTodayErrorLog.aspx">Logging</a></li>
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
                            <a class="dropdown-item" href="FormTodayErrorLog.aspx">Error Log</a>
                            <a class="dropdown-item" href="FormCalendar.aspx">Calendar</a>
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
        <div class="row">
                

            <!-- menu -->
            <%-- <div class="list-group col-12 col-md-2 col-sm-2 ">
                <a class="list-group-item" href="#"><i class="fa fa-home fa-fw" aria-hidden="true"></i>Main</a>
                <a class="list-group-item" data-toggle="collapse" href="#collapseDashboard"><i class="fa fa-dashboard fa-fw" aria-hidden="true"></i>Dashboard</a>

                <div class="collapse" id="collapseDashboard">
                    <a class="list-group-item bg-light" data-toggle="collapse" href="#collapseEDM">&nbsp; EDM</a>
                    <div class="collapse" id="collapseEDM">
                        <a class="list-group-item bg-light">&nbsp; Report</a>
                        <a class="list-group-item bg-light" href="FormLogging.aspx">&nbsp; Logging</a>
                        <a class="list-group-item bg-light">&nbsp; Fix Problem</a>
                        <a class="list-group-item bg-light">&nbsp; Utility</a>
                    </div>

                    <a class="list-group-item bg-light">&nbsp; EDW</a>
                    <a class="list-group-item bg-light">&nbsp; SAS</a>
                    <a class="list-group-item bg-light">&nbsp; BIG & DV</a>
                </div>

                <a class="list-group-item" data-toggle="collapse" href="#collapseMa"><i class="fa fa-pencil fa-fw" aria-hidden="true"></i>MA</a>
                <div class="collapse" id="collapseMa">
                    <a class="list-group-item bg-light">&nbsp; Backup</a>
                    <a class="list-group-item bg-light">&nbsp; Clear Log</a>
                </div>

                <a class="list-group-item" href="#"><i class="fa fa-cog fa-fw" aria-hidden="true"></i>Settings</a>
            </div>--%>

            <div class="col-12 col-md-12 col-xl-12 bg-light">
                <br />

                <!-- Dashboard -->
                <div class="row">
                    <!-- EDM --->
                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
                        <div class="card card-statistics rounded-0 border-0">
                            <div class="card-body">
                                <div class="clearfix">
                                    <div class="float-left">

                                        <img width="100px" src="pic/logo_teradata.png" />

                                        <%--<i class="fa fa-dashboard fa-2x"></i>--%>
                                    </div>
                                    <div class="align-text-top">
                                        <div class="fluid-container">
                                            <a href="FormDailyAll.aspx">
                                                <h4 class="card-title font-weight-bold text-right mb-0 text-dark">EDM</h4>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="progress mt-4" style="height: 20px;">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 20%" aria-valuenow="8" aria-valuemin="0" aria-valuemax="24">80%</div>
                                </div>
                                <%-- <p class="text-muted mt-3">
                                    <i class="fa fa-check-square" aria-hidden="true"></i>&nbsp;Finished
                                </p>--%>
                            </div>
                        </div>
                    </div>

                    <!-- EDW -->
                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
                        <div class="card card-statistics rounded-0 border-0">
                            <div class="card-body">
                                <div class="clearfix">
                                    <div class="float-left">
                                        <%--<i class="fa fa-dashboard fa-2x"></i>--%>
                                        <img src="pic/logo_oracle.svg" width="100px">
                                    </div>
                                    <div class="align-text-top">
                                        <div class="fluid-container">
                                            <a href="FormEDW.aspx">
                                                <h4 class="card-title font-weight-bold text-right mb-0 text-dark">EDW</h4>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="progress mt-4" style="height: 20px;">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 80%" aria-valuemin="0" aria-valuemax="100">80%</div>
                                </div>
                                <%--<p class="text-muted mt-3">
                                    <i class="fa fa-check-square" aria-hidden="true"></i>&nbsp;Finished
                                </p>--%>
                            </div>
                        </div>
                    </div>

                    <!-- SAS -->
                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
                        <div class="card card-statistics rounded-0 border-0">
                            <div class="card-body">
                                <div class="clearfix">
                                    <div class="float-left">
                                        <img width="65px" src="pic/logo_sas.png" />
                                        <%--<i class="fa fa-dashboard fa-2x"></i>--%>
                                    </div>
                                    <div class="align-text-top">
                                        <div class="fluid-container">
                                            <a href="FormSAS.aspx">
                                                <h4 class="card-title font-weight-bold text-right mb-0 text-dark">SAS</h4>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="progress mt-4" style="height: 20px;">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 80%" aria-valuemin="0" aria-valuemax="100">80%</div>
                                </div>
                                <%--<p class="text-muted mt-3">
                                    <i class="fa fa-check-square" aria-hidden="true"></i>&nbsp;Finished
                                </p>--%>
                            </div>
                        </div>
                    </div>

                    <!-- BIG & DV -->
                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
                        <div class="card card-statistics rounded-0 border-0">
                            <div class="card-body">
                                <div class="clearfix">
                                    <div class="float-left">
                                        <img width="80px" src="pic/logo_bigdata.svg">
                                        <%--<i class="fa fa-dashboard fa-2x"></i>--%>
                                    </div>
                                    <div class="align-text-top">
                                        <div class="fluid-container">
                                            <a href="FormBigdata.aspx">
                                                <h4 class="card-title font-weight-bold text-right mb-0 text-dark">BIG & DV</h4>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="progress mt-4" style="height: 20px;">
                                    <div class="progress-bar bg-secondary" role="progressbar" style="width: 80%" aria-valuemin="0" aria-valuemax="100">80%</div>
                                </div>
                                <%--<p class="text-muted mt-3">
                                    <i class="fa fa-check-square" aria-hidden="true"></i>&nbsp;Finished
                                </p>--%>
                            </div>
                        </div>
                    </div>


                </div>


            </div>
        </div>
    </div>
</body>
</html>
