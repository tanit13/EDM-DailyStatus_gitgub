using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class Calendar
    {
        string Title;
        string Description;
        string Start;
        string End;
        string Color;

        string color_id;
        string color_name;
        string color_code;

        int ev_inx;
        int cat_inx;
        string inciden_no;
        string change_no;
        string area;
        string ev_details;
        string ev_start_date;
        string ev_end_date;

        public string title { get; set; }
        public string description { get; set; }
        public string start { get; set; }
        public string end { get; set; }
        public string color { get; set; }

        public string Color_id { get; set; }
        public string Color_name { get; set; }
        public string Color_code { get; set; }

        public int Ev_inx { get; set; }
        public int Cat_inx { get; set; }
        public string Inciden_no { get; set; }
        public string Change_no { get; set; }
        public string Area { get; set; }
        public string Ev_details { get; set; }
        public string Ev_start_date { get; set; }
        public string Ev_end_date { get; set; }
        
    }
}