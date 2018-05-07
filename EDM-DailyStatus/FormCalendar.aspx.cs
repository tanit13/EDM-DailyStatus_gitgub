using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;


namespace EDM_DailyStatus
{
    public partial class FormCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lt_dataEvent.Text = dataCalendar().ToString();
            

        }

        private StringBuilder dataCalendar() {

            CalendarDAO calendarDao = new CalendarDAO();
            List<Calendar> lst_cald = new List<Calendar>();
            lst_cald = calendarDao.getEventCalendar();

            Console.Out.WriteLine("start load calendar ");

            StringBuilder js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" data = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst_cald));
            js_json.Append(";</script> ");

            return js_json;

        }
    }
}