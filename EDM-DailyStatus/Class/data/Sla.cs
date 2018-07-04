using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class Sla
    {
        int meet;
        int miss;
        int meet_p;
        int miss_p;
        int completed;

        public int Meet { get => meet; set => meet = value; }
        public int Miss { get => miss; set => miss = value; }
        public int Meet_p { get => meet_p; set => meet_p = value; }
        public int Miss_p { get => miss_p; set => miss_p = value; }
        public int Completed { get => completed; set => completed = value; }
    }
}