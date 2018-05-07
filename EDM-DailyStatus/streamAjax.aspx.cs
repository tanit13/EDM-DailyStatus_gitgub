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
using TDR.Class;

namespace EDM_DailyStatus
{
    public partial class testAjax : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        
        }

        [WebMethod]
        public static string GetStreamAjax(string project ,string tier ,string status)
        {
            StreamDAO streamDao = new StreamDAO();
            string myJsonString = (new JavaScriptSerializer()).Serialize(streamDao.getStreamHealthy(project,tier,status));
            
            return myJsonString;
        }

        [WebMethod]
        public static string GetStatusAjax(string project)
        {
            ChartDAO chartDao = new ChartDAO();
            string str_json = new JavaScriptSerializer().Serialize(chartDao.getTotalStatus(project));

            return str_json;
        }

        [WebMethod]
        public static string GetProjectInfotAjax(string stream_key)
        {
            StreamDAO streamDao = new StreamDAO();
            string str_json = new JavaScriptSerializer().Serialize(streamDao.getProject(stream_key));

            return str_json;
        }

        [WebMethod]
        public static string searchLogErrorToday(string start_date ,string end_date) {
            LoggingDAO logDao = new LoggingDAO();
            string str_json = new JavaScriptSerializer().Serialize(logDao.getLogErrorToday(start_date ,end_date));

            return str_json;
        }



    }
}