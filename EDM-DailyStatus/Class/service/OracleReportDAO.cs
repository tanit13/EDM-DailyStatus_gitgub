using EDM_DailyStatus.Class.data;
using ORA.Class;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.service
{
    public class OracleReportDAO
    {
        public List<MonitorStatus> getReportEDWFreqency(string frequency) {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;

                strQuery = " select status , sla ,work_name ,batch_name , business_date ";
                strQuery += "  ,job_start_date ,job_end_date ";                
                strQuery += "  , frequency , stream ";
                strQuery += " from monitor_edw ";
                strQuery += " where frequency like '%"+ frequency +"%' ";

                dt = oraManager.GetDataEDW(strQuery);

                for(int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Status =  dt.Rows[i]["status"].ToString().Substring(0,1);
                    monSt.Status_name = dt.Rows[i]["status"].ToString();
                    monSt.Sla = dt.Rows[i]["sla"].ToString();
                    monSt.Work_name = dt.Rows[i]["work_name"].ToString();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Business_date = dt.Rows[i]["business_date"].ToString();
                    monSt.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    monSt.Job_end_date = dt.Rows[i]["job_end_date"].ToString();
                    monSt.Frequency = dt.Rows[i]["frequency"].ToString();
                    monSt.Stream = dt.Rows[i]["stream"].ToString();
                    lstMonSt.Add(monSt);
                }

            }
            catch (Exception e) {
                System.Console.WriteLine(e.Message.ToString());
            }

            return lstMonSt;
        }

        public List<MonitorStatus> getReportEDWStatus(string status)
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;

                strQuery = " select status ,sla ,c_sla ,work_name ,batch_name , business_date ";
                strQuery += "  ,job_start_date ,job_end_date ";                
                strQuery += "  , frequency , stream ,est_hours ,avg_ ,avg_c ,min_ ,max_ ,first_supportor_id";
                strQuery += " ,wait_appl ,impact ";
                strQuery += " from monitor_edw ";
                if(status != "") strQuery += " where status like '%" + status + "%' ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Status = dt.Rows[i]["status"].ToString().Substring(0, 1);
                    monSt.Status_name = dt.Rows[i]["status"].ToString().Substring(2);
                    monSt.Sla = dt.Rows[i]["sla"].ToString();
                    monSt.C_sla = dt.Rows[i]["c_sla"].ToString();
                    monSt.Work_name = dt.Rows[i]["work_name"].ToString();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Business_date = dt.Rows[i]["business_date"].ToString();
                    monSt.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    monSt.Job_end_date = dt.Rows[i]["job_end_date"].ToString();
                    monSt.Frequency = dt.Rows[i]["frequency"].ToString();
                    monSt.Est_hours = dt.Rows[i]["est_hours"].ToString();
                    monSt.Avg_c = dt.Rows[i]["avg_c"].ToString();
                    monSt.Avg = dt.Rows[i]["avg_"].ToString();
                    monSt.Min = dt.Rows[i]["min_"].ToString();
                    monSt.Max = dt.Rows[i]["max_"].ToString();
                    monSt.First_supportor_id = dt.Rows[i]["first_supportor_id"].ToString();
                    monSt.Wait_appl = dt.Rows[i]["wait_appl"].ToString();
                    monSt.Impact_appl = dt.Rows[i]["impact"].ToString();
                    
                    lstMonSt.Add(monSt);
                }

            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }

            return lstMonSt;
        }

        public List<MonitorStatus> getReportSASFreqency(string frequency)
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;

                strQuery = " select status ,sla ,work_name ,batch_name , business_date ";
                strQuery += "  , job_start_date , job_end_date";                
                strQuery += "  , frequency , stream ";
                strQuery += " from monitor_sas ";
                if(frequency != "") strQuery += " where frequency like '%" + frequency + "%' ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Status = dt.Rows[i]["status"].ToString().Substring(0, 1);
                    monSt.Status_name = dt.Rows[i]["status"].ToString();
                    monSt.Sla = dt.Rows[i]["sla"].ToString();
                    monSt.Work_name = dt.Rows[i]["work_name"].ToString();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Business_date = dt.Rows[i]["business_date"].ToString();
                    monSt.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    monSt.Job_end_date = dt.Rows[i]["job_end_date"].ToString();
                    monSt.Frequency = dt.Rows[i]["frequency"].ToString();
                    monSt.Stream = dt.Rows[i]["stream"].ToString();
                    lstMonSt.Add(monSt);
                }

            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }

            return lstMonSt;
        }

        public List<MonitorStatus> getReportSASStatus(string status)
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;

                strQuery = " select status ,sla ,c_sla ,work_name ,batch_name ,business_date ";
                strQuery += "  ,job_start_date  ,job_end_date   ";
                strQuery += " , frequency , stream , est_hours ,avg_ ,avg_c ,min_ ,max_ ,first_supportor_id";                
                strQuery += " ,wait_appl ,impact ";
                strQuery += " from monitor_sas ";
                if(status !="") strQuery += " where status like '%" + status + "%' ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Status = dt.Rows[i]["status"].ToString().Substring(0, 1);
                    monSt.Status_name = dt.Rows[i]["status"].ToString().Substring(2);                    
                    monSt.Sla = dt.Rows[i]["sla"].ToString();
                    monSt.C_sla = dt.Rows[i]["c_sla"].ToString();
                    monSt.Work_name = dt.Rows[i]["work_name"].ToString();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Business_date = dt.Rows[i]["business_date"].ToString();
                    monSt.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    monSt.Job_end_date = dt.Rows[i]["job_end_date"].ToString();
                    monSt.Frequency = dt.Rows[i]["frequency"].ToString();
                    monSt.Est_hours = dt.Rows[i]["est_hours"].ToString();
                    monSt.Avg_c = dt.Rows[i]["avg_c"].ToString();
                    monSt.Avg = dt.Rows[i]["avg_"].ToString();
                    monSt.Min = dt.Rows[i]["min_"].ToString();
                    monSt.Max = dt.Rows[i]["max_"].ToString();
                    monSt.First_supportor_id = dt.Rows[i]["first_supportor_id"].ToString();
                    monSt.Wait_appl = dt.Rows[i]["wait_appl"].ToString();
                    monSt.Impact_appl = dt.Rows[i]["impact"].ToString();

                    lstMonSt.Add(monSt);
                }

            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }

            return lstMonSt;
        }

        public List<Chart> getSumStatusSAS() {
            List<Chart> lst_chart = new List<Chart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            Chart obj_chart;

            try {
                string strQuery = string.Empty;
                strQuery = " select monitor ,running ,completed ,total ,monitor_p ,running_p ,completed_p ";
                strQuery += " ,meet ,miss ,na  ,meet_p ,miss_p ,na_p ";
                strQuery += "from report_summary_sas_01 ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++) {

                    obj_chart = new Chart();
                    obj_chart.Monitor = Convert.ToInt16(dt.Rows[i]["monitor"].ToString());
                    obj_chart.Running = Convert.ToInt16(dt.Rows[i]["running"].ToString());
                    obj_chart.Completed = Convert.ToInt16(dt.Rows[i]["completed"].ToString());
                    obj_chart.Total = Convert.ToInt16(dt.Rows[i]["total"].ToString());
                    obj_chart.Monitor_percent = Convert.ToDouble(dt.Rows[i]["monitor_p"].ToString());
                    obj_chart.Running_percent = Convert.ToDouble(dt.Rows[i]["running_p"].ToString());
                    obj_chart.Completed_percent = Convert.ToDouble(dt.Rows[i]["completed_p"].ToString());

                    obj_chart.Meet = Convert.ToInt16(dt.Rows[i]["meet"].ToString());
                    obj_chart.Miss = Convert.ToInt16(dt.Rows[i]["miss"].ToString());
                    obj_chart.Na = Convert.ToInt16(dt.Rows[i]["na"].ToString());
                    obj_chart.Total_sla = Convert.ToInt16(dt.Rows[i]["total"].ToString());

                    obj_chart.Meet_percent= Convert.ToDouble(dt.Rows[i]["meet_p"].ToString());
                    obj_chart.Miss_percent = Convert.ToDouble(dt.Rows[i]["miss_p"].ToString());
                    obj_chart.Na_percent = Convert.ToDouble(dt.Rows[i]["na_p"].ToString());

                    lst_chart.Add(obj_chart);          
                }

            } catch (Exception e) {                
                System.Console.WriteLine(e.Message);
            }
            return lst_chart;
        }

        public List<Chart> getSumStatusEDW()
        {
            List<Chart> lst_chart = new List<Chart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            Chart obj_chart;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select monitor ,running ,completed ,total ,monitor_p ,running_p ,completed_p ";
                strQuery += " ,meet ,miss ,na ,sla_ ,meet_p ,miss_p ,na_p ";
                strQuery += "from report_summary_edw_01 ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    obj_chart = new Chart();
                    obj_chart.Monitor = Convert.ToInt16(dt.Rows[i]["monitor"].ToString());
                    obj_chart.Running = Convert.ToInt16(dt.Rows[i]["running"].ToString());
                    obj_chart.Completed = Convert.ToInt16(dt.Rows[i]["completed"].ToString());
                    obj_chart.Total = Convert.ToInt16(dt.Rows[i]["total"].ToString());
                    obj_chart.Monitor_percent = Convert.ToDouble(dt.Rows[i]["monitor_p"].ToString());
                    obj_chart.Running_percent = Convert.ToDouble(dt.Rows[i]["running_p"].ToString());
                    obj_chart.Completed_percent = Convert.ToDouble(dt.Rows[i]["completed_p"].ToString());

                    obj_chart.Meet = Convert.ToInt16(dt.Rows[i]["meet"].ToString());
                    obj_chart.Miss = Convert.ToInt16(dt.Rows[i]["miss"].ToString());
                    obj_chart.Na = Convert.ToInt16(dt.Rows[i]["na"].ToString());
                    obj_chart.Total_sla = Convert.ToInt16(dt.Rows[i]["sla_"].ToString());

                    obj_chart.Meet_percent = Convert.ToDouble(dt.Rows[i]["meet_p"].ToString());
                    obj_chart.Miss_percent = Convert.ToDouble(dt.Rows[i]["miss_p"].ToString());
                    obj_chart.Na_percent = Convert.ToDouble(dt.Rows[i]["na_p"].ToString());

                    lst_chart.Add(obj_chart);
                }

            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message);
            }
            return lst_chart;
        }

    }
}