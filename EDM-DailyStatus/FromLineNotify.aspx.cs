using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LineNotify_new;
using System.Text;

namespace EDM_DailyStatus
{
    public partial class FromLineNotify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StreamDAO Stream = new StreamDAO();
            LineNotify lineNoti = new LineNotify();
            StringBuilder str_ = new StringBuilder();
            StringBuilder str_sent = new StringBuilder();


            str_ = Stream.getStreamLineNotify();
          //  str_ = str_ == "" ? "ไม่พบข้อมูล" : str_;
            
            Console.Out.WriteLine("start sent line notify");
            str_sent = str_.Replace("\\n", "\n");

            string test = str_sent.ToString();
            Console.Out.WriteLine("size == " + test.Length);
            string str_token = "Bearer MY0LqXiDDGUhdveI7WvFsIEXSAQNUXfucVX3VMuXGGq ----";

           
            Console.Out.WriteLine(test.Length);
            //   if (lineNoti.SendMessage("Bearer MYM1A0qV571lAYW5ea41SbtUpodZNCyny4ayV9aiqET", "\n" + msg))
            if (lineNoti.SendMessage(str_token, "\n" + str_sent.ToString()))         
            {
                Console.Out.WriteLine("sent line notify success..." + lineNoti.LineError);
            }
            else {

                Console.Out.WriteLine("sent line notify failed..." + lineNoti.LineError);
            }



        }
    }
}