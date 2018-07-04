using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class SummaryProject
    {
        string project_name;
        int total;
        int completed_p;

        int meet_p;
        int miss_p;

        public string Project_name { get => project_name; set => project_name = value; }
        public int Total { get => total; set => total = value; }
        public int Completed_p { get => completed_p; set => completed_p = value; }
        public int Meet_p { get => meet_p; set => meet_p = value; }
        public int Miss_p { get => miss_p; set => miss_p = value; }
    }
}