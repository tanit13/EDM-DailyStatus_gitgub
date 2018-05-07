using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class Chart
    {
        private string project;
        private int completed;
        private int running;
        private int failed;
        private int notstarted;
        private int monitor;
        private int total;

        private int meet;
        private int miss;
        private int na;
        private int total_sla;

        private double completed_percent;
        private double running_percent;
        private double failed_percent;
        private double notstarted_percent;
        private double monitor_percent;

        private double meet_percent;
        private double miss_percent;
        private double na_percent;

        public string Project { get; set; }
        public int Completed { get; set; }
        public int Running { get; set; }
        public int Failed { get; set; }
        public int Notstarted { get; set; }
        public int Monitor { get; set; }
        public int Total { get; set; }

        public int Meet { get; set; }
        public int Miss { get; set; }
        public int Na { get; set; }
        public int Total_sla { get; set; }

        public double Completed_percent { get; set; }
        public double Running_percent { get; set; }
        public double Failed_percent { get; set; }
        public double Notstarted_percent { get; set; }        
        public double Monitor_percent { get; set; }

        public double Meet_percent { get; set; }
        public double Miss_percent { get; set; }
        public double Na_percent { get; set; }




    }
}