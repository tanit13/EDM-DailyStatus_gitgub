using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class StreamHealthy
    {
        private string status;
        private string stream_key;
        private string stream_name;
        private string group_name;
        private string stream_last_busdate;
        private string stream_start_time;
        private string stream_end_time;

        public string Status { set; get; }
        public string Stream_key { set; get; }
        public string Stream_name { set; get; }
        public string Group_name { set; get; }
        public string Stream_last_busdate { set; get; }
        public string Stream_start_time { set; get; }
        public string Stream_end_time { set; get; }
        
    }
}