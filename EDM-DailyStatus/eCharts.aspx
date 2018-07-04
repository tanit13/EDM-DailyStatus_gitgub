<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="eCharts.aspx.cs" Inherits="EDM_DailyStatus.eCharts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/echarts.min.js"></script>
</head>
<body>
    <!-- Prepare a Dom with size (width and height) for ECharts -->
   
    <!-- ECharts import -->
    
    <script type="text/javascript">
        // configure for module loader


        // Initialize after dom ready
      

        var option = {
          
            title: {               
                text: 'Status',
                subtext: 'EDW',
                x: 'center'
            },            
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: ['NotStart:335', 'Running:310', 'Failed:234', 'Completed:134','Total:1548']
            },
            toolbox: {
                show: false,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    magicType: {
                        show: true,
                        type: ['pie', 'funnel'],
                        option: {
                            funnel: {
                                x: '25%',
                                width: '50%',
                                funnelAlign: 'left',
                                max: 1548
                            }
                        }
                    },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            series: [
                {
                    name: 'test',
                    type: 'pie',
                    radius: ['35','50'],
                    center: ['50%', '45%'],
                    data: [
                        { value: 335, name: 'NotStart:335' },
                        { value: 310, name: 'Running:310' },
                        { value: 234, name: 'Failed:234' },
                        { value: 135, name: 'Completed:135' },
                        { value: 1548, name: 'Total:1548' }
                    ],
                      color: ['#ffc107', '#28a745', '#dc3545', '#6c757d', '#17a2b8']
                }
            ]
        };

        $(document).ready(function () {
            
             var myChart = echarts.init(document.getElementById('main'));

        // Load data into the ECharts instance 
        myChart.setOption(option);
        });
         


    </script>


      <div id="main" style="width: 300px;height:300px;"></div>

</body>
</html>
