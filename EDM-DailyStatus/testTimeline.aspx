<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testTimeline.aspx.cs" Inherits="EDM_DailyStatus.testTimeline" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>



    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <link rel="stylesheet" href="./dist/timeline.min.css" />
    <script src="./dist/timeline.min.js"></script>


    <script>

        $(document).ready(function () {
            $("#myTimeline").timeline({
                startDatetime: '2017-05-23',
                range: 3,
                rows: 5,                
                rowHeight:30,
                minGridSize: 20,
                height:10,
                datetimeFormat: { meta: 'g:i A, D F j, Y' }                
            });
        });



    </script>
</head>

<body style="resize:2000px;">

    <!-- Timeline Block -->
    <div id="myTimeline">
        <div class="timeline-events">
            <div data-timeline-node="{ start:'2017-05-23 00:00',end:'2017-05-23 13:00',row:1,content:'Fill in the text of the event.' }">This is a valid event</div>
            <div data-timeline-node="{ start:'2017-05-23 12:00',end:'2017-05-23 12:50',row:1,content:'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...' }">Lorem Ipsum</div>
            <div data-timeline-node="{ start:'2017-05-23 00:00',end:'2017-05-23 13:00',row:2,content:'ddd' }">ddd</div>
            <div data-timeline-node="{ start:'2017-05-24 00:00',end:'2017-05-24 13:00',row:2,content:'ggg' }">ggg</div>            
            <div data-timeline-node="{ start:'2017-05-24 00:00',end:'2017-05-24 13:00',row:3,content:'ggg' }">ggg</div>
            <div data-timeline-node="{ start:'2017-05-23 00:00',end:'2017-05-23 13:00',row:3,content:'ddd' }">ddd</div>
            <div data-timeline-node="{ start:'2017-05-24 00:00',end:'2017-05-24 13:00',row:4,content:'ggg' }">ggg</div>
            <div data-timeline-node="{ start:'2017-05-23 00:00',end:'2017-05-23 13:00',row:4,content:'ddd' }">ddd</div>            
        </div>
      
    </div>



    <!-- Timeline Event Detail View Area (optional) -->
    <div class="timeline-event-view"></div>

</body>
</html>
