using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                if (txb_chk_mode.Value == "new")
                {
                    calendarInsert();
                }
                else if (txb_chk_mode.Value == "delete")
                {
                    calendarDelete();
                }
                else
                {
                    calendarUpdate();
                }

            }
            else { showCatName(); }
            lt_dataEvent.Text = dataCalendar().ToString();
            

        }

        private StringBuilder dataCalendar() {

            CalendarDAO calendarDao = new CalendarDAO();
            List<Class.data.Calendar> lst_cald = new List<Class.data.Calendar>();
            lst_cald = calendarDao.getEventCalendar();

            Console.Out.WriteLine("start load calendar ");

            StringBuilder js_json = new StringBuilder();
            StringBuilder js_json_ = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" data = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst_cald));
            js_json.Append(";</script> ");       

            //System.IO.File.WriteAllText("/json_data/testjson.text", (new JavaScriptSerializer()).Serialize(lst_cald));

            return js_json;

        }       
       
        private void calendarInsert() {
            List<Class.data.Calendar> lst_cald = new List<Class.data.Calendar>();
            Class.data.Calendar obj_cld = new Class.data.Calendar();
            
            obj_cld.Cat_inx = Convert.ToInt16(drop_down_cat_name.Value);
            obj_cld.Inciden_no = txb_indiden_no.Value;
            obj_cld.Change_no = txb_change_no.Value;
            obj_cld.Area    = txb_area.Value;
            obj_cld.Ev_details = txb_ev_detail.Value;

            obj_cld.Ev_start_date = dte_start.Value;
            obj_cld.Ev_end_date = dte_end.Value;

            lst_cald.Add(obj_cld);

            

            CalendarDAO calDao = new CalendarDAO();
            calDao.insertCalendarEvent(lst_cald);

           // lt_dataEvent.Text = dataCalendar().ToString();
        }

        private void calendarUpdate()
        {
            List<Class.data.Calendar> lst_cald = new List<Class.data.Calendar>();
            Class.data.Calendar obj_cld = new Class.data.Calendar();

            obj_cld.Ev_inx = Convert.ToInt16(txb_ev_inx.Value);
            obj_cld.Cat_inx = Convert.ToInt16(drop_down_cat_name.Value);
            obj_cld.Inciden_no = txb_indiden_no.Value;
            obj_cld.Change_no = txb_change_no.Value;
            obj_cld.Area = txb_area.Value;
            obj_cld.Ev_details = txb_ev_detail.Value;

            obj_cld.Ev_start_date = dte_start.Value;
            obj_cld.Ev_end_date = dte_end.Value;

            lst_cald.Add(obj_cld);

            CalendarDAO calDao = new CalendarDAO();
            calDao.updateCalendarEvent(lst_cald);

            
        }

        private void calendarDelete()
        {
            Class.data.Calendar obj_cld = new Class.data.Calendar();
            CalendarDAO calDao = new CalendarDAO();
            calDao.deleteCalendarEvent(Convert.ToInt16(txb_ev_inx.Value), txb_reason.Value );            
        }

        private void showCatName() {
            CalendarDAO calDao = new CalendarDAO();            
            List<CatName> lst_catname = new List<CatName>();
            lst_catname = calDao.getCatName();

            string str_catName = "";
            //drop_down_cat_name.Items.Clear();
            for (int i = 0; i< lst_catname.Count; i++) {

                str_catName += " <li class='list-group-item'><button class='btn btn-lg rounded-0' type='button' style='background-color:" + lst_catname[i].Cat_color + "'>   </button><strong  style='padding-left:10px'>" + lst_catname[i].Cat_name  + "</strong></li> ";

                drop_down_cat_name.Items.Add(new ListItem(lst_catname[i].Cat_name, lst_catname[i].Cat_inx.ToString()));
            }
            
            lt_list_cat_name.Text = str_catName;            
        }


        [WebMethod]
        public static string getCalEvent(int ev_inx) {
            
            CalendarDAO calDao = new CalendarDAO();
            string str_calendar =  new JavaScriptSerializer().Serialize(calDao.getEventCalendar(ev_inx));

            return str_calendar;
        }



    }
}