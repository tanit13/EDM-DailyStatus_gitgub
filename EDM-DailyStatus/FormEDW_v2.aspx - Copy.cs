using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormEDW_v2 : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //    lt_tbl_edw_all_frequency.Text = getEDWFrequency("").ToString();
            //    lt_tbl_edw_daily.Text = getEDWFrequency("Daily").ToString();
            //    lt_tbl_edw_workdays.Text = getEDWFrequency("Workdays").ToString();
            //    lt_tbl_edw_weekly.Text = getEDWFrequency("Weekly").ToString();
            //    lt_tbl_edw_monthly.Text = getEDWFrequency("Monthly").ToString();

            //lt_tbl_edw_all_status.Text = getEDWStatus("").Tostring();
            //lt_tbl_edw_monitor.Text = getEDWStatus("Monitor").ToString();
            //lt_tbl_edw_running.Text = getEDWStatus("Running").ToString();
            //lt_tbl_edw_finished.Text = getEDWStatus("Completed").ToString();

            lt_json_status_all.Text = getEDWStatus("", "va_all").ToString();
            lt_json_monitor.Text = getEDWStatus("Monitor", "va_monitor").ToString();
            lt_json_running.Text = getEDWStatus("Running", "va_running").ToString();
            lt_json_completed.Text = getEDWStatus("Completed", "va_completed").ToString();

            getSumStatusEDW();
            getDataBarChart();
            dataTimeline();
            dataTimelineSla();
            getSumStatusHmlEDW();
        }

        private StringBuilder getEDWFrequency(string frequency)
        {

            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            StringBuilder strBld = new StringBuilder();

            lst = oraReportDao.getReportEDWFreqency(frequency);

            for (int i = 0; i < lst.Count; i++)
            {
                strBld.Append("<tr>");
                strBld.Append("<td>").Append("<button type = 'button' class='button_status ").Append(lst[i].Status).Append("'></button>").Append("</td>");
                strBld.Append("<td>").Append(lst[i].Status_name.Substring(2)).Append("</td>");
                strBld.Append("<td>").Append(lst[i].Sla).Append("</td>");
                strBld.Append("<td>").Append(lst[i].Work_name).Append("</td>");
                strBld.Append("<td>").Append(lst[i].Batch_name).Append("</td>");
                strBld.Append("<td>").Append(lst[i].Business_date).Append("</td>");
                strBld.Append("<td>").Append(lst[i].Job_start_date).Append("</td>");
                strBld.Append("<td>").Append(lst[i].Job_end_date).Append("</td>");                
                if (frequency == "") strBld.Append("<td>").Append(lst[i].Frequency).Append("</td>");
                strBld.Append("</tr>");
            }
            return strBld;

        }

        public StringBuilder getEDWStatus(string status,string nameJson)
        {

            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();       
            StringBuilder strBld = new StringBuilder();
             
            lst = oraReportDao.getReportEDWStatus_v2(status);
            //(new JavaScriptSerializer()).Serialize(streamDao.getStreamHealthy(project, tier, status));

            StringBuilder js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var  ").Append(nameJson).Append(" = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst));
            js_json.Append(";</script> ");



            //string chk_c_sla="";

            //for (int i = 0; i < lst.Count; i++)
            //{
            //    if (lst[i].C_sla == "Meet") {
            //        chk_c_sla = "<td><span class='badge badge-pill badge-success'>Meet</span></td>" ;
            //    } else if (lst[i].C_sla == "Miss") {
            //        chk_c_sla =  "<td><span class='badge badge-pill badge-danger'>Miss</span></td>";
            //    }
            //    else { chk_c_sla = "<td></td>"; }


            //    strBld.Append("<tr>");
            //    strBld.Append("<td>").Append("<button type = 'button' class='button_status ").Append(lst[i].Status).Append("'></button>").Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Status_name).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Sla).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].C_sla).Append("</td>");
            //    //strBld.Append("<td>").Append(lst[i].Work_name).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Batch_name).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Business_date).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Job_start_date).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Job_end_date).Append("</td>");
            //    strBld.Append("<td></td>");
            //    strBld.Append("<td></td>");
            //    strBld.Append("<td>").Append(lst[i].Frequency).Append("</td>");
            //    strBld.Append("</tr>");
            //}

           return js_json;

        }

        public void getSumStatusEDW()
        {
            List<Chart> lst = new List<Chart>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            lst = oraReportDao.getSumStatusEDW();
            if (lst.Count > 0) {


            //  div_num_completed.InnerText = lst[0].Completed.ToString();
                div_num_completed.InnerText = lst[0].Completed.ToString();
                h_num_completed.InnerText = lst[0].Completed.ToString();
                probar_completed.Style.Add("width", lst[0].Completed_percent.ToString() + "%");
                p_completed_p.InnerText = lst[0].Completed_percent.ToString() + "%";

                div_num_running.InnerText = lst[0].Running.ToString();
                h_num_running.InnerText = lst[0].Running.ToString();
                probar_running.Style.Add("width", lst[0].Running_percent.ToString() + "%");
                p_running_p.InnerText = lst[0].Running_percent.ToString() + "%";

                div_num_monitor.InnerText = lst[0].Monitor.ToString();
                h_num_monitor.InnerText = lst[0].Monitor.ToString();
                probar_monitor.Style.Add("width", lst[0].Monitor_percent.ToString() + "%");
                p_monitor_p.InnerText = lst[0].Monitor_percent.ToString() + "%";

                div_num_total.InnerText = lst[0].Total.ToString();
                h_num_total.InnerText = lst[0].Total.ToString();
                probar_total.Style.Add("width", "100%");
                p_total_p.InnerText = "100%";

                div_num_meet.InnerText = lst[0].Meet.ToString();
                h_num_meet.InnerText = lst[0].Meet.ToString();
                probar_meet.Style.Add("width", lst[0].Meet_percent.ToString() + "%");
                p_meet_p.InnerText = lst[0].Meet_percent.ToString() + "%";

                div_num_miss.InnerText = lst[0].Miss.ToString();
                h_num_miss.InnerText = lst[0].Miss.ToString();
                probar_miss.Style.Add("width", lst[0].Miss_percent.ToString() + "%");
                p_miss_p.InnerText = lst[0].Miss_percent.ToString() + "%";

                h_num_na.InnerText = lst[0].Na.ToString();
                probar_na.Style.Add("width", lst[0].Na_percent.ToString() + "%");
                p_na_p.InnerText = lst[0].Na_percent.ToString() + "%";

                h_num_total_sla.InnerText = lst[0].Total_sla.ToString();
                probar_total_sla.Style.Add("width", "100%");
                p_total_sla_p.InnerText = "100%";

                // -- init data for pie chart ---
                StringBuilder js_json = new StringBuilder();
                string str_monitor = lst[0].Monitor.ToString();
                string str_running = lst[0].Running.ToString();
                string str_complete = lst[0].Completed.ToString();

                string str_na = lst[0].Na.ToString();
                string str_miss = lst[0].Miss.ToString();
                string str_meet = lst[0].Meet.ToString();

                js_json.Append("<script>");

                js_json.Append(" var vaSeries = [");
                js_json.Append("{ value:'").Append(str_monitor).Append("',name:'Monitor : ").Append(str_monitor).Append("'}");
                js_json.Append(",{ value:'").Append(str_running).Append("',name:'Running : ").Append(str_running).Append("'}");
                js_json.Append(",{ value:'").Append(str_complete).Append("',name:'Complete : ").Append(str_complete).Append("'}");
                js_json.Append("];");

                js_json.Append(" var vaLegendData = [");
                js_json.Append("'Monitor : ").Append(str_monitor).Append("'");
                js_json.Append(",'Running : ").Append(str_running).Append("'");
                js_json.Append(",'Complete : ").Append(str_complete).Append("'] ; ");

                js_json.Append(" var vaSeriesSla = [");
                js_json.Append("{ value:'").Append(str_monitor).Append("',name:'Na : ").Append(str_na).Append("'}");
                js_json.Append(",{ value:'").Append(str_running).Append("',name:'Miss : ").Append(str_miss).Append("'}");
                js_json.Append(",{ value:'").Append(str_complete).Append("',name:'Meet : ").Append(str_meet).Append("'}");
                js_json.Append("];");

                js_json.Append(" var vaLegendDataSla = [");
                js_json.Append("'Na : ").Append(str_na).Append("'");
                js_json.Append(",'Miss : ").Append(str_miss).Append("'");
                js_json.Append(",'Meet : ").Append(str_meet).Append("'] ; ");

                js_json.Append("</script>");

                lt_dataPieChart.Text = js_json.ToString();


            }

        }

        public void getSumStatusHmlEDW()
        {
            List<Chart> lst = new List<Chart>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            lst = oraReportDao.getSumStatusHmlEDW();
            if (lst.Count > 0)
            {

                for (int i=0;i< lst.Count;i++) {
                    switch (lst[i].Priority_hml.ToString()) {
                        case "H":
                            monitor_h.InnerText = lst[i].Monitor.ToString();
                            running_h.InnerText = lst[i].Running.ToString();
                            complete_h.InnerText = lst[i].Completed.ToString();
                            total_h.InnerText = lst[i].Total.ToString();
                            break;
                        case "M":
                            monitor_m.InnerText = lst[i].Monitor.ToString();
                            running_m.InnerText = lst[i].Running.ToString();
                            complete_m.InnerText = lst[i].Completed.ToString();
                            total_m.InnerText = lst[i].Total.ToString();
                            break;
                        case "L":
                            monitor_l.InnerText = lst[i].Monitor.ToString();
                            running_l.InnerText = lst[i].Running.ToString();
                            complete_l.InnerText = lst[i].Completed.ToString();
                            total_l.InnerText = lst[i].Total.ToString();
                            break;
                    }
                }

            }

        }

        private void getDataBarChart() {
            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            List<string> lst_batch_name = new List<string>();
            List<string> lst_c_sla = new List<string>();
            List<string> lst_est_hours = new List<string>();

            lst = oraReportDao.dataBarChart();
            StringBuilder js_json = new StringBuilder();
            for (int i =0; i<lst.Count; i++) {
                lst_batch_name.Add(lst[i].Batch_name);
                lst_c_sla.Add(lst[i].C_sla);
                lst_est_hours.Add(lst[i].Est_hours);
            }            

            js_json.Append(" <script>");
            js_json.Append(" var vaBatch_name = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst_batch_name)).Append(" ;  ");

            js_json.Append(" var vaC_sla = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst_c_sla)).Append(" ;  ");

            js_json.Append(" var vaEst_hours = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst_est_hours)).Append(" ;  ");

            js_json.Append(" </script> ");

            lt_dataBarChart.Text = js_json.ToString();

            Console.WriteLine("");
        }

        private void dataTimeline() {
            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            lst = oraReportDao.dataTimeline();

            string str_timeline1 ="", str_timeline2 ="", str_timeline3 = "", str_timeline4 = "", str_timeline5 = "", str_timeline6 = "";


            for (int i = 0; i < lst.Count(); i++) {

                switch (lst[i].Timeline) {                    
                    case "00:00 - 03:59":
                        str_timeline1 += "<div>"+lst[i].Status_timeline+" " + lst[i].Batch_name + "</div>";
                        break;
                    case "04:00 - 07:59":
                        str_timeline2 += "<div>" + lst[i].Status_timeline + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "08:00 - 11:59":
                        str_timeline3 += "<div>" + lst[i].Status_timeline + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "12:00 - 15:59":
                        str_timeline4 += "<div>" + lst[i].Status_timeline + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "16:00 - 19:59":
                        str_timeline5 += "<div>" + lst[i].Status_timeline + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "20:00 - 23:59":
                        str_timeline6 += "<div>" + lst[i].Status_timeline + " " + lst[i].Batch_name + "</div>";
                        break;

                }
            }

            lt_timeline_1.Text = str_timeline1;
            lt_timeline_2.Text = str_timeline2;
            lt_timeline_3.Text = str_timeline3;
            lt_timeline_4.Text = str_timeline4;
            lt_timeline_5.Text = str_timeline5;
            lt_timeline_6.Text = str_timeline6;
        }

        private void dataTimelineSla()
        {
            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            lst = oraReportDao.dataTimelineSla();

            string str_timeline1 = "", str_timeline2 = "", str_timeline3 = "", str_timeline4 = "", str_timeline5 = "", str_timeline6 = "";


            for (int i = 0; i < lst.Count(); i++)
            {

                switch (lst[i].Timeline)
                {
                    case "00:00 - 03:59":
                        str_timeline1 += "<div>" + lst[i].Status_sla + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "04:00 - 07:59":
                        str_timeline2 += "<div>" + lst[i].Status_sla + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "08:00 - 11:59":
                        str_timeline3 += "<div>" + lst[i].Status_sla + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "12:00 - 15:59":
                        str_timeline4 += "<div>" + lst[i].Status_sla + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "16:00 - 19:59":
                        str_timeline5 += "<div>" + lst[i].Status_sla + " " + lst[i].Batch_name + "</div>";
                        break;
                    case "20:00 - 23:59":
                        str_timeline6 += "<div>" + lst[i].Status_sla + " " + lst[i].Batch_name + "</div>";
                        break;

                }
            }

            lt_timeline_sla_1.Text = str_timeline1;
            lt_timeline_sla_2.Text = str_timeline2;
            lt_timeline_sla_3.Text = str_timeline3;
            lt_timeline_sla_4.Text = str_timeline4;
            lt_timeline_sla_5.Text = str_timeline5;
            lt_timeline_sla_6.Text = str_timeline6;
        }



    }
}