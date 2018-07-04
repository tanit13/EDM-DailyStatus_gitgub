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
                strQuery += " FROM DATALAB_OPER.pss_report_sumary_prj_stm_01 ";
                strQuery += " WHERE project='" + project + "' " ;
                strQuery += " AND TIER in('TIER1','TIER2','TIER3') ";
                strQuery += " ORDER BY tier ";

                dt = tmm.GetDataTableTera(strQuery); 
                Chart obj_chart;
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_chart = new Chart();

                    obj_chart.Total_str = dt.Rows[i]["total"].ToString();
                    obj_chart.Completed = Convert.ToInt16(dt.Rows[i]["completed"].ToString());
                    obj_chart.Completed_str = dt.Rows[i]["completed"].ToString();
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

        public List<TimelineEDM> getTimelineEDM() {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<TimelineEDM> lst_timeline = new List<TimelineEDM>();

            try {
                string strQuery = string.Empty;
                strQuery = " select  timeline ,grp_nm ,grp_status_bstp ,tier  ";
                strQuery += " from DATALAB_OPER.pss_temp_report_sumary_status_timeline_01  ";
                strQuery += " where timeline !='' ";
                //strQuery +=  " and TIER ='TIER1' ";
                strQuery += " order by tier asc , timeline asc ,grp_nm ";

                dt = tmm.GetDataTableTera(strQuery);
                TimelineEDM obj_timeline;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_timeline = new TimelineEDM();
                    obj_timeline.Timeline = dt.Rows[i]["timeline"].ToString();
                    obj_timeline.Group_name = dt.Rows[i]["grp_nm"].ToString();
                    obj_timeline.Group_status = dt.Rows[i]["grp_status_bstp"].ToString();
                    obj_timeline.Tier = dt.Rows[i]["tier"].ToString();
                    lst_timeline.Add(obj_timeline);
                }

                } catch(Exception e) {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lst_timeline;                      
        }

        public List<SummaryProject> getSummaryProjects() {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<SummaryProject> lst_ = new List<SummaryProject>();

            try
            {
                string strQuery = string.Empty;
                strQuery = " select project, total, completed_p ";
                strQuery += " ,meet_p , miss_p ";
                strQuery += " FROM DATALAB_OPER.pss_report_sumary_prj_stm_01 ";
                strQuery += " where PROJECT <> '' ";
                strQuery += " order by project ";

                dt = tmm.GetDataTableTera(strQuery);
                SummaryProject obj_;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_ = new SummaryProject();
                    obj_.Project_name = dt.Rows[i]["project"].ToString();
                    obj_.Total = Int16.Parse(dt.Rows[i]["total"].ToString());
                    obj_.Completed_p = Int16.Parse(dt.Rows[i]["completed_p"].ToString());
                    obj_.Meet_p = Int16.Parse(dt.Rows[i]["meet_p"].ToString());
                    obj_.Miss_p = Int16.Parse(dt.Rows[i]["miss_p"].ToString());
                    lst_.Add(obj_);
                }

            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst_;

        }

        public List<SummaryIssue> dataSummaryGroupTop() {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<SummaryIssue> lst_ = new List<SummaryIssue>();
            SummaryIssue obj_;
            try {
                string strQuery = string.Empty;
                strQuery = " select group_ , total   from DATALAB_OPER.pss_report_sumary_issue_top5_grp_01 order by rn ";

                dt = tmm.GetDataTableTera(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++) {
                    obj_ = new SummaryIssue();
                    obj_.Name = dt.Rows[i]["group_"].ToString();
                    obj_.Total = Int16.Parse(dt.Rows[i]["total"].ToString());
                    lst_.Add(obj_);
                }

            } catch (Exception e) {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lst_;
        }

        public List<SummaryIssue> dataSummaryIssueTop()
        {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<SummaryIssue> lst_ = new List<SummaryIssue>();
            SummaryIssue obj_;
            try
            {
                string strQuery = string.Empty;
                strQuery = " select  issue as name_ ,total  from DATALAB_OPER.pss_report_sumary_issue_top5_01 order by rn ";

                dt = tmm.GetDataTableTera(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_ = new SummaryIssue();
                    obj_.Name = dt.Rows[i]["name_"].ToString();
                    obj_.Total = Int16.Parse(dt.Rows[i]["total"].ToString());
                    lst_.Add(obj_);
                }

            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lst_;
        }

        public List<SummaryIssue> dataReportSummaryIssue()
        {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<SummaryIssue> lst_ = new List<SummaryIssue>();
            SummaryIssue obj_;
            try
            {
                string strQuery = string.Empty;
                strQuery = " select update_date as name_ , total  from DATALAB_OPER.pss_report_sumary_issue_01 order by 1 ";

                dt = tmm.GetDataTableTera(strQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_ = new SummaryIssue();
                    obj_.Name = dt.Rows[i]["name_"].ToString();
                    obj_.Total = Int16.Parse(dt.Rows[i]["total"].ToString());
                    lst_.Add(obj_);
                }

            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lst_;
        }
    }
}