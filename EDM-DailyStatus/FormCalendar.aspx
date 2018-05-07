<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormCalendar.aspx.cs" Inherits="EDM_DailyStatus.FormCalendar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset='utf-8' />

    <%-- <link href='css_calendar/fullcalendar.min.css' rel='stylesheet' />
    <link href='css_calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <script src='js_calendar/moment.min.js'></script>
    <script src='js_calendar/jquery.min.js'></script>
    <script src='js_calendar/fullcalendar.min.js'></script>--%>

    <!-- Latest compiled and minified CSS -->


    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>




    <script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
    <script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/jquery.min.js'></script>
    <script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/fullcalendar.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js'></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js'></script>

    <link href='https://fullcalendar.io/releases/fullcalendar/3.9.0/fullcalendar.min.css' rel='stylesheet' />
    <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' rel='stylesheet' />



    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.6/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.6/css/gijgo.min.css" rel="stylesheet" />


    <!-- script create calendar --->
    <script>
        var data = "";
    </script>
    <asp:Literal ID="lt_dataEvent" runat="server"></asp:Literal>
    <script> 



        $(document).ready(function () {

            //   $('#dte_start').datepicker({
            //    uiLibrary: 'bootstrap4'
            //    , format: 'yyyy-mm-dd'
            //});
            //$('#dte_end').datepicker({
            //    uiLibrary: 'bootstrap4'
            //    , format: 'yyyy-mm-dd'
            //});



            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                defaultDate: '2018-05-05',
                editable: true,
                eventLimit: true, // allow "more" link when too many events
                eventRender: function (eventObj, $el) {
                    $el.popover({
                        title: eventObj.title,
                        content: eventObj.description,
                        trigger: 'hover',
                        placement: 'top',
                        container: 'body'
                    });
                },
                events: data
            });

            $('#calendar').fullCalendar('option', 'aspectRatio', 1.8);

        });

    </script>


    <style>
        body {
            margin: 40px 10px;
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
        }

        #calendar {
            max-width: 900px;
            margin: 0 auto;
        }
    </style>



</head>
<body>
    <div class="container-fluid">
        <!-- Modal info stream use in project -->
        <div class="modal fade" id="modal_add_new_even" tabindex="-1" role="dialog" aria-labelledby="modal_center_title" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal_stream_title">Add new even</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="txb_cat_name">Cat Name</label>
                                <input type="text" class="form-control form-control-sm" id="txb_cat_name" placeholder="Cat Name">
                            </div>
                            <div class="form-group">
                                <div class="form-row">
                                    <div class="col-6">
                                        <label for="txb_indiden_no">Inciden no</label>
                                        <input type="text" class="form-control form-control-sm" id="txb_indiden_no" placeholder="Inciden no">
                                    </div>
                                    <div class="col-6">
                                        <label for="txb_change_no">Change no</label>
                                        <input type="text" class="form-control form-control-sm" id="txb_change_no" placeholder="Another input">
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                                <label for="txb_area">Area</label>
                                <input type="text" class="form-control form-control-sm" id="txb_area" placeholder="Another input">
                            </div>
                            <div class="form-group">
                                <label for="txb_ev_detail">Ev detail</label>
                                <input type="text" class="form-control form-control-sm" id="txb_ev_detail" placeholder="Another input">
                            </div>

                             <div class="form-group">
                                <div class="form-row">
                                    <div class="col-6">
                                        <label for="dte_start"><strong>start date</strong></label>
                                    <input class="form-control " id="dte_start" runat="server" readonly />
                                    </div>
                                    <div class="col-6">
                                        <label for="dte_start"><strong>end date</strong></label>
                                    <input class="form-control" id="dte_end" runat="server" readonly />
                                    </div>
                                </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-2">
                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modal_add_new_even">
                    New Even
                </button>
            </div>
            <div class="col-10">
                <div id='calendar'></div>
            </div>
        </div>





    </div>
</body>
</html>
