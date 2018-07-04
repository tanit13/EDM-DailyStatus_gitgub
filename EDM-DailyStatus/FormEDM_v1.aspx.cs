using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace EDM_DailyStatus
{
    public partial class FormEDM_v1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //getStatusSummaryProject();

            dataTimeline();
            getDataMorrisLineChartSum();
            getSummarySLA();
        }

        private void getStatusSummaryProject() {

            ChartDAO chartDao = new ChartDAO();
            List<Chart> lst_chart = new List<Chart>();
            lst_chart = chartDao.getTotalStatus("");

            // ----- set value to pie chart  ------
            span_pie_circle.InnerText = lst_chart[0].Completed_percent.ToString();
            string str_comple_p = "";
            if (lst_chart[0].Completed_percent < 51)
            {
                str_comple_p = "progress-circle  p" + lst_chart[0].Completed_percent;
            }
            else
            {
                str_comple_p = "progress-circle over50  p" + lst_chart[0].Completed_percent;
            }
            div_pie_circle.Attributes.Add("class", str_comple_p);

            h_total_on_pie.InnerText = lst_chart[0].Total.ToString();
            h_failed_on_pie.InnerText = lst_chart[0].Failed_percent.ToString() + "%";
            h_running_on_pie.InnerText = lst_chart[0].Running_percent.ToString() + "%";
            h_notstart_on_pie.InnerText = lst_chart[0].Notstarted_percent.ToString() + "%";

            span_running.InnerText = lst_chart[0].Running.ToString();
            span_failed.InnerText = lst_chart[0].Failed.ToString();
            span_monitor.InnerText = lst_chart[0].Notstarted.ToString();
        }

        private void dataTimeline() {
            ChartDAO chartDao = new ChartDAO();
            List<TimelineEDM> lst_timeline = new List<TimelineEDM>();
            lst_timeline = chartDao.getTimelineEDM();

            List<string> lst_timeline1 = new List<string>();
            List<string> lst_timeline2 = new List<string>();
            List<string> lst_timeline3 = new List<string>();
            List<string> lst_timeline4 = new List<string>();
            List<string> lst_timeline5 = new List<string>();
            List<string> lst_timeline6 = new List<string>();

            List<string> lst_timeline1_t2 = new List<string>();
            List<string> lst_timeline2_t2 = new List<string>();
            List<string> lst_timeline3_t2 = new List<string>();
            List<string> lst_timeline4_t2 = new List<string>();
            List<string> lst_timeline5_t2 = new List<string>();
            List<string> lst_timeline6_t2 = new List<string>();

            List<string> lst_timeline1_t3 = new List<string>();
            List<string> lst_timeline2_t3 = new List<string>();
            List<string> lst_timeline3_t3 = new List<string>();
            List<string> lst_timeline4_t3 = new List<string>();
            List<string> lst_timeline5_t3 = new List<string>();
            List<string> lst_timeline6_t3 = new List<string>();

            //List<string> lst_timeline1_file_ext = new List<string>();
            //List<string> lst_timeline2_file_ext = new List<string>();
            //List<string> lst_timeline3_file_ext = new List<string>();
            //List<string> lst_timeline4_file_ext = new List<string>();
            //List<string> lst_timeline5_file_ext = new List<string>();
            //List<string> lst_timeline6_file_ext = new List<string>();

            for (int i = 0; i < lst_timeline.Count(); i++)
            {

                switch (lst_timeline[i].Timeline)
                {
                    case "00:00 - 03:59":                        
                        //lst_timeline1.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);

                        switch (lst_timeline[i].Tier)
                        {
                            case "TIER1":
                                lst_timeline1.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER2":
                                lst_timeline1_t2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER3":
                                lst_timeline1_t3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                        }


                        break;
                    case "04:00 - 07:59":
                       // lst_timeline2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);

                        switch (lst_timeline[i].Tier)
                        {
                            case "TIER1":
                                lst_timeline2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER2":
                                lst_timeline2_t2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER3":
                                lst_timeline2_t3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                        }

                        break;
                    case "08:00 - 11:59":
                      //  lst_timeline3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);

                        switch (lst_timeline[i].Tier)
                        {
                            case "TIER1":
                                lst_timeline3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER2":
                                lst_timeline3_t2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER3":
                                lst_timeline3_t3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                        }

                        break;
                    case "12:00 - 15:59":
                       // lst_timeline4.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);

                        switch (lst_timeline[i].Tier)
                        {
                            case "TIER1":
                                lst_timeline4.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER2":
                                lst_timeline4_t2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER3":
                                lst_timeline4_t3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                        }

                        break;
                    case "16:00 - 19:59":
                       // lst_timeline5.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);

                        switch (lst_timeline[i].Tier)
                        {
                            case "TIER1":
                                lst_timeline5.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER2":
                                lst_timeline5_t2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER3":
                                lst_timeline5_t3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                        }

                        break;
                    case "20:00 - 23:59":
                       // lst_timeline6.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);

                        switch (lst_timeline[i].Tier)
                        {
                            case "TIER1":
                                lst_timeline6.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER2":
                                lst_timeline6_t2.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                            case "TIER3":
                                lst_timeline6_t3.Add(lst_timeline[i].Group_status + " " + lst_timeline[i].Group_name);
                                break;
                        }

                        break;
                }

                //switch (lst_timeline[i].Tier) {
                //    case "TIER1":
                //        break;
                //    case "TIER2":
                //        break;
                //    case "TIER3":
                //        break;
                //}

            }

            lt_timeline_1.Text = timeMore20Row(lst_timeline1).ToString();
            lt_timeline_2.Text = timeMore20Row(lst_timeline2).ToString();
            lt_timeline_3.Text = timeMore20Row(lst_timeline3).ToString();
            lt_timeline_4.Text = timeMore20Row(lst_timeline4).ToString();
            lt_timeline_5.Text = timeMore20Row(lst_timeline5).ToString();
            lt_timeline_6.Text = timeMore20Row(lst_timeline6).ToString();

            lt_timeline_1_tier2.Text = timeMore20Row(lst_timeline1_t2).ToString();
            lt_timeline_2_tier2.Text = timeMore20Row(lst_timeline2_t2).ToString();
            lt_timeline_3_tier2.Text = timeMore20Row(lst_timeline3_t2).ToString();
            lt_timeline_4_tier2.Text = timeMore20Row(lst_timeline4_t2).ToString();
            lt_timeline_5_tier2.Text = timeMore20Row(lst_timeline5_t2).ToString();
            lt_timeline_6_tier2.Text = timeMore20Row(lst_timeline6_t2).ToString();

            lt_timeline_1_tier3.Text = timeMore20Row(lst_timeline1_t3).ToString();
            lt_timeline_2_tier3.Text = timeMore20Row(lst_timeline2_t3).ToString();
            lt_timeline_3_tier3.Text = timeMore20Row(lst_timeline3_t3).ToString();
            lt_timeline_4_tier3.Text = timeMore20Row(lst_timeline4_t3).ToString();
            lt_timeline_5_tier3.Text = timeMore20Row(lst_timeline5_t3).ToString();
            lt_timeline_6_tier3.Text = timeMore20Row(lst_timeline6_t3).ToString();

        }

        private StringBuilder timeMore20Row(List<string> lst_timeline) {
            StringBuilder str_bl = new StringBuilder();

            if (lst_timeline.Count > 20)
            {
                for (int i = 0; i < lst_timeline.Count; i++)
                {

                    if ((i % 2) == 0) {
                        str_bl.Append("<tr><td><div style='padding-right:5px;'>").Append(lst_timeline[i]).Append("</div></td>");
                    }
                    else {
                        str_bl.Append("<td>").Append(lst_timeline[i]).Append("</td></tr>");
                    }
                }

            }
            else {
                for (int i = 0; i < lst_timeline.Count; i++) {
                    str_bl.Append("<tr><td><div style='padding-right:5px;'>").Append(lst_timeline[i]).Append("</div></td></tr>");
                }
            }


            return str_bl;
        }

        [WebMethod] 
        public static string getDataMorrisLineChart() {
            OracleReportDAO oratDao = new OracleReportDAO();
            string str_data = "";

            str_data = new JavaScriptSerializer().Serialize(oratDao.dataMorrisLineChart());          

            return str_data;

        }

        [WebMethod]
        public static string getDataMorrisPie()
        {
            ChartDAO chartDao = new ChartDAO();
            List<Chart> lst_chart = new List<Chart>();
            lst_chart = chartDao.getTotalStatus("");

            string str_data = new JavaScriptSerializer().Serialize(lst_chart);

            return str_data;

        }

        [WebMethod]
        public static string getDataSummaryProject() {
            
            ChartDAO chartDao = new ChartDAO();
            List<SummaryProject> lst_ = new List<SummaryProject>();
            lst_ = chartDao.getSummaryProjects();

            string dataJson = new JavaScriptSerializer().Serialize(lst_);

            return dataJson;
        }
        
        private void getDataMorrisLineChartSum()
        {
            OracleReportDAO oratDao = new OracleReportDAO();
            List<MorrisLineChart> lst_obj = new List<MorrisLineChart>();
            

            lst_obj = oratDao.dataMorrisLineChartSum();

            Console.Out.WriteLine("");

           int value = 1234567890;
            Console.WriteLine(value.ToString("0,0", CultureInfo.InvariantCulture));

            div_today.InnerText = lst_obj[0].Today.ToString("0,0", CultureInfo.InvariantCulture);
            div_yesterday.InnerText = lst_obj[0].Yesterday.ToString("0,0", CultureInfo.InvariantCulture);
            div_average.InnerText = lst_obj[0].Average.ToString("0,0", CultureInfo.InvariantCulture);

        }

        private void getSummarySLA() {
            SlaDAO sla_dao = new SlaDAO();
            List<Sla> lst_sla = new List<Sla>();

            lst_sla = sla_dao.summarySlaEDM();
            if (lst_sla.Count > 0)
            {
                h_meet.InnerText = lst_sla[0].Meet.ToString("0,0", CultureInfo.InstalledUICulture);
                h_miss.InnerText = lst_sla[0].Miss.ToString("0,0", CultureInfo.InstalledUICulture);
                span_meet_p.InnerText = lst_sla[0].Meet_p.ToString() + "%";
                span_miss_p.InnerText = lst_sla[0].Miss_p.ToString() + "%";
               // b_completed_job.InnerText = lst_sla[0].Completed.ToString("0,0", CultureInfo.InstalledUICulture);
            }
            else {
                h_meet.InnerText = "-";
                h_miss.InnerText = "-";
                span_meet_p.InnerText = "-";
                span_miss_p.InnerText = "-";
            }

        }
    }
}