using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            bool dd = HttpContext.Current.User.Identity.IsAuthenticated;
            
            System.Diagnostics.Debug.WriteLine("user : " + HttpContext.Current.User.Identity.IsAuthenticated );
            Console.Out.Write("");

        }
    }
}