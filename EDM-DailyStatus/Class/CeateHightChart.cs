﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for CeateHightChart
/// </summary>
public class CreateHightChart
{
	public string Line_Chart(DataTable dt, string Title,string SubTitle, string Unit)
	{
        string _String = "";
        _String += "<script type='text/javascript'>";
        _String += "$(function () {";
        _String += "    $('#container').highcharts({";
        _String += "        title: {";
        _String += "            text: 'onthly Average Temperature',";
        _String += "            x: -20 //center";
        _String += "        },";
        _String += "        subtitle: {";
        _String += "            text: 'Source: WorldClimate.com',";
        _String += "            x: -20";
        _String += "        },";
        _String += "        xAxis: {";
        _String += "            categories: ['Jan',";
        _String += "                 'Oct', 'Nov', 'Dec']";
        _String += "        },";
        _String += "        yAxis: {";
        _String += "            title: {";
        _String += "                text: 'Temperature (°C)'";
        _String += "            },";
        _String += "            plotLines: [{";
        _String += "                value: 0,";
        _String += "                width: 1,";
        _String += "                color: '#808080'";
        _String += "            }]";
        _String += "        },";
        _String += "        tooltip: {";
        _String += "            valueSuffix: '°C'";
        _String += "        },";
        _String += "        legend: {";
        _String += "            layout: 'vertical',";
        _String += "            align: 'right',";
        _String += "            verticalAlign: 'middle',";
        _String += "            borderWidth: 0";
        _String += "        },";
        //_String += "        series: [";

        //for (int y = 0; y < dt.Rows.Count; y++)
        //{

        //    for (int i = 0; i < dt.Columns.Count; i++)
        //    {
        //        _String += "            {name: '" + dt.Rows[y]["Group"].ToString() + "',";
        //        _String += "            data: [" + dt.Rows[y]["September"].ToString() + ", " + dt.Rows[y]["October"].ToString() + ", " + dt.Rows[y]["November"].ToString() + ", " + dt.Rows[y]["December"].ToString() + "]}";

        //        if (i + 1 != dt.Columns.Count)
        //        {
        //            _String += ",";
        //        }
        //    }
        //}

        //_String += "        ]";

        _String += "  series: [{";
        _String += "    name: 'Tokyo',";
        _String += "    data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]";
        _String += "}, {";
        _String += "    name: 'New York',";
        _String += "    data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]";
        _String += "}, {";
        _String += "    name: 'Berlin',";
        _String += "    data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]";
        _String += "}, {";
         _String += "   name: 'London',";
       _String += "     data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]";
       _String += " }]";
        _String += "    });";
        _String += "});";
        _String += "</script>";

        return _String;
	}
}