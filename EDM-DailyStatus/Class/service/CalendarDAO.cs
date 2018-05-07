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
                strQuery = " select c.CAT_COLOR as color ";
                strQuery += " ,e.CHANGE_NO || ' ' || e.AREA as tilte_";
                strQuery += " ,e.CAT_NAME || '\n' || e.INCIDENT_NO || '\n' || e.CHANGE_NO || '\n' || e.AREA || '\n' || e.EV_DETAILS as desc_ ";
                strQuery += " ,CAST(CAST(e.ev_start_date AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) as start_date ";
                strQuery += " ,CAST(CAST(e.ev_end_date AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) as end_date ";
                strQuery += " from DATALAB_OPER.PSS_CALENDAR_EVENTS e ,  DATALAB_OPER.PSS_CALENDAR_CATEGORIES c ";
                strQuery += " where e.CAT_INX = c.CAT_INX ";

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

                    lst_calendar.Add(obj_calendar);
                }



             }
            catch(Exception e) {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_calendar;
        }
    }
}
