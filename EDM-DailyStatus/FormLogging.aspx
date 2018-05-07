<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormLogging.aspx.cs" Inherits="EDM_DailyStatus.FormLogging" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

    <style>
        .bd-content {
            padding: 1.5rem;
            margin-right: 0;
            margin-left: 0;
            border-width: .2rem;
        }
    </style>


    <title></title>
</head>
<body style="padding-top: 55px;" class="bg-light">
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


        <!-- main -->
        <form class="form-"></form>

        <div class="row">
            <div class="list-group col-12 col-md-2 col-sm-2 ">
                <a class="list-group-item" href="FormMain.aspx"><i class="fa fa-home fa-fw" aria-hidden="true"></i>Main</a>
                <a class="list-group-item" data-toggle="collapse" href="#collapseDashboard"><i class="fa fa-dashboard fa-fw" aria-hidden="true"></i>Dashboard</a>

                <div class="collapse" id="collapseDashboard">
                    <a class="list-group-item bg-light" data-toggle="collapse" href="#collapseEDM">&nbsp; EDM</a>
                    <div class="collapse" id="collapseEDM">
                        <a class="list-group-item bg-light">&nbsp; Report</a>
                        <a class="list-group-item bg-light" >&nbsp; Logging</a>
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
            </div>


            <!-- form ---- --->
            <div class="col-md-10 bg-white bd-content">
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputEmail4">Email</label>
                            <input type="email" class="form-control" id="inputEmail4" placeholder="Email" />
                        </div>
                        <div class="form-group col-md-6">
                            <label for="inputPassword4">Password</label>
                            <input type="password" class="form-control" id="inputPassword4" placeholder="Password" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddress">Address</label>
                        <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" />
                    </div>
                    <div class="form-group">
                        <label for="inputAddress2">Address 2</label>
                        <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor" />
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputCity">City</label>
                            <input type="text" class="form-control" id="inputCity" />
                        </div>
                        <div class="form-group col-md-4">
                            <label for="inputState">State</label>
                            <select id="inputState" class="form-control">
                                <option selected="selected">Choose...</option>
                                <option>...</option>
                            </select>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="inputZip">Zip</label>
                            <input type="text" class="form-control" id="inputZip" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="gridCheck" />
                            <label class="form-check-label" for="gridCheck">
                                Check me out
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Sign in</button>
                </form>
            </div>


        </div>
    </div>
</body>
</html>
