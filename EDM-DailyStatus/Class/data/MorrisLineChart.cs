using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class MorrisLineChart
    {
        string name;
        string value;

        int today;
        int yesterday;
        int average;

        int completed;

        public string Name { get ; set ; }
        public string Value { get; set; }

        public int Today { get; set; }
        public int Yesterday { get; set; }
        public int Average { get; set; }

        public int Completed { get; set; }
    }
}