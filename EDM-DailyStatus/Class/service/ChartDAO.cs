using EDM_DailyStatus.Class.data;
using ORA.Class;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using TDR.Class;

namespace EDM_DailyStatus.Class.service
{
    public class ChartDAO
    {
        public List<Chart> getTotalStatus(string project) {
            
            TeraManager tmm = new TeraManager();            
            DataTable dt = new DataTable();
            List<Chart> lst_chart = new List<Chart>();

            try {
                string strQuery = string.Empty;

                strQuery = " SELECT project ,completed ,running ,failed ,notstarted  ";
                strQuery += " ,completed_p ,running_p ,failed_p ,notstarted_p ,total ";
                strQuery += " FROM DATALAB_OPER.pss_report_sumary_status_prj_stm_01 ";
                strQuery += " WHERE project='" + project + "'";

                dt = tmm.GetDataTableTera(strQuery); 
                Chart obj_chart;
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_chart = new Chart();                  

                    obj_chart.Completed = Convert.ToInt16(dt.Rows[i]["completed"].ToString());
                    obj_chart.Running = Convert.ToInt16(dt.Rows[i]["running"].ToString());
                    obj_chart.Failed = Convert.ToInt16(dt.Rows[i]["failed"].ToString());
                    obj_chart.Notstarted = Convert.ToInt16(dt.Rows[i]["notstarted"].ToString());
                    obj_chart.Total = Convert.ToInt16(dt.Rows[i]["total"].ToString());
                    obj_chart.Completed_percent = Convert.ToDouble(dt.Rows[i]["completed_p"].ToString());
                    obj_chart.Running_percent = Convert.ToDouble(dt.Rows[i]["running_p"].ToString());
                    obj_chart.Failed_percent = Convert.ToDouble(dt.Rows[i]["failed_p"].ToString());
                    obj_chart.Notstarted_percent = Convert.ToDouble(dt.Rows[i]["notstarted_p"].ToString());

                    lst_chart.Add(obj_chart);
                }

                }
            catch (Exception e) {
                System.Console.WriteLine(e.Message.ToString());
            }
            return lst_chart;
        }

        public List<JsonTimeLine> GetJsonTimeLine(string work_name) {

            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            List<JsonTimeLine> lst_timeline = new List<JsonTimeLine>();

            try {
                
                string strQuery = string.Empty;
                strQuery = "  select to_char(job_start_date,'dd-mm-yyyy') as job_start_date ";
                strQuery += "  ,batch_name||' - '||c_sla  as batch_name ";
                strQuery += " ,'new Date(0,0,0,'||to_char(job_start_date,'HH24')||','||to_char(job_start_date,'MI')||','||to_char(job_start_date,'SS')||')' as start_date ";
                strQuery += " ,'new Date(0,0,0,'||to_char(job_end_date,'HH24')||','||to_char(job_end_date,'MI')||','||to_char(job_end_date,'SS')||')' as  end_date ";
                strQuery += " from report_detail_all_02 ";
                strQuery += " where work_name ='" + work_name + "' ";

                dt = oraManager.GetDataEDW(strQuery);
                JsonTimeLine obj_timeline;

                for (int i=0; i< dt.Rows.Count; i++) {
                    obj_timeline = new JsonTimeLine();

                    obj_timeline.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    obj_timeline.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    obj_timeline.Start_date = dt.Rows[i]["start_date"].ToString();
                    obj_timeline.End_date = dt.Rows[i]["end_date"].ToString();
                    lst_timeline.Add(obj_timeline);                    
                }
            }
            catch (Exception e) {
                System.Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_timeline;
        }

    }
}