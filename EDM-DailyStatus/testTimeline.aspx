<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testTimeline.aspx.cs" Inherits="EDM_DailyStatus.testTimeline" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>


    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <link rel="stylesheet" href="./dist/timeline.min.css" />
    <script src="./dist/timeline.min.js"></script>


    <script>

        $(document).ready(function () {
            $("#myTimeline").timeline({
                startDatetime: '2017-05-26',
                range: 1,
                rows:3,
                rowHeight: 40,
                minGridSize: 5,
                minGridPer:8,
              //  height: 1,
                datetimeFormat: { meta: 'g:i A, D F j, Y' }
            });
        });



    </script>
    <style>
        html {font-family: helvetica, arial;}
.htimeline { list-style: none; padding: 0; margin: 10px 0 0; }

.htimeline .step { float: left; border-bottom-style: solid; border-bottom-width: 5px; position: relative; margin-bottom: 10px; text-align: left; padding: 0px 0 5px 0px; background-color: #ddd; color: #333; height: 60px; vertical-align: middle; border-right: solid 1px #bbb; transition: all 0.5s ease;}
.htimeline .step:nth-child(odd) { background-color: #eee; }
.htimeline .step:first-child { border-left: solid 1px #bbb; }
.htimeline .step:hover { background-color: #ccc; border-bottom-width: 6px; }

.htimeline .step div { margin: 0 5px; font-size: 14px; vertical-align: top; padding: 0;}

.htimeline .step.green { border-bottom-color: #348F50;}
.htimeline .step.orange { border-bottom-color: #F09819;}
.htimeline .step.red { border-bottom-color: #C04848;}
.htimeline .step.blue { border-bottom-color: #49a09d;}

.htimeline .step::before { width: 15px; height: 15px; border-radius: 50px; content: ' '; background-color: white; position: absolute; bottom: -10px; left: 0px; border-style: solid; border-width: 3px; transition: all 0.5s ease;}
.htimeline .step:hover::before { width: 18px; height: 18px; bottom: -12px; }
.htimeline .step.green::before {border-color: #348F50;}
.htimeline .step.orange::before {border-color: #F09819;}
.htimeline .step.red::before {border-color: #C04848;}
.htimeline .step.blue::before {border-color: #49a09d;}

.htimeline .step::after { content: attr(data-date); position: absolute; bottom: 0px; left: 17px; font-size: 11px; font-style: italic; color: #888}

    </style>

</head>

<body>

    <!-- Timeline Block -->




    <!-- Timeline Event Detail View Area (optional) -->
    <%--  <div class="timeline-event-view"></div>--%>


    <div class="row p-3">
        <div class="col-8">
            <div class="card">
                <div class="card-body border-danger">



                    <div class='container-fluid'> 
<ul class='htimeline'>
    <li data-date='03/10/2016' class='step col-sm-1 orange'><div>Inserted</div></li>
    <li data-date='08/10/2016' class='step col-sm-2 green'><div>Published</div></li>
    <li data-date='20/10/2016' class='step col-sm-1 red'><div>Deadline</div></li>
    <li data-date='3/11/2016' class='step col-sm-1 blue'><div>Administrative meeting</div></li>
    <li data-date='9/11/2016' class='step col-sm-3 blue'><div>Technical meeting</div></li>
    <li data-date='15/1/2017' class='step col-sm-1 blue'><div>Economical meeting</div></li>
    <li data-date='20/1/2017' class='step col-sm-1 green'><div>Decision meeting</div></li>
    <li data-date='25/1/2017' class='step col-sm-1 green'><div>Award</div></li>
    <li data-date='5/2/2017' class='step col-sm-1 green'><div>Contract sign</div></li>
    <li data-date='9/11/2016' class='step col-sm-3 blue'><div>Technical meeting</div></li>
    <li data-date='15/1/2017' class='step col-sm-1 blue'><div>Economical meeting</div></li>
    <li data-date='20/1/2017' class='step col-sm-1 green'><div>Decision meeting</div></li>
    <li data-date='25/1/2017' class='step col-sm-1 green'><div>Award</div></li>
    <li data-date='5/2/2017' class='step col-sm-1 green'><div>Contract sign</div></li>
  </ul>
</div>

                 <%--   <div id="myTimeline">
                        <ul class="timeline-events">
                            <li style="height:10px;" data-timeline-node="{ start:'2017-05-26 07:00',end:'2017-05-26 13:00',row:1,content:'text text text text ...' }">Event Label</li>
                            <li data-timeline-node="{ start:'2017-05-26 08:10',end:'2017-05-26 13:30',row:2,content:'<p>In this way, you can include <em>HTML tags</em> in the event body.<br>:<br>:</p>' }">Event Label</li>
                        </ul>

                    </div>--%>


                </div>
            </div>
        </div>
        <div class="col-4">
            <div class="card">
                <div class="card-body border-danger">ss</div>
            </div>
        </div>
    </div>

</body>
</html>
