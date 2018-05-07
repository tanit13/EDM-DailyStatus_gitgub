using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ORA.Class;
using BTE.Class;
using TDR.Class;

namespace EDM_DailyStatus
{
    public partial class StreamKey : System.Web.UI.Page
    {
        TeraManager tmm = new TeraManager();
        BoostrapEvent bte = new BoostrapEvent();

        public string CurrentUrl = "";
        public string CurrentPort = "";
        public string CurrentUrlPort = "";

        public string MsgAlert { set; get; }
        public string PopupJavaMsg = "<script type='text/javascript'>$( document ).ready(function() { $('#myModal').modal('show')});</script>";

        private void BindMessage(string _HeaderMsg, string _DetailMsg, int _Sts)
        {
            Ltl_Popup.Text = bte.Popup_Msg(_HeaderMsg, _DetailMsg, _Sts);
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "script", PopupJavaMsg, false);
        }
        private void ClearMessage()
        {
            Ltl_Popup.Text = string.Empty;
            MsgAlert = string.Empty;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            this.CurrentUrl = HttpContext.Current.Request.Url.Host.ToString();
            this.CurrentPort = HttpContext.Current.Request.Url.Port.ToString();
            if (this.CurrentPort != "" && this.CurrentPort != "80")
            {
                if (this.CurrentPort == "443")
                {
                    this.CurrentUrlPort = "https://" + this.CurrentUrl;
                }
                else
                {
                    this.CurrentUrlPort = "http://" + this.CurrentUrl + ":" + this.CurrentPort;
                }
            }
            else
            {
                this.CurrentUrlPort = "http://" + this.CurrentUrl;
            }

            // this.btn_Getjob.Attributes.Add("onclick", "javascript:" + btn_Getjob.ClientID + ".disabled=true;" + btn_Getjob.ClientID + ".value= 'Processing...';" + this.Page.GetPostBackEventReference(btn_Getjob));

            if (!IsPostBack)
            {
                ClearMessage();

                try
                {

                    txt_StreamName.Text = Request.QueryString["id"].ToString();
                    //txt_StreamName.Text = "CES";
                    //GetJobDepen(Request.QueryString["id"].ToString());
                    GetEDMDataforTable();
                    //DataTable dtViz = GetEDMStatus(txt_StreamName.Text.ToString());
                    //GV_Test.DataSource = dtViz;
                    //GV_Test.DataBind();
                }
                catch
                (Exception ex)
                {
                    MsgAlert = "Cannot get data: " + txt_StreamName.Text.Trim().ToUpper() + ", Bacause" + ex.Message.ToString();
                    BindMessage("Alert", MsgAlert, 0);
                    return;
                }
            }
        }

        private DataTable GetEDMStatus(string strSourceName, string tierID)
        {
            string strQuery = string.Empty;
            //strQuery += "SELECT DISTINCT Master.stm_Status_cr AS Status, T1_Daily.stream_key, T1_Daily.stream_name, T1_Daily.business_date, ";
            //strQuery += "Master.STM_start_time AS Start_Time, Master.stm_End_time AS End_Time ";
            //strQuery += "FROM(SELECT sb.stream_key, s.stream_name, sb.cycle_freq_code, sb.business_date, ";
            //strQuery += "sb.next_business_date, sb.prev_business_date, sb.processing_flag, ";
            //strQuery += "sb.update_user, sb.update_ts ";
            //strQuery += "FROM EDWPRD_GCFRVW.GCFR_Stream_BusDate sb, edwprd_gcfrvw.gcfr_stream s ";
            //strQuery += "WHERE  sb.stream_key = s.stream_key ";
            //strQuery += "AND  s.stream_name like '" + strSourceName + "%' ";
            //strQuery += "AND  sb.Cycle_Freq_Code = 0) AS T1_Daily ";
            //strQuery += "LEFT JOIN DATALAB_OPER.PSS_EDM_STREAM_MASTER_STATUS2 Master ";
            //strQuery += "ON T1_Daily.stream_key = Master.stream_key ";
            //strQuery += "ORDER BY T1_Daily.business_date,T1_Daily.stream_key; ";

            //strQuery += "SELECT STM_STATUS_CR, STREAM_KEY, STREAM_NAME, GROUP_, CAST(CAST(STM_LAST_BUSDATE AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)), STM_START_TIME, STM_END_TIME, ESP_APP ";
            //strQuery += "FROM DATALAB_OPER.PSS_EDM_STREAM_MASTER_STATUS2 ";
            //strQuery += "WHERE GROUP_ LIKE ('" + strSourceName + "%') ";
            ////strQuery += "AND STREAM_KEY = 1352 ";
            //strQuery += "AND TIER = 'TIER" + tierID + "' ";
            //strQuery += "ORDER BY STM_LAST_BUSDATE, STM_END_TIME, STREAM_KEY";

            strQuery += "SELECT STM_STATUS_CR, STM_EXCEPTION_FLG, STREAM_KEY, STREAM_NAME, GROUP_, CAST(CAST(STM_LAST_BUSDATE AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)), STM_START_TIME, STM_END_TIME, ESP_APP ";
            strQuery += "FROM DATALAB_OPER.PSS_STREAM_IN_GRP ";
            strQuery += "WHERE GROUP_ = '" + strSourceName.ToString().Trim().Replace('+',' ') + "' ";
            strQuery += "AND TIER = 'TIER" + tierID.ToString().Trim() + "' ";
            strQuery += "ORDER BY STM_LAST_BUSDATE, STM_END_TIME, STREAM_KEY";

            DataTable dt = new DataTable();
            tmm.TDUsername = Request.Cookies["myCookie_Trackingsrc"]["user"].ToString();
            tmm.TDPassword = Request.Cookies["myCookie_Trackingsrc"]["pass"].ToString();
            dt = tmm.GetDataTableTera(strQuery);

            return dt;
        }

        protected void GetEDMDataforTable()
        {
            ClearMessage();
            try
            {
                string EDMGroup_id = txt_StreamName.Text.Split('.')[0];
                EDMGroup_id.Replace("_", " ");
                string TierID = txt_StreamName.Text.Split('.')[1];
                string strEDMStatus = string.Empty;
                string strSpecialStatus = string.Empty;
                //strEDMStatus += "<script> var a =\"";
                DataTable dtEDMDataStatus = GetEDMStatus(EDMGroup_id, TierID);
                if (dtEDMDataStatus.Rows.Count == 0)
                {
                    MsgAlert = "Not found EDM data";
                    BindMessage("Alert", MsgAlert, 0);
                    return;
                }

                int intDataStatus = 0;
                int intSpecialStatus = 0;
                for (int i = 0; i < dtEDMDataStatus.Rows.Count; i++)
                {
                    if (dtEDMDataStatus.Rows[i]["STM_EXCEPTION_FLG"] != null && dtEDMDataStatus.Rows[i]["STM_EXCEPTION_FLG"].ToString().Trim() == "1")
                    {
                        intSpecialStatus++;

                        strSpecialStatus += "<tr> <td><button type='button' Class='button' Style='background-color:" + dtEDMDataStatus.Rows[i]["STM_STATUS_CR"].ToString() + ";' onclick=window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/solutionToFix.aspx?id=" + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "')></button></td>";
                        strSpecialStatus += "<td><a href='" + this.CurrentUrlPort + "/EDMSTATUS/Default.aspx?id=" + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "'> " + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "</a></td> ";
                        strSpecialStatus += "<td> " + dtEDMDataStatus.Rows[i]["STREAM_NAME"].ToString() + "</td> ";
                        strSpecialStatus += "<td> " + dtEDMDataStatus.Rows[i]["GROUP_"].ToString() + "</td> ";
                        strSpecialStatus += "<td> " + dtEDMDataStatus.Rows[i]["STM_LAST_BUSDATE"].ToString() + "</td> ";
                        strSpecialStatus += "<td> " + dtEDMDataStatus.Rows[i]["STM_START_TIME"].ToString() + "</td> ";
                        strSpecialStatus += "<td> " + dtEDMDataStatus.Rows[i]["STM_END_TIME"].ToString() + "</td> ";
                        strSpecialStatus += "<td><a href='" + this.CurrentUrlPort + "/espapp/param.aspx?id=" + dtEDMDataStatus.Rows[i]["ESP_APP"].ToString() + "'>" + dtEDMDataStatus.Rows[i]["ESP_APP"].ToString() + "</a></td> </tr>";
                    }
                    else
                    {
                        intDataStatus++;

                        strEDMStatus += "<tr> <td><button type='button' Class='button' Style='background-color:" + dtEDMDataStatus.Rows[i]["STM_STATUS_CR"].ToString() + ";' onclick=window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/solutionToFix.aspx?id=" + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "')></button></td>";
                        strEDMStatus += "<td><a href='" + this.CurrentUrlPort + "/EDMSTATUS/Default.aspx?id=" + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "'> " + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "</a></td> ";
                        strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["STREAM_NAME"].ToString() + "</td> ";
                        strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["GROUP_"].ToString() + "</td> ";
                        strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["STM_LAST_BUSDATE"].ToString() + "</td> ";
                        strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["STM_START_TIME"].ToString() + "</td> ";
                        strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["STM_END_TIME"].ToString() + "</td> ";
                        strEDMStatus += "<td><a href='" + this.CurrentUrlPort + "/espapp/param.aspx?id=" + dtEDMDataStatus.Rows[i]["ESP_APP"].ToString() + "'>" + dtEDMDataStatus.Rows[i]["ESP_APP"].ToString() + "</a></td> </tr>";

                        //strEDMStatus += "<tr><td> " + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["STREAM_KEY"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["STREAM_NAME"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["GROUP_"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["GROUP_"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["GROUP_"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["GROUP_"].ToString() + "</td> ";
                        //strEDMStatus += "<td> " + dtEDMDataStatus.Rows[i]["ESP_APP"].ToString() + "</td> </tr>";
                    }
                }
                //strEDMStatus += "\"; document.getElementById('dvEDMStatus').innerHTML +=(a); </script>";

                lt_GroupTable.Text = strEDMStatus;
                lt_GroupTableSpecial.Text = strSpecialStatus;

                if (intDataStatus > 0)
                {
                    iStatusCount.InnerHtml = intDataStatus.ToString();
                }
                else
                {
                    iStatusCount.InnerHtml = "";
                }

                if (intSpecialStatus > 0)
                {
                    iSpecialCount.InnerHtml = intSpecialStatus.ToString();
                }
                else
                {
                    iSpecialCount.InnerHtml = "";
                   
                }
            }
            catch (Exception ex)
            {
                MsgAlert = "Cannot get EDM data status, Bacause " + ex.Message.ToString();
                BindMessage("Alert", MsgAlert, 0);
                return;
            }


        }

    }
}