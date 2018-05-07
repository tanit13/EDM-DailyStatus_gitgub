using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class JsonTimeLine
    {
        private string job_start_date;
        private string batch_name;
        private string start_date;
        private string end_date;

        public string Job_start_date { get ; set ; }
        public string Batch_name { get; set; }
        public string Start_date { get; set; }
        public string End_date { get; set; }
    }
}