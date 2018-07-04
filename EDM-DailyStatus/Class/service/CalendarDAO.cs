using EDM_DailyStatus.Class.data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TDR.Class;

namespace EDM_DailyStatus.Class.service
{
    public class CalendarDAO
    {
        public List<Calendar> getEventCalendar() {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<Calendar> lst_calendar = new List<Calendar>();

            try
            {
                string strQuery = string.Empty;
                strQuery = " select c.CAT_COLOR as color ,e.ev_inx ";
                strQuery += " ,e.INCIDENT_NO || ' ' || e.AREA as tilte_";
                strQuery += " , (c.CAT_NAME || ' ' || e.INCIDENT_NO || ' ' || e.CHANGE_NO || ' ' || e.AREA || ' ' || e.EV_DETAILS) as desc_ ";
                strQuery += " ,CAST(CAST(e.ev_start_date AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) as start_date ";
                strQuery += " ,CAST(CAST(e.ev_end_date + 1 AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) as end_date ";
                strQuery += " from DATALAB_OPER.PSS_CALENDAR_EVENTS e ,  DATALAB_OPER.PSS_CALENDAR_CATEGORIES c ";
                strQuery += " where e.CAT_INX = c.CAT_INX and e.ev_delete_flg = 0";

                dt = tmm.GetDataTableTera(strQuery);
                Calendar obj_calendar;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_calendar = new Calendar();
                    obj_calendar.color = dt.Rows[i]["color"].ToString();
                    obj_calendar.title = dt.Rows[i]["tilte_"].ToString();
                    obj_calendar.description = dt.Rows[i]["desc_"].ToString();
                    obj_calendar.start = dt.Rows[i]["start_date"].ToString();
                    obj_calendar.end = dt.Rows[i]["end_date"].ToString();
                    obj_calendar.Ev_inx = Convert.ToInt16(dt.Rows[i]["ev_inx"].ToString());

                    lst_calendar.Add(obj_calendar);
                }
             }
            catch(Exception e) {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_calendar;
        }

        public List<Calendar> getEventCalendar(int ev_inx)
        {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<Calendar> lst_calendar = new List<Calendar>();

            try
            {
                string strQuery = string.Empty;
                strQuery = " select ev_inx ,cat_inx ,incident_no ";
                strQuery += ", change_no ,area ,ev_details ";
                strQuery += " ,CAST(CAST(ev_start_date AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) as ev_start_date ";
                strQuery += " ,CAST(CAST(ev_end_date AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) as ev_end_date ";
                strQuery += " from DATALAB_OPER.PSS_CALENDAR_EVENTS ";
                strQuery += " where ev_inx=" + ev_inx;

                dt = tmm.GetDataTableTera(strQuery);
                Calendar obj_calendar;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_calendar = new Calendar();
                    obj_calendar.Ev_inx = Convert.ToInt16(dt.Rows[i]["ev_inx"].ToString());
                    obj_calendar.Cat_inx = Convert.ToInt16(dt.Rows[i]["cat_inx"].ToString());
                    obj_calendar.Inciden_no = dt.Rows[i]["incident_no"].ToString();
                    obj_calendar.Change_no = dt.Rows[i]["change_no"].ToString();
                    obj_calendar.Area = dt.Rows[i]["area"].ToString();
                    obj_calendar.Ev_details = dt.Rows[i]["ev_details"].ToString();
                    obj_calendar.Ev_start_date = dt.Rows[i]["ev_start_date"].ToString();
                    obj_calendar.Ev_end_date = dt.Rows[i]["ev_end_date"].ToString();                  

                    lst_calendar.Add(obj_calendar);
                }
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }
            return lst_calendar;
        }

        public void insertCalendarEvent(List<Calendar> lst_calendar) {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();            

            try
            {
                string strQuery = string.Empty;
                strQuery = " INSERT	INTO DATALAB_OPER.PSS_CALENDAR_EVENTS ";
                strQuery += " (EV_INX, CAT_INX, INCIDENT_NO, CHANGE_NO, AREA, EV_DETAILS,	EV_START_DATE, EV_END_DATE ,ev_delete_flg) ";
                strQuery += " VALUES ( ";
                strQuery += " (select MAX(ev_inx) + 1  from DATALAB_OPER.PSS_CALENDAR_EVENTS) ";
                strQuery += "," + lst_calendar[0].Cat_inx ;
                strQuery += ",'" + lst_calendar[0].Inciden_no + "'";
                strQuery += ",'" + lst_calendar[0].Change_no + "'";
                strQuery += ",'" + lst_calendar[0].Area + "'";
                strQuery += ",'" + lst_calendar[0].Ev_details + "'";
                strQuery += ",'" + lst_calendar[0].Ev_start_date + "'";
                strQuery += ",'" + lst_calendar[0].Ev_end_date + "'";
                strQuery += " ,0 ";
                strQuery += ") ";
                dt = tmm.GetDataTableTera(strQuery);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }
        }

        public void updateCalendarEvent(List<Calendar> lst_calendar)
        {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();

            try
            {
                string strQuery = string.Empty;
                strQuery = " UPDATE DATALAB_OPER.PSS_CALENDAR_EVENTS SET ";
                strQuery += " CAT_INX =" + lst_calendar[0].Cat_inx;
                strQuery += " ,INCIDENT_NO ='" + lst_calendar[0].Inciden_no + "'";
                strQuery += " ,CHANGE_NO ='" + lst_calendar[0].Change_no + "'";
                strQuery += " ,AREA ='" + lst_calendar[0].Area + "'";
                strQuery += " ,EV_DETAILS='" + lst_calendar[0].Ev_details + "'";
                strQuery += " ,EV_START_DATE ='" + lst_calendar[0].Ev_start_date + "'";
                strQuery += " ,EV_END_DATE ='" + lst_calendar[0].Ev_end_date + "'";
                strQuery += " WHERE EV_INX=" + lst_calendar[0].Ev_inx ; 

                dt = tmm.GetDataTableTera(strQuery);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }
        }

        public void deleteCalendarEvent(int ev_inx ,string str_reason)
        {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();

            try
            {
                string strQuery = string.Empty;
                strQuery = " UPDATE DATALAB_OPER.PSS_CALENDAR_EVENTS SET ";
                strQuery += " EV_DELETE_FLG =1";
                strQuery += " ,EV_DELETE_REASON='" + str_reason + "'";
                strQuery += " WHERE EV_INX=" + ev_inx;

                dt = tmm.GetDataTableTera(strQuery);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }
        }

        public List<CatName> getCatName() {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<CatName> lst_catname = new List<CatName>();

            try
            {
                string strQuery = string.Empty;
                strQuery = " select cat_inx ,cat_name ,cat_color ";
                strQuery += " from DATALAB_OPER.PSS_CALENDAR_CATEGORIES order by cat_inx ";

                dt = tmm.GetDataTableTera(strQuery);
                CatName obj_catname;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_catname = new CatName();
                    obj_catname.Cat_inx = Convert.ToInt16(dt.Rows[i]["cat_inx"].ToString());
                    obj_catname.Cat_name = dt.Rows[i]["cat_name"].ToString();
                    obj_catname.Cat_color = dt.Rows[i]["cat_color"].ToString();

                    lst_catname.Add(obj_catname);
                }
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_catname;

        }
    }
}
