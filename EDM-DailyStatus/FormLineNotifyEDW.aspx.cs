using LineNotify_new;
using ORA.Class;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormLineNotifyEDW : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            string str_data = "";
            string str_sent = "";
            try
            {
                string strQuery = string.Empty;
                strQuery = " select text_ from line_notify_edw ";

                dt = oraManager.GetDataEDW(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    str_data += dt.Rows[i]["text_"].ToString();
                }

                str_sent = str_data.Replace("\\n", "\n");


                /* -------- sent line notiry ------------ */
                LineNotify lineNoti = new LineNotify();   //Bearer mKbIfvmrq75c8Ljz3Ipuhn96LUfgdvP8wy0JmqkibXR  -- key test

                //if (lineNoti.SendMessage("Bearer MYM1A0qV571lAYW5ea41SbtUpodZNCyny4ayV9aiqET", "\n" + str_sent))   -- key edw
                    if (lineNoti.SendMessage("Bearer mKbIfvmrq75c8Ljz3Ipuhn96LUfgdvP8wy0JmqkibXR", "\n" + str_sent))
                    {
                    Console.Out.WriteLine("sent line notify success..." + lineNoti.LineError);
                }
                else
                {

                    Console.Out.WriteLine("sent line notify failed..." + lineNoti.LineError);
                }

            }
            catch (Exception ex) {
                Console.Out.WriteLine(ex.Message.ToString());
            }
        }
    }
}