using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class ConfigLineNotify
    {
        string group_name;
        string token;        
        string odbc_name;
        string query;
        string hour_of_send;
        string status;

        public string Group_name { get; set; }
        public string Token { get; set; }
        public string Odbc_name { get; set; }
        public string Query { get; set; }
        public string Hour_of_send { get; set; }
        public string Status { get => status; set => status = value; }
    }
}