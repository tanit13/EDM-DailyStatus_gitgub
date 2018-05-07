using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormSAS : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //lt_tbl_sas_all_frequency.Text = getSASFrequency("").ToString();
            //lt_tbl_sas_daily.Text = getSASFrequency("Daily").ToString();
            //lt_tbl_sas_workdays.Text = getSASFrequency("Workdays").ToString();
            //lt_tbl_sas_weekly.Text = getSASFrequency("Weekly").ToString();
            //lt_tbl_sas_monthly.Text = getSASFrequency("Monthly").ToString();

            //lt_tbl_sas_all_status.Text = getSASStatus("").ToString();
            //lt_tbl_sas_monitor.Text = getSASStatus("Monitor").ToString();
            //lt_tbl_sas_running.Text = getSASStatus("Running").ToString();
            //lt_tbl_sas_finished.Text = getSASStatus("Completed").ToString();

            lt_json_status_all.Text = getSASStatus("", "va_all").ToString();
            lt_json_monitor.Text = getSASStatus("Monitor", "va_monitor").ToString();
            lt_json_running.Text = getSASStatus("Running", "va_running").ToString();
            lt_json_completed.Text = getSASStatus("Completed", "va_completed").ToString();

            getSumStatusSAS(); 
        }

        public StringBuilder getSASFrequency(string frequency)
        {
            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            StringBuilder strBld = new StringBuilder();

            lst = oraReportDao.getReportSASFreqency(frequency);

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

        public StringBuilder getSASStatus(string status ,string nameJson)
        {

            List<MonitorStatus> lst = new List<MonitorStatus>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            StringBuilder strBld = new StringBuilder();

            lst = oraReportDao.getReportSASStatus(status);
            //string chk_c_sla = "";

            StringBuilder js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var  ").Append(nameJson).Append(" = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lst));
            js_json.Append(";</script> ");

            //for (int i = 0; i < lst.Count; i++)
            //{

                //if (lst[i].C_sla == "Meet")
                //{
                //    chk_c_sla = "<td><span class='badge badge-pill badge-success'>Meet</span></td>";
                //}
                //else if (lst[i].C_sla == "Miss")
                //{
                //    chk_c_sla = "<td><span class='badge badge-pill badge-danger'>Miss</span></td>";
                //}
                //else { chk_c_sla = "<td></td>"; }


            //    strBld.Append("<tr>");
            //    strBld.Append("<td>").Append(lst[i].Status).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Status_name.Substring(2)).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Sla).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].C_sla).Append("</td>");                
            //    strBld.Append("<td>").Append(lst[i].Work_name).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Batch_name).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Business_date).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Job_start_date).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Job_end_date).Append("</td>");
            //    strBld.Append("<td>").Append(lst[i].Frequency).Append("</td>");
            //    strBld.Append("</tr>");
            //}
            return js_json;

        }

        public void getSumStatusSAS() {
            List<Chart> lst = new List<Chart>();
            OracleReportDAO oraReportDao = new OracleReportDAO();
            lst = oraReportDao.getSumStatusSAS();

            if (lst.Count > 0) { 
                h_num_completed.InnerText = lst[0].Completed.ToString();
                probar_completed.Style.Add("width", lst[0].Completed_percent.ToString()+"%");
                p_completed_p.InnerText = lst[0].Completed_percent.ToString() + "%";

                h_num_running.InnerText = lst[0].Running.ToString();
                probar_running.Style.Add("width", lst[0].Running_percent.ToString() + "%");
                p_running_p.InnerText = lst[0].Running_percent.ToString() + "%";

                h_num_monitor.InnerText = lst[0].Monitor.ToString();
                probar_monitor.Style.Add("width", lst[0].Monitor_percent.ToString() + "%");
                p_monitor_p.InnerText = lst[0].Monitor_percent.ToString() + "%";

                h_num_total.InnerText = lst[0].Total.ToString();
                probar_total.Style.Add("width","100%");
                p_total_p.InnerText = "100%";

                h_num_meet.InnerText = lst[0].Meet.ToString();
                probar_meet.Style.Add("width", lst[0].Meet_percent.ToString() + "%");
                p_meet_p.InnerText = lst[0].Meet_percent.ToString() + "%";

                h_num_miss.InnerText = lst[0].Miss.ToString();
                probar_miss.Style.Add("width", lst[0].Miss_percent.ToString() + "%");
                p_miss_p.InnerText = lst[0].Miss_percent.ToString() + "%";

                h_num_na.InnerText = lst[0].Na.ToString();
                probar_na.Style.Add("width", lst[0].Na_percent.ToString() + "%");
                p_na_p.InnerText = lst[0].Na_percent.ToString() + "%";

                h_num_total_sla.InnerText = lst[0].Total_sla.ToString();
                probar_total_sla.Style.Add("width", "100%");
                p_total_sla_p.InnerText = "100%";

            }

        }
    }
}