using EDM_DailyStatus.Class.network;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormSSH : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //192.168.33.108 dsadm/g=up'.s,j
            // string str_command = "cd /edmftu/edmprod/src_dir/sc/daily/ ; ";
            // str_command += "awk -F '!' '{print NF}' SC_USER_AS_EMPLOYEE_2018-02-11_000000.000000.dat| sort -u";


            string str_result = "";
            ClientSSH client = new ClientSSH();
            string str_command = "cd /home/dsadm ;";
            str_command += " mkdir test ;";
            str_command += "cd test ;";
            str_command += " touch test.txt ;";
            str_command += "ls -l ";

            str_result = client.sentSshCommand("192.168.33.108", "dsadm", "g=up'.s,j", str_command);
            lt_show_ssh_result.Text = str_result;

        }


    }
}