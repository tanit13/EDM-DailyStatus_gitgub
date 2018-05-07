using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormMain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        private string GetCurrentDate()
        {
            string str_current_date = "";
            DateTime dt = DateTime.Now; // Or whatever
            str_current_date = dt.ToString("dddd, d-MMM-yyyy hh:mm tt");
            //lt_footer.Text = "EDM DAILY STATUS By (EIM)Production Support on " + getDateTime;
            return str_current_date;


        }
    }
}