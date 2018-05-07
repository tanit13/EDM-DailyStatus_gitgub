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
using VLD.Class;

namespace EDM_DailyStatus
{
    public partial class Default : System.Web.UI.Page
    {        //OraManager omm = new OraManager();
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
            } else
            {
                this.CurrentUrlPort = "http://" + this.CurrentUrl;
            }

            //this.btn_GetStmKey.Attributes.Add("onclick", "javascript:" + btn_GetStmKey.ClientID + ".disabled=true;" + btn_GetStmKey.ClientID + ".value= 'Processing...';" + this.Page.GetPostBackEventReference(btn_GetStmKey));
            if (!IsPostBack)
            {
                CheckLogin();
                GetEDMStatus();
                //Render_Chart(lt_Chart);
            }
        }

        protected void lnk_Login_Click(object sender, EventArgs e)
        {
            ClearMessage();
            try
            {
                txt_User.Text = string.Empty;
                txt_Pass.Text = string.Empty;
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>$( document ).ready(function() { $('#myModalConfirmSub').modal('show')});</script>", false);
            }
            catch (Exception ex)
            {
                
            }
        }

        private void CheckLogin()
        {
            if (Request.Cookies["myCookie_Trackingsrc"] == null || Request.Cookies["myCookie_Trackingsrc"]["user"] == null || Request.Cookies["myCookie_Trackingsrc"]["pass"] == null)
            {

                lnk_Login.Visible = true;
                lnk_Logout.Visible = false;
                txt_User.Text = string.Empty;
                txt_Pass.Text = string.Empty;
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>$( document ).ready(function() { $('#myModalConfirmSub').modal('show')});</script>", false);

                return;
            }
            //txt_Stream.Focus();
            lnk_Login.Visible = false;
            lnk_Logout.Visible = true;

        }

        protected void lnk_Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            if (Request.Cookies["myCookie_Trackingsrc"] != null)
            {
                HttpCookie delCookieLogin;
                delCookieLogin = new HttpCookie("myCookie_Trackingsrc");
                delCookieLogin.Expires = DateTime.Now.AddDays(-1D);
                Response.Cookies.Add(delCookieLogin);

                Response.Redirect("Default.aspx");
            }
        }

        protected void btn_Confirm_Click(object sender, EventArgs e)
        {
            ClearMessage();
            try
            {
                if ((txt_User.Text != "") && (txt_Pass.Text != ""))
                {
                    HttpCookie newCookieLogin = new HttpCookie("myCookie_Trackingsrc");
                    newCookieLogin["user"] = txt_User.Text.Trim().ToUpper();
                    newCookieLogin["pass"] = txt_Pass.Text;
                    newCookieLogin.Expires = DateTime.Now.AddDays(7);
                    Response.Cookies.Add(newCookieLogin);
                    lnk_Logout.Visible = true;
                    lnk_Login.Visible = false;
                    //txt_Stream.Focus();
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    //btn_GetStmKey.Focus();
                }


            }
            catch (Exception ex)
            {
                MsgAlert = "Cannot submit, Because " + ex.Message.ToString();
                BindMessage("Alert", MsgAlert, 0);
                return;
            }
        }

        private DataTable GetEDMDailyStatus()
        {
            string myQuery = "SELECT GRP_NM, GRP_STATUS,GRP_DET_STATUS,GRP_STATUS_BSTP, TIER, CAST(CAST(MIN_DT AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)), CAST(CAST(MAX_DT AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)), GRP_STM_NUM, STM_UP2DT,SUPPORT_TEAM, ESP_APP, Percent_up2DT, GRP_MISS_SLA FROM DATALAB_OPER.PSS_GRP_ATTB_DAILY_4WEB ORDER BY GRP_NM";

            DataTable dt = new DataTable();
            tmm.TDUsername = Request.Cookies["myCookie_Trackingsrc"]["user"].ToString();
            tmm.TDPassword = Request.Cookies["myCookie_Trackingsrc"]["pass"].ToString();
            dt = tmm.GetDataTableTera(myQuery);
            return dt;
        }


        private string GetStremKeyError(string GRP_NM) {
            
            DataTable dt = new DataTable();
            string mySQL = " SELECT DISTINCT AUTO_LOG   FROM DATALAB_OPER.PSS_AUTOLOG_BY_GROUP_T1  WHERE GROUP_ = '" + GRP_NM +"' ";
            string str_streamkey = "";
            dt = tmm.GetDataTableTera(mySQL);            

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["AUTO_LOG"].ToString() != "") {
                    str_streamkey += dt.Rows[i]["AUTO_LOG"].ToString();
                    if (i < dt.Rows.Count - 1) {
                        str_streamkey += ",";
                    }
                    
                }
                
            }            

            return str_streamkey;
        }



        protected void GetEDMStatus()
        {
            ClearMessage();
            try
            {
                ///*************************************Get EDM Daily Status for Tier_1

                string str_streamkeyerror = "";

                string strEDMSTier1 = string.Empty;
                string strEDMSTier2 = string.Empty;
                string strEDMSTier3 = string.Empty;
                strEDMSTier1 += "<script> var a =\"";
                strEDMSTier2 += "<script> document.getElementById('dvTire2').innerHTML +=(" + '"' + "";
                strEDMSTier3 += "<script> document.getElementById('dvTire3').innerHTML +=(" + '"' + "";
                DataTable dtEDMDailyStatus = GetEDMDailyStatus();
                if (dtEDMDailyStatus.Rows.Count == 0)
                {
                    MsgAlert = "Not found EDM Status for Tire1 ";
                    BindMessage("Alert", MsgAlert, 0);
                    return;
                }

                for (int i = 0; i < dtEDMDailyStatus.Rows.Count; i++)
                {
                    //int gprStmNum = 0;
                    //int stmUpDate = 0;
                    //float PercenUpdate = 0;
                    //string PercenStmUpdate = string.Empty;

                    //gprStmNum = Int32.Parse(dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString());
                    //stmUpDate = Int32.Parse(dtEDMDailyStatus.Rows[i]["STM_UP2DT"].ToString());
                    //PercenUpdate = stmUpDate * 100 / gprStmNum;
                    //PercenStmUpdate = PercenUpdate.ToString();



                    if (dtEDMDailyStatus.Rows[i]["TIER"].ToString() == "TIER1")
                    {
                        //string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString().Split(' ')[0];
                        string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString().Replace(' ', '+');
                        //string KeywordID = Keyword.Split('_')[0];  //Oz Edit 20171213: To fix parameter group name 
                        string KeywordID = Keyword;
                        KeywordID = KeywordID + ".1";

                        if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "red")
                        {     

                            strEDMSTier1 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 50px; width: 85px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier1 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString();
                            strEDMSTier1 += "&#13;Error Log : " + GetStremKeyError(dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString());
                            strEDMSTier1 += "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            //strEDMSTier1 += "onclick =window.open('" + this.CurrentUrlPort + "/EDM-STATUS/StreamKey.aspx?id=" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "orange")
                        {
                            strEDMSTier1 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 50px; width: 85px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier1 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            //strEDMSTier1 += "onclick =window.open('http://localhost:54351/StreamKey.aspx?id=" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "gray")
                        {
                            strEDMSTier1 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 50px; width: 85px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier1 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            //strEDMSTier1 += "onclick =window.open('http://localhost:54351/StreamKey.aspx?id=" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else
                        {
                            strEDMSTier1 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 50px; width: 85px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier1 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            //strEDMSTier1 += "onclick =window.open('http://localhost:54351/StreamKey.aspx?id=" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString()== "MissSLA")
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier1 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
 

                        }
                    }
                    else if (dtEDMDailyStatus.Rows[i]["TIER"].ToString() == "TIER2")
                    {
                        string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString().Replace(" ", "_");
                        string KeywordID = Keyword + ".2";

                        if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "red")
                        {
                            strEDMSTier2 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier2 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "orange")
                        {

                            strEDMSTier2 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier2 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "gray")
                        {
                            strEDMSTier2 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier2 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else
                        {
                            strEDMSTier2 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier2 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier2 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                    }
                    else
                    {
                        string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString().Replace(" ", "_");
                        string KeywordID = Keyword + ".3";

                        if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "red")
                        {
                            strEDMSTier3 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier3 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "orange")
                        {
                            strEDMSTier3 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier3 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "gray")
                        {
                            strEDMSTier3 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier3 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                        else
                        {
                            strEDMSTier3 += "<button type='button' class='" + dtEDMDailyStatus.Rows[i]["GRP_STATUS_BSTP"].ToString() + "' style='height: 56px; width: 94px; margin-bottom:2px; padding-left: 0px; padding-right: 0px; font-weight: bold; font-size: 11px; white-space: normal;' ";
                            strEDMSTier3 += "title ='" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "&#13;Status: " + dtEDMDailyStatus.Rows[i]["GRP_DET_STATUS"].ToString() + "&#13;MIN  : " + dtEDMDailyStatus.Rows[i]["MIN_DT"].ToString() + "&#13;MAX : " + dtEDMDailyStatus.Rows[i]["MAX_DT"].ToString() + "&#13;Stream: " + dtEDMDailyStatus.Rows[i]["GRP_STM_NUM"].ToString() + "&#13;Percent: " + dtEDMDailyStatus.Rows[i]["Percent_up2DT"].ToString() + "% &#13;ESP APP: " + dtEDMDailyStatus.Rows[i]["ESP_APP"].ToString() + "&#13;Support Team: " + dtEDMDailyStatus.Rows[i]["SUPPORT_TEAM"].ToString() + "' ";
                            if (dtEDMDailyStatus.Rows[i]["GRP_MISS_SLA"].ToString() == "MissSLA")
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')><i class='fa fa-hourglass-half fa-1x' aria-hidden='true'></i><br>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                            else
                            {
                                strEDMSTier3 += "onclick =window.open(href='" + this.CurrentUrlPort + "/EDM-DailyStatus/StreamKey.aspx?id=" + KeywordID + "')>" + dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString() + "</button> ";
                            }
                        }
                    }
                }

                strEDMSTier1 += "\"; document.getElementById('dvTire1').innerHTML +=(a); </script>";
                strEDMSTier2 += "" + '"' + ") </script>";
                strEDMSTier3 += "" + '"' + ") </script>";

                // strEDMSTier1 += "<button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;' title='T1_BTMU&#13;MIN : 2017-06-27&#13;MAX : 2017-06-27&#13;Stream: 16&#13;Percent: 100%'onclick=\"window.open('http://www.plus2net.com/')\">T1_BTMU</button> <button type='button' class='btn-lg btn-warning' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_BANC</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_ATM</button> <button type='button' class='btn-lg btn-danger' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_CLS</button>";

                lt_Tier1.Text = strEDMSTier1;
                lt_Tier2.Text = strEDMSTier2;
                lt_Tier3.Text = strEDMSTier3;
                DateTime dt = DateTime.Now; // Or whatever
                string getDateTime = dt.ToString("dddd, d-MMM-yyyy hh:mm tt");
                lt_footer.Text = "EDM DAILY STATUS By (EIM)Production Support on " + getDateTime;


            }
            catch (Exception ex)
            {
                MsgAlert = "Cannot get EDM data status for Tire1, Bacause" + ex.Message.ToString();
                BindMessage("Alert", MsgAlert, 0);
                return;
            }
        }
    }
}