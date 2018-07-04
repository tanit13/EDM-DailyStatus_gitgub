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
    public partial class FormBigdata : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getBigMonitor();
            getDvMonitor();
            getBigDvStatus();
        }
        
        public void getBigMonitor()
        {
            List<List<BigMonitor>> lstBigMoni = new List<List<BigMonitor>>();
            
            BigDvDAO bigdv_dao = new BigDvDAO();
            lstBigMoni = bigdv_dao.getDataBigMonitor();
            StringBuilder data_all = new StringBuilder();
            StringBuilder data_comple = new StringBuilder();
            StringBuilder data_error = new StringBuilder();

            StringBuilder js_json ;

            Console.WriteLine(lstBigMoni.Count.ToString());

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_bigmonitora_all = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstBigMoni[0]));
            js_json.Append(";</script> ");
            lt_json_bigmonitorAll.Text = js_json.ToString();

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_bigmonitora_complete = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstBigMoni[1]));
            js_json.Append(";</script> ");
            lt_json_bigmonitorComplete.Text = js_json.ToString();

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_bigmonitora_error = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstBigMoni[2]));
            js_json.Append(";</script> ");
            lt_json_bigmonitorError.Text = js_json.ToString();

        }

        public void getDvMonitor()
        {
            List<List<DvMonitor>> lstDvMoni = new List<List<DvMonitor>>();

            BigDvDAO bigdv_dao = new BigDvDAO();
            lstDvMoni = bigdv_dao.getDataDvMonitor();
            StringBuilder data_all = new StringBuilder();
            StringBuilder data_comple = new StringBuilder();
            StringBuilder data_error = new StringBuilder();

            StringBuilder js_json;            

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_dv_all = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstDvMoni[0]));
            js_json.Append(";</script> ");
            lt_json_dv_all.Text = js_json.ToString();

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_dv_complete = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstDvMoni[1]));
            js_json.Append(";</script> ");
            lt_json_dv_complete.Text = js_json.ToString();

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_dv_error = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstDvMoni[2]));
            js_json.Append(";</script> ");
            lt_json_dv_error.Text = js_json.ToString();

        }

        public void getBigDvStatus()
        {
            List<BigDvStatus> lstBigDv = new List<BigDvStatus>();

            BigDvDAO bigdv_dao = new BigDvDAO();
            lstBigDv = bigdv_dao.getDataBigDvStatus();
            StringBuilder data_bigdv = new StringBuilder();
           

            StringBuilder js_json;

            js_json = new StringBuilder();
            js_json.Append("<script>");
            js_json.Append(" var va_monitor_status = ");
            js_json.Append((new JavaScriptSerializer()).Serialize(lstBigDv));
            js_json.Append(";</script> ");
            lt_json_bigdv.Text = js_json.ToString();
        
        }
    }
}