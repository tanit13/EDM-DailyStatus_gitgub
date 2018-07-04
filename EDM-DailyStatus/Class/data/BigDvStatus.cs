using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class BigDvStatus
    {
        string work_name;
        string batch_name;
        string pg;
        string completed;
        string failed;
        string total;

        public string Work_name { get ; set ; }
        public string Batch_name { get; set; }
        public string Pg { get; set; }
        public string Completed { get; set; }
        public string Failed { get; set; }
        public string Total { get; set; }

    }
}