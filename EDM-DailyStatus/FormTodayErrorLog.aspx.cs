using BTE.Class;
using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using TDR.Class;

namespace EDM_DailyStatus
{
    public partial class FormTodayErrorLog : System.Web.UI.Page
    {
        TeraManager tmm = new TeraManager();
        BoostrapEvent bte = new BoostrapEvent();
        protected void Page_Load(object sender, EventArgs e)
        {
            get_PSS_TODAY_ERROR_LOG();
           
        }

        private void get_PSS_TODAY_ERROR_LOG()
        {
            StringBuilder str_data = new StringBuilder();
            string strQuery = string.Empty;

            strQuery = " select CAST(CAST(update_ts AS  TIMESTAMP(6)) AS VARCHAR(19)) as update_ts ";
            strQuery += " ,CAST(CAST(update_ts AS date FORMAT 'YYYY-MM-DD') AS VARCHAR(10)) as datets ";
            strQuery += " ,stream_key ,process_name ,auto_analyze_log ,sys_log  ";
            strQuery += " ,default_start_date ,default_end_date ";
            strQuery += " FROM DATALAB_OPER.PSS_TODAY_ERROR_LOG ";
            strQuery += " where datets between default_start_date and default_end_date ";
            strQuery += " order by update_ts desc ";

            DataTable dt = new DataTable();
            dt = tmm.GetDataTableTera(strQuery);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                str_data.Append("<tr>");
                str_data.Append("<td>").Append(dt.Rows[i]["update_ts"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["stream_key"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["process_name"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["auto_analyze_log"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["sys_log"].ToString()).Append("</td>");
                str_data.Append("</tr>");
            }
            if (dt.Rows.Count > 0) {
                dte_start.Value = dt.Rows[0]["default_start_date"].ToString();
                dte_end.Value = dt.Rows[0]["default_end_date"].ToString();
            }

             lt_today_error.Text = str_data.ToString();
        }

        [WebMethod]
        public static string dataSummarGroupTop() {
            ChartDAO chartDao = new ChartDAO();
            List<SummaryIssue> lst = new List<SummaryIssue>();           

            lst = chartDao.dataSummaryGroupTop();
            string str_data = new JavaScriptSerializer().Serialize(lst);

            return str_data;
        }

        [WebMethod]
        public static string dataSummarIssueTop()
        {
            ChartDAO chartDao = new ChartDAO();
            List<SummaryIssue> lst = new List<SummaryIssue>();

            lst = chartDao.dataSummaryIssueTop();
            string str_data = new JavaScriptSerializer().Serialize(lst);

            return str_data;
        }

        [WebMethod]
        public static string dataReportSummaryIssue() {
            ChartDAO chartDao = new ChartDAO();
            List<SummaryIssue> lst = new List<SummaryIssue>();

            lst = chartDao.dataReportSummaryIssue();
            string str_data = new JavaScriptSerializer().Serialize(lst);

            return str_data;
        }
    }
}