using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class LoggingError
    {
        private string update_ts;
        private string stream_key;
        private string process_name;
        private string auto_analyze_log;
        private string sys_log;

        public string Update_ts { get ; set ; }
        public string Stream_key { get; set; }
        public string Process_name { get; set; }
        public string Auto_analyze_log { get; set; }
        public string Sys_log { get; set; }
    }
}