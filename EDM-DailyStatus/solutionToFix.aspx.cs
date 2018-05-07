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
    public partial class solutionToFix : System.Web.UI.Page
    {
        TeraManager tmm = new TeraManager();
        BoostrapEvent bte = new BoostrapEvent();


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
            if (!IsPostBack)
            {
                ClearMessage();

                try
                {

                    txt_errorJob.Text = Request.QueryString["id"].ToString();
                    //txt_StreamName.Text = "CES";
                    //GetJobDepen(Request.QueryString["id"].ToString());
                    //GetEDMDataforTable();
                    //DataTable dtViz = GetEDMStatus(txt_StreamName.Text.ToString());
                    //GV_Test.DataSource = dtViz;
                    //GV_Test.DataBind();
                }
                catch
                (Exception ex)
                {
                    MsgAlert = "Cannot get data: " + txt_errorJob.Text.Trim().ToUpper() + ", Bacause" + ex.Message.ToString();
                    BindMessage("Alert", MsgAlert, 0);
                    return;
                }
            }
        }
    }
}