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

        public string title { get; set; }
        public string description { get; set; }
        public string start { get; set; }
        public string end { get; set; }
        public string color { get; set; }
        public string Color_id { get; set; }
        public string Color_name { get; set; }
        public string Color_code { get; set; }
    }
}