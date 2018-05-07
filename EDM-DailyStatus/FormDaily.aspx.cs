using BTE.Class;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TDR.Class;

namespace EDM_DailyStatus
{
    public partial class FormDaily : System.Web.UI.Page
    {
        TeraManager tmm = new TeraManager();
        BoostrapEvent bte = new BoostrapEvent();

        protected void Page_Load(object sender, EventArgs e)
        {
            GetEDMStatus();
        }

        private DataTable GetEDMCycleStatus(String cycle)
        {
            string myQuery = "SELECT GRP_NM, GRP_STATUS,GRP_DET_STATUS,GRP_STATUS_BSTP, TIER" +
                ", CAST(CAST(MIN_DT AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15))" +
                ", CAST(CAST(MAX_DT AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15))" +
                ", GRP_STM_NUM, STM_UP2DT,SUPPORT_TEAM, ESP_APP, Percent_up2DT" +
                ", GRP_MISS_SLA " +
                "FROM DATALAB_OPER.PSS_GRP_ATTB_DAILY_4WEB " +
                " WHERE TIER = 'TIER1' "+
                " AND CYCLE_FREQ='" + cycle +"'"+
                "ORDER BY GRP_NM";

            DataTable dt = new DataTable();
            tmm.TDUsername = Request.Cookies["myCookie_Trackingsrc"]["user"].ToString();
            tmm.TDPassword = Request.Cookies["myCookie_Trackingsrc"]["pass"].ToString();
            dt = tmm.GetDataTableTera(myQuery);
            return dt;
        }

        protected void GetEDMStatus()
        {
            
            try
            {
                ///*************************************Get EDM Daily Status for Tier_1

                string strEDMSTier1 = string.Empty;
                string strEDMSTier2 = string.Empty;
                string strEDMSTier3 = string.Empty;
             //   strEDMSTier1 += "<script> var a =\"";
               // strEDMSTier2 += "<script> document.getElementById('dvTire2').innerHTML +=(" + '"' + "";
                //strEDMSTier3 += "<script> document.getElementById('dvTire3').innerHTML +=(" + '"' + "";
                DataTable dtEDMDailyStatus = GetEDMCycleStatus("DAILY");


                int cntFailed = 0;
                

                for (int i = 0; i < dtEDMDailyStatus.Rows.Count; i++)
                { 
                    if (dtEDMDailyStatus.Rows[i]["TIER"].ToString() == "TIER1")
                    {
                        //string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString().Split(' ')[0];
                        //string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString().Replace(' ', '+');

                        string Keyword = dtEDMDailyStatus.Rows[i]["GRP_NM"].ToString();

                        //string KeywordID = Keyword.Split('_')[0];  //Oz Edit 20171213: To fix parameter group name 
                        string KeywordID = Keyword;
                        KeywordID = KeywordID + ".1";

                        if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "red")
                        {
                            strEDMSTier1 += "<button type='button' class='btn btn-danger col-lg-2 mb-1 proA proAll'>" + Keyword + "</button> \n";
                            strEDMSTier3 += "<button type='button' class='btn btn-danger col-lg-2 mb-1 proA proAll'>" + Keyword + "</button> \n";
                            cntFailed++;
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "yellow")
                        {
                            strEDMSTier1 += "<button type='button' class='btn btn-warning col-lg-2 mb-1 proB proAll'>" + Keyword + "</button>\n";
                        }
                        else if (dtEDMDailyStatus.Rows[i]["GRP_STATUS"].ToString() == "gray")
                        {
                            strEDMSTier1 += "<button type='button' class='btn btn-secondary col-lg-2 mb-1 proC proAll'>" + Keyword + "</button>\n";
                        }
                        else
                        {
                            strEDMSTier1 += "<button type='button' class='btn btn-success col-lg-2 mb-1 proD proAll'>" + Keyword + "</button>\n";
                        }
                    } 
                    
             
                }

               // strEDMSTier1 += "\"; document.getElementById('dvTire1').innerHTML +=(a); </script>";
                //strEDMSTier2 += "" + '"' + ") </script>";
                //strEDMSTier3 += "" + '"' + ") </script>";

                // strEDMSTier1 += "<button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;' title='T1_BTMU&#13;MIN : 2017-06-27&#13;MAX : 2017-06-27&#13;Stream: 16&#13;Percent: 100%'onclick=\"window.open('http://www.plus2net.com/')\">T1_BTMU</button> <button type='button' class='btn-lg btn-warning' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_BANC</button> <button type='button' class='btn-lg btn-success' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_ATM</button> <button type='button' class='btn-lg btn-danger' style='height: 50px; width: 109px; margin-top:2px; padding-left: 0px; padding-right: 0px;'>T1_CLS</button>";

                
                lt_Tier1.Text = strEDMSTier1;
             //   lt_Tier3.Text = strEDMSTier3;
             //   cntDayFailed.InnerText = cntFailed.ToString();

                DateTime dt = DateTime.Now; // Or whatever
                string getDateTime = dt.ToString("dddd, d-MMM-yyyy hh:mm tt");
                //lt_footer.Text = "EDM DAILY STATUS By (EIM)Production Support on " + getDateTime;


            }
            catch (Exception ex)
            {
                //MsgAlert = "Cannot get EDM data status for Tire1, Bacause" + ex.Message.ToString();
                //BindMessage("Alert", MsgAlert, 0);
                
                return;
            }
        }
    }
}