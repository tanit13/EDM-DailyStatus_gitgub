
//-- variables for chart -------------
var columns_table_stream = [
    { data: 'Status' },
    { data: 'Stream_key' },
    { data: 'Stream_name' },
    { data: 'Group_name' },
    { data: 'Stream_last_busdate' },
    { data: 'Stream_start_time' },
    { data: 'Stream_end_time' }
];

//-- variables for chart status object ----
var chartStatus;

//-- init chart status for start page ----
function initChartStatus() {
    chartStatus = new Chart(document.getElementById("doughnut-chart"), {
        type: 'doughnut',
        data: {
            labels: ["Completed 1", "Running", "Failed","Not started"],
            datasets: [
                {
                    label: ["Completed 2", "Running", "Failed", "Not started"],
                    backgroundColor: ["#28a745", "#ffc107", "#dc3545", "#C0C0C0"],
                    data: [0,0,0,0]
                }
            ]
        },
        responsive: true,
        maintainAspectRatio: false,
        options: {
            showAllTooltips: true,
            title: {
                display: false,
                text: 'STATUS'
            },
            tooltips: {
                enabled: true
            }
        }
    });
    drawSegmentValues(chartStatus);
}

// -- chart js show value chart
function drawSegmentValues(myPie) {

    //document.getElementById("doughnut-chart").getContext("2d");
    
  //  var test = myPie.segments.length;
 //   alert('drawSegmentValues' + test );
    //alert('width chart test== '+ test.width);
    //var test2 = test.getContext("2d").segments.length;
    //alert('drow chart test 2==++== ' + test2);
}


// -- update chart status ----
function updateChart(vaFinish, vaRun, vaFailed,vaNotstart) {

    chartStatus.data.datasets[0].data[0] = vaFinish;
    chartStatus.data.datasets[0].data[1] = vaRun;
    chartStatus.data.datasets[0].data[2] = vaFailed;
    chartStatus.data.datasets[0].data[4] = vaNotstart;
    chartStatus.update();
}


//-- chart use canvas js ----
function initCanvasChartStatus() {
    console.log('in canvas chart');
    var chart = new CanvasJS.Chart("chartContainer", {

        title: {
            text: "STATUS",
            horizontalAlign: "left"
        },
        data: [{
            type: "doughnut",
            startAngle: 60,
            //innerRadius: 60,
            indexLabelFontSize: 11,
            indexLabel: "{label} \n #percent%",
            toolTipContent: "<b>{label}:</b> {y} (#percent%)",
            dataPoints: [
                { y: 67, label: "Finished" },
                { y: 28, label: "Running" },
                { y: 10, label: "Failed" }
            ]
        }]
    });
    chart.render();
}

//-- function init table bootstrap ---
function initTableStream() {

    $('#tbl_group_sum').DataTable();


    $('#table_alert_stream').DataTable();

    $('#table_all_stream').DataTable({
        columns: columns_table_stream
    });

    $('#table_finish_stream').DataTable({
        columns: columns_table_stream
    });

    $('#table_process_stream').DataTable({
        columns: columns_table_stream
    });
    $('#table_failed_stream').DataTable({
        columns: columns_table_stream
    });

    $('#table_notstart_stream').DataTable({
        columns: columns_table_stream
    });

    $('#table_exception_stream').DataTable({
        columns: columns_table_stream
    });

  
    
}







