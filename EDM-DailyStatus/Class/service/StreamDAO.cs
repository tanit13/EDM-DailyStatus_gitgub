using EDM_DailyStatus.Class.data;
//using Newtonsoft.Json;
//using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using TDR.Class;

namespace EDM_DailyStatus.Class.service
{
    public class StreamDAO
    {
        public List<StreamHealthy> getStreamHealthy(string project, string tierID, string status) {

            List<StreamHealthy> lst_stm = new List<StreamHealthy>();
            TeraManager tmm = new TeraManager();            
            DataTable dt = new DataTable();

            try
            {          
                string strQuery = string.Empty;

                strQuery += " SELECT STM_STATUS_CR, STM_EXCEPTION_FLG, STREAM_KEY, STREAM_NAME, GROUP_";
                strQuery += ", CAST(CAST(STM_LAST_BUSDATE AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) ";                
                strQuery += " ,CAST(CAST(STM_START_TIME AS  TIMESTAMP(6)) AS VARCHAR(19))";                
                strQuery += " ,CAST(CAST(STM_END_TIME AS  TIMESTAMP(6)) AS VARCHAR(19))";
                strQuery += " FROM DATALAB_OPER.pss_report_detail_status_prj_stm_01 ";
                strQuery += " WHERE TIER = '" + tierID.ToString().Trim() + "' ";
                strQuery += " AND CYCLE_FREQ= 'DAILY' ";
                strQuery += " AND GROUP_ not like 'NoPrc%' ";
                if (status.Equals("EXCEPTION"))
                {
                    strQuery += " AND STM_EXCEPTION_FLG IS NOT NULL ";
                }
                else
                {
                    strQuery += " AND STM_EXCEPTION_FLG IS NULL ";
                }
                strQuery += " AND PROJECT = '" + project + "' ";

                if (!status.Equals("ALL") && !status.Equals("EXCEPTION"))
                {
                    strQuery += " AND STATUS_COLOR_BST in('" + status + "') ";
                }
                strQuery += " ORDER BY STM_LAST_BUSDATE, STM_END_TIME, STREAM_KEY ";

                dt = tmm.GetDataTableTera(strQuery);
                StreamHealthy stm;
                string str_stream_key;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    stm = new StreamHealthy();

                    str_stream_key = dt.Rows[i]["STREAM_KEY"].ToString();
                    str_stream_key += " <a class='fa fa-info-circle text-info menu-links' onclick='streamInfo(" + dt.Rows[i]["STREAM_KEY"].ToString() + ")'></a>";

                    stm.Status = "<button type='button' Class='button_status' Style='background-color:" + dt.Rows[i]["STM_STATUS_CR"].ToString() + ";'></button>";
                    stm.Stream_key = str_stream_key;
                    stm.Stream_name = dt.Rows[i]["STREAM_NAME"].ToString();
                    stm.Group_name = dt.Rows[i]["GROUP_"].ToString();
                    stm.Stream_last_busdate = dt.Rows[i]["STM_LAST_BUSDATE"].ToString();
                    stm.Stream_start_time = dt.Rows[i]["STM_START_TIME"].ToString();
                    stm.Stream_end_time = dt.Rows[i]["STM_END_TIME"].ToString();

                    lst_stm.Add(stm);
                }
            }
            catch (Exception e) {
                System.Console.WriteLine(e.Message.ToString());
            }
            return lst_stm;
        }

        public List<string> getProject(string stream_key) {
            
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<string> lst = new List<string>();

            try {
                string strQuery = string.Empty;
                strQuery = " SELECT DISTINCT project FROM datalab_oper.pss_report_detail_status_prj_stm_01 ";
                strQuery += " WHERE  TIER = 'TIER1' AND PROJECT IS NOT NULL AND PROJECT <> '' ";
                strQuery += " AND STREAM_KEY =" + stream_key;
                strQuery += " ORDER BY project ";

                dt = tmm.GetDataTableTera(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++) {
                    lst.Add("<li>" + dt.Rows[i]["project"].ToString() + "</li>");
                }
                Console.Out.WriteLine("testttt1");
                
            }
            catch (Exception e) {
                Console.WriteLine(e.Message.ToString());
            }


            return lst;
        }

        public StringBuilder getStreamLineNotify() {
            StringBuilder str_ = new StringBuilder();
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            string str_sent="" ;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select  text_  from DATALAB_OPER.line_notify_gezus order by stream_key ";
                

                dt = tmm.GetDataTableTera(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    str_.Append(dt.Rows[i]["text_"].ToString());
                    //str_sent += dt.Rows[i]["text_"].ToString();
                }
               

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
            }


            return str_;

        }

        


    }
}