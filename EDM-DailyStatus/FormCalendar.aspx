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

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

    <!-- Fullcalendar -->

    <script src="js_calendar/fullcalendar.min.js"></script>
    <link href="css_calendar/fullcalendar.min.css" rel='stylesheet' />
    <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' rel='stylesheet' />


    <!-- script create calendar --->
    <script>
        var data = "";
    </script>
    <asp:Literal ID="lt_dataEvent" runat="server"></asp:Literal>

    <%--<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
    <script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/jquery.min.js'></script>
    <script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/fullcalendar.min.js'></script>--%>

    <script src="js_calendar/moment.min.js"></script>
    <script src="js_calendar/jquery.min.js"></script>
    <script src="js_calendar/fullcalendar.min.js"></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js'></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js'></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>        


        $(document).ready(function () {

            $('#btn_new_even').click(function () {
                $('#stg_title_event').html('ADD NEW EVENT');
                $('#txb_chk_mode').val('new');
                $('#txb_ev_inx').val('');

                $('#drop_down_cat_name').val('0');
                $('#txb_indiden_no').val('');
                $('#txb_change_no').val('');
                $('#txb_area').val('');
                $('#txb_ev_detail').val('');
                $('#dte_start').val('');
                $('#dte_end').val('');
                $('#txb_reason').val('');
                $('#modal_add_new_even').modal('show');
                $('#chkb_delete')[0].checked = false;
                $('#group_delete').hide("fast");
                $('#group_chkb_delete').hide("fast");
            });

            $('#chkb_delete').change(function () {
                if ($('#chkb_delete').is(":checked")) {
                    $('#group_delete').show("fast");
                    $('#txb_chk_mode').val('delete');
                    $('#txb_reason').val('');
                } else {
                    $('#group_delete').hide("fast");
                }
            });

            $('#stg_title_event').html('ADD NEW EVENT');
            $('#txb_chk_mode').val('new');
            $('#txb_ev_inx').val('');

            $('#drop_down_cat_name').val('0');
            $('#txb_indiden_no').val('');
            $('#txb_change_no').val('');
            $('#txb_area').val('');
            $('#txb_ev_detail').val('');
            $('#dte_start').val('');
            $('#dte_end').val('');

            $('#group_delete').hide("fast");
            $('#group_chkb_delete').hide("fast");

            var jQuery_3_9_0 = $.noConflict(true);
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
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
                events: data,
                eventClick: function (calEvent, jsEvent, view) {

                    $('#stg_title_event').html('EDIT EVENT');
                    $('#txb_chk_mode').val('update');


                    $.ajax({
                        type: "POST",
                        url: "FormCalendar.aspx/getCalEvent",
                        data: '{"ev_inx":"' + calEvent.Ev_inx + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            console.log('success == ' + response);
                            var dataJson = JSON.parse(response.d);
                            $('#txb_ev_inx').val(calEvent.Ev_inx);
                            $('#drop_down_cat_name').val(dataJson[0].Cat_inx);
                            $('#txb_indiden_no').val(dataJson[0].Inciden_no);
                            $('#txb_change_no').val(dataJson[0].Change_no);
                            $('#txb_area').val(dataJson[0].Area);
                            $('#txb_ev_detail').val(dataJson[0].Ev_details);
                            $('#dte_start').val(dataJson[0].Ev_start_date);
                            $('#dte_end').val(dataJson[0].Ev_end_date);
                        },
                        failure: function (response) {
                            alert('ajax failed');
                            alert(response.d);
                        }
                    });

                    $('#modal_add_new_even').modal('show');
                    $('#group_chkb_delete').show("fast");
                    $('#chkb_delete')[0].checked = false;
                    $('#group_delete').hide("fast");


                    var startDate = new Date($('#dte_start').val());
                    var endDate = new Date($('#dte_end').val());

                    console.log('startDate=' + startDate);
                    console.log('endDate=' + endDate);

                    if (startDate < endDate) {
                        console.log('chek date if');
                    } else {
                        console.log('chek date else');
                    }
                }
            });
            $('#calendar').fullCalendar('option', 'aspectRatio', 1.2);
        });


    </script>


    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script>
        $(document).ready(function () {
            var jQuery_1_3_2 = $.noConflict(true);
            $('#dte_start').datepicker({
                dateFormat: 'yy-mm-dd'
            });
            $('#dte_end').datepicker({
                dateFormat: 'yy-mm-dd'
            });
        });

    </script>


    <style>
        body {
            margin: 5px 0px;
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
    <form id="frmCalendar" runat="server" action="FormCalendar.aspx">
        <div class="container-fluid">
            <!-- Modal Add New event calendar -->
            <div class="modal fade rounded " id="modal_add_new_even" tabindex="-1" role="dialog" aria-labelledby="modal_center_title" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-secondary">
                            <h6 class="modal-title text-white" id="modal_stream_title"><strong id="stg_title_event">ADD NEW EVENT</strong></h6>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="txb_cat_name"><strong>Cat Name</strong></label>

                                <select runat="server" id="drop_down_cat_name" class="form-control form-control-sm">
                                    <option selected value="0">Choose...</option>
                                </select>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-6">
                                    <label for="txb_indiden_no"><strong>Inciden no</strong></label>
                                    <input runat="server" type="text" class="form-control form-control-sm" id="txb_indiden_no" placeholder="inciden no">
                                </div>
                                <div class="form-group col-6">
                                    <label for="txb_change_no"><strong>Change no</strong></label>
                                    <input runat="server" type="text" class="form-control form-control-sm" id="txb_change_no" placeholder="change no">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="txb_area"><strong>Area</strong></label>
                                <input runat="server" type="text" class="form-control form-control-sm" id="txb_area" placeholder="area">
                            </div>
                            <div class="form-group">
                                <label for="txb_ev_detail"><strong>Detail</strong></label>
                                <input runat="server" type="text" class="form-control form-control-sm" id="txb_ev_detail" placeholder="detail">
                            </div>

                            <div class="form-group">
                                <div class="form-row">
                                    <div class="col-6">
                                        <label for="dte_start"><strong>Start date</strong></label>
                                        <input runat="server" class="form-control form-control-sm" id="dte_start" runat="server" placeholder="start date" readonly />
                                    </div>
                                    <div class="col-6">
                                        <label for="dte_start"><strong>End date</strong></label>
                                        <input runat="server" class="form-control form-control-sm" id="dte_end" runat="server" placeholder="end date" readonly />
                                    </div>
                                </div>
                            </div>
                            <div class="form-check" id="group_chkb_delete">
                                <input type="checkbox" class="form-check-input" id="chkb_delete">
                                <label class="form-check-label" for="chkb_delete"><strong>Delete</strong></label>
                            </div>
                            <div id="group_delete" class="form-group">
                                <label for="txb_reason"><strong>Reason of delete</strong></label>
                                <input runat="server" type="text" class="form-control form-control-sm" id="txb_reason" placeholder="Reason of delete">
                            </div>

                        </div>
                        <div class="modal-footer bg-light">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-info" runat="server" id="btn_save_frm_modal">Save</button>
                            <input type="hidden" id="txb_chk_mode" runat="server" value="new" />
                            <input type="hidden" id="txb_ev_inx" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-2">
                    <div class="row">
                        <div class="col">
                            <%--<button type="button" id="btn_new_even" class="btn btn-info btn-" data-toggle="modal">
                                <i class="fa fa-pencil"></i>New Event                      
                            </button>--%>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item small">
                                    <button type="button" id="btn_new_even" class="btn btn-info rounded-0" data-toggle="modal">
                                        <i class="fa fa-pencil-square-o"></i><strong style="padding-left:10px">New Event</strong>
                                    </button>
                                </li>
                                <asp:Literal ID="lt_list_cat_name" runat="server"></asp:Literal>                                
                            </ul>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                        </div>
                    </div>

                </div>
                <div class="col-9">
                    <div id='calendar'></div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
