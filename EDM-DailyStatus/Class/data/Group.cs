using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class Group
    {
        private string group_name;
        private int completed;
        private int running;
        private int failed;
        private int notstart;
        private int total;
        private int except;

        public string Group_name { get; set; }
        public int Completed { get; set; }
        public int Running { get; set; }
        public int Failed { get; set; }
        public int Notstart { get; set; }
        public int Total { get; set; }
        public int Except { get; set; }
    }
}