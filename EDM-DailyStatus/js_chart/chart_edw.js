
google.charts.load("current", { packages: ["timeline"] });
google.charts.setOnLoadCallback(drawChart);
function drawChart() {

    var container = document.getElementById('sla_timeline');
    var chart = new google.visualization.Timeline(container);
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn({ type: 'string', id: 'Room' });
    dataTable.addColumn({ type: 'string', id: 'Name' });
    dataTable.addColumn({ type: 'date', id: 'Start' });
    dataTable.addColumn({ type: 'date', id: 'End' });
    dataTable.addRows([
        ['18-04-2018', 'OPEDWIMiss', new Date(0, 0, 0, 07, 22, 02), new Date(0, 0, 0, 08, 50, 29)],
        ['19-04-2018', 'OPEDWIMiss', new Date(0, 0, 0, 11, 17, 32), new Date(0, 0, 0, 13, 03, 07)],
        ['20-04-2018', 'OPEDWIMeet', new Date(0, 0, 0, 06, 02, 21), new Date(0, 0, 0, 07, 21, 45)],
        ['21-04-2018', 'OPEDWIMiss', new Date(0, 0, 0, 12, 58, 48), new Date(0, 0, 0, 14, 01, 53)],
        ['22-04-2018', 'OPEDWIMeet', new Date(0, 0, 0, 05, 39, 49), new Date(0, 0, 0, 06, 46, 17)],
        ['23-04-2018', 'OPEDWIMeet', new Date(0, 0, 0, 04, 59, 17), new Date(0, 0, 0, 06, 33, 41)],
        ['24-04-2018', 'OPEDWIMeet', new Date(0, 0, 0, 06, 14, 08), new Date(0, 0, 0, 07, 33, 37)]
    ]);

    var options = {
        timeline: { colorByRowLabel: false }
        //,hAxis: {
        //    minValue: new Date(2018, 0, 0, 12, 0, 0,0),
        //    maxValue: new Date(2018, 0, 0, 23, 59, 59,59)
        //}
    };
    //alert('ddd');
    chart.draw(dataTable, options);
}