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

                    //monSt.Job_start_date =  "<table style = 'width: 100%;'>" + 
                    //                            " <tr> "+
                    //                                 "<td style = 'font-size: 8px;'>45%</td> "+  
                    //                                 "<td runat = 'server' id = 'p_running_p' style = 'font-size: 8px; text-align: right;' >Jun 11,2015-Jun 10,2015</td> "+
                    //                                 "</tr> "+       
                    //                               "</table> "+
                    //       "<div class='progress' style='height: 3px;'>" +
                    // "<div runat = 'server' id='probar_running' class='progress-bar bg-warning' role='progressbar' style='width: 50%' aria-valuemin='0' aria-valuemax='100'></div>" +
                    //                       "</div>";

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

        public List<MonitorStatus> getReportEDWStatus_v2(string status)
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;

                strQuery = " select status ,sla ,c_sla ,work_name ,batch_name , business_date ,runtime ";
                strQuery += "  ,job_start_date ,job_end_date ,duration_p ";
                strQuery += "  , frequency , stream ,est_hours ,avg_ ,avg_c ,min_ ,max_ ,first_supportor_id";
                strQuery += " ,wait_appl ,impact ";
                strQuery += " from monitor_edw ";
                if (status != "") strQuery += " where status like '%" + status + "%' ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Status = dt.Rows[i]["status"].ToString().Substring(0, 1);

                    monSt.Status_pic = "<div style='text-align:right !important;'> " +
                                                  "<img width = '30' height = '30' class='media-object rounded-circle' src='pic/avatar-s-7.png' alt='Generic placeholder image' /> "+
                                                  monSt.Status +
                                          //     " <span width='20' height='20' class='badge rounded-circle bg-success'> </span> " +
                                            "</div>" ;


                    monSt.Status_name = dt.Rows[i]["status"].ToString().Substring(2);
                    monSt.Sla = dt.Rows[i]["sla"].ToString();
                    monSt.C_sla = dt.Rows[i]["c_sla"].ToString();
                    monSt.Work_name = dt.Rows[i]["work_name"].ToString();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Business_date = dt.Rows[i]["business_date"].ToString();
                    monSt.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    monSt.Job_end_date = dt.Rows[i]["job_end_date"].ToString();
                    monSt.Frequency = dt.Rows[i]["frequency"].ToString();
                    

                    monSt.Job_start_date = "<table style = 'width: 100%;' class='tbl'>" +
                                                " <tr> " +
                                                     "<td style = 'font-size: 10px;'>"+ dt.Rows[i]["c_sla"].ToString() +" : "+ dt.Rows[i]["est_hours"].ToString() +" Hrs.</td> " +
                                                     "<td runat = 'server' id = 'p_running_p' style = 'font-size: 10px; text-align: right;' >"+  dt.Rows[i]["runtime"].ToString() +"</td> " +
                                                     "</tr> " +
                                                   "</table> " +
                           "<div class='progress' style='height: 3px;'>" +
                     "<div runat = 'server' id='probar_running' class='progress-bar "+ getSla_color(dt.Rows[i]["c_sla"].ToString()) + " progress-bar-striped progress-bar-animated' " +
                     "role='progressbar' style='width: "+ dt.Rows[i]["duration_p"].ToString() + "%' aria-valuemin='0' aria-valuemax='100'></div>" +
                                           "</div>";

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

        public List<MonitorStatus> getReportSASStatus_v2(string status)
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;

                strQuery = " select status ,sla ,c_sla ,work_name ,batch_name , business_date ,runtime ";
                strQuery += "  ,job_start_date ,job_end_date ,duration_p ";
                strQuery += "  , frequency , stream ,est_hours ,avg_ ,avg_c ,min_ ,max_ ,first_supportor_id";
                strQuery += " ,wait_appl ,impact ";
                strQuery += " from monitor_edw ";
                if (status != "") strQuery += " where status like '%" + status + "%' ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Status = dt.Rows[i]["status"].ToString().Substring(0, 1);

                    monSt.Status_pic = "<div style='text-align:right !important;'> " +
                                                  "<img width = '30' height = '30' class='media-object rounded-circle' src='pic/avatar-s-7.png' alt='Generic placeholder image' /> " +
                                                  monSt.Status +
                                            //     " <span width='20' height='20' class='badge rounded-circle bg-success'> </span> " +
                                            "</div>";


                    monSt.Status_name = dt.Rows[i]["status"].ToString().Substring(2);
                    monSt.Sla = dt.Rows[i]["sla"].ToString();
                    monSt.C_sla = dt.Rows[i]["c_sla"].ToString();
                    monSt.Work_name = dt.Rows[i]["work_name"].ToString();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Business_date = dt.Rows[i]["business_date"].ToString();
                    monSt.Job_start_date = dt.Rows[i]["job_start_date"].ToString();
                    monSt.Job_end_date = dt.Rows[i]["job_end_date"].ToString();
                    monSt.Frequency = dt.Rows[i]["frequency"].ToString();


                    monSt.Job_start_date = "<table style = 'width: 100%;' class='tbl'>" +
                                                " <tr> " +
                                                     "<td style = 'font-size: 10px;'>" + dt.Rows[i]["c_sla"].ToString() + " : " + dt.Rows[i]["est_hours"].ToString() + " Hrs.</td> " +
                                                     "<td runat = 'server' id = 'p_running_p' style = 'font-size: 10px; text-align: right;' >" + dt.Rows[i]["runtime"].ToString() + "</td> " +
                                                     "</tr> " +
                                                   "</table> " +
                           "<div class='progress' style='height: 3px;'>" +
                     "<div runat = 'server' id='probar_running' class='progress-bar " + getSla_color(dt.Rows[i]["c_sla"].ToString()) + " progress-bar-striped progress-bar-animated' " +
                     "role='progressbar' style='width: " + dt.Rows[i]["duration_p"].ToString() + "%' aria-valuemin='0' aria-valuemax='100'></div>" +
                                           "</div>";

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

        private string getSla_color(string c_sla) {
            string sla_color = "";
            if (c_sla.Equals("Meet"))
            {
                sla_color = "bg-success";
            }
            else if (c_sla.Equals("Miss"))
            {
                sla_color = "bg-danger";
            }
            else if (c_sla.Equals("NA"))
            {
                sla_color = "bg-dark";
            }
            else { sla_color = ""; }

            return sla_color;

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
                strQuery += " from report_summary_edw_01 ";

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

        public List<Chart> getSumStatusHmlEDW()
        {
            List<Chart> lst_chart = new List<Chart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            Chart obj_chart;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select priority, monitor ,running ,completed ,total ,monitor_p ,running_p ,completed_p ";                
                strQuery += "from report_summary_edw_02_hml ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    obj_chart = new Chart();
                    obj_chart.Priority_hml = dt.Rows[i]["priority"].ToString();
                    obj_chart.Monitor = Convert.ToInt16(dt.Rows[i]["monitor"].ToString());
                    obj_chart.Running = Convert.ToInt16(dt.Rows[i]["running"].ToString());
                    obj_chart.Completed = Convert.ToInt16(dt.Rows[i]["completed"].ToString());
                    obj_chart.Total = Convert.ToInt16(dt.Rows[i]["total"].ToString());
                    obj_chart.Monitor_percent = Convert.ToDouble(dt.Rows[i]["monitor_p"].ToString());
                    obj_chart.Running_percent = Convert.ToDouble(dt.Rows[i]["running_p"].ToString());
                    obj_chart.Completed_percent = Convert.ToDouble(dt.Rows[i]["completed_p"].ToString());                   

                    lst_chart.Add(obj_chart);
                }

            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message);
            }
            return lst_chart;
        }

        public List<MonitorStatus> dataBarChart() {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try {
                string strQuery = string.Empty;
                strQuery = " select batch_name,c_sla ,est_hours from  monitor_edw where c_sla in ('Miss' ,'Meet') order by batch_name ";
                dt = oraManager.GetDataEDW(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    if (dt.Rows[i]["c_sla"].ToString() == "Miss")
                    {
                        monSt.C_sla = "#E04B4A";// "#dc3545"
                    }
                    else {// Meet
                        monSt.C_sla = "#1caf9a"; // "#28a745";
                    }
                    monSt.Est_hours = dt.Rows[i]["est_hours"].ToString();
                    lstMonSt.Add(monSt);
                }


                } catch (Exception e) {
                Console.WriteLine(e.Message.ToString());
            }


            return lstMonSt;

        }

        public List<MonitorStatus> dataTimeline()
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select batch_name ,status, timeline from monitor_edw ";
                strQuery += " where business_date is not null ";
                strQuery += " order by timeline ,status ";
                dt = oraManager.GetDataEDW(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Status_timeline = dt.Rows[i]["status"].ToString().Substring(0, 1);
                    monSt.Timeline = dt.Rows[i]["timeline"].ToString();

                    lstMonSt.Add(monSt);
                }


            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
            }


            return lstMonSt;

        }

        public List<MonitorStatus> dataTimelineSla()
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select batch_name ,c_sla, timeline from monitor_edw ";
                strQuery += " where business_date is not null ";
                strQuery += " order by timeline ,c_sla ";
                dt = oraManager.GetDataEDW(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Status_sla = dt.Rows[i]["c_sla"].ToString();
                    monSt.Timeline = dt.Rows[i]["timeline"].ToString();

                    lstMonSt.Add(monSt);
                }


            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
            }


            return lstMonSt;

        }

        public List<MonitorStatus> dataTimeline(string person)
        {
            List<MonitorStatus> lstMonSt = new List<MonitorStatus>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MonitorStatus monSt;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select batch_name ,status, timeline from monitor_edw ";
                strQuery += " where business_date is not null ";
                strQuery += " and first_supportor_id ='" + person + "' " ;
                strQuery += " order by timeline ,status ";
                dt = oraManager.GetDataEDW(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    monSt = new MonitorStatus();
                    monSt.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    monSt.Status_timeline = dt.Rows[i]["status"].ToString().Substring(0, 1);
                    monSt.Timeline = dt.Rows[i]["timeline"].ToString();

                    lstMonSt.Add(monSt);
                }


            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
            }


            return lstMonSt;

        }

        public List<MorrisLineChart> dataMorrisLineChart() {

            List<MorrisLineChart> lst_linechart = new List<MorrisLineChart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MorrisLineChart obj_linechart;

            try {
                string strQuery = string.Empty;
               // strQuery = " select to_char(start_date,'Mon dd') || '-' ||stat as name_ ,cnt_job as value_  ";
                strQuery = " select display as name_ ,cnt_job as value_  ";
                strQuery += " from report_summary_edm_01_concurr ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++) {
                    obj_linechart = new MorrisLineChart();
                    obj_linechart.Name = dt.Rows[i]["name_"].ToString();
                    obj_linechart.Value = dt.Rows[i]["value_"].ToString();
                    lst_linechart.Add(obj_linechart);
                }

            } catch (Exception e){
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_linechart;
        }

        public List<MorrisLineChart> dataMorrisLineChartEDW()
        {

            List<MorrisLineChart> lst_linechart = new List<MorrisLineChart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MorrisLineChart obj_linechart;

            try
            {
                string strQuery = string.Empty;
                
                strQuery = " select display as name_ ,cnt_job as value_  ";
                strQuery += " from report_summary_edw_01_concurr ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_linechart = new MorrisLineChart();
                    obj_linechart.Name = dt.Rows[i]["name_"].ToString();
                    obj_linechart.Value = dt.Rows[i]["value_"].ToString();
                    lst_linechart.Add(obj_linechart);
                }

            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_linechart;
        }

        public List<MorrisLineChart> dataMorrisLineChartSum()
        {

            List<MorrisLineChart> lst_linechart = new List<MorrisLineChart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MorrisLineChart obj_linechart;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select today ,yesterday , ROUND(average) as average ";
                strQuery += " from report_summary_edm_02_concurr ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_linechart = new MorrisLineChart();
                    obj_linechart.Today =Int16.Parse(dt.Rows[i]["today"].ToString());
                    obj_linechart.Yesterday = Int16.Parse(dt.Rows[i]["yesterday"].ToString());
                    obj_linechart.Average = Int16.Parse(dt.Rows[i]["average"].ToString());
                    lst_linechart.Add(obj_linechart);
                }

            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_linechart;
        }

        public List<MorrisLineChart> dataMorrisLineChartSumEDW()
        {

            List<MorrisLineChart> lst_linechart = new List<MorrisLineChart>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            MorrisLineChart obj_linechart;

            try
            {
                string strQuery = string.Empty;
                strQuery = " select today ,yesterday , ROUND(average) as average ";
                strQuery += " from report_summary_edw_02_concurr ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_linechart = new MorrisLineChart();
                    obj_linechart.Today = Int16.Parse(dt.Rows[i]["today"].ToString());
                    obj_linechart.Yesterday = Int16.Parse(dt.Rows[i]["yesterday"].ToString());
                    obj_linechart.Average = Int16.Parse(dt.Rows[i]["average"].ToString());
                    lst_linechart.Add(obj_linechart);
                }

            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_linechart;
        }

    }
}