using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class SummaryIssue
    {
        private string name;
        private int total;

        public string Name { get => name; set => name = value; }
        public int Total { get => total; set => total = value; }
    }
}