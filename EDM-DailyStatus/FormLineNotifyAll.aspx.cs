using EDM_DailyStatus.Class.data;
using LineNotify_new;
using Newtonsoft.Json;
using ORA.Class;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDM_DailyStatus
{
    public partial class FormLineNotifyAll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<ConfigLineNotify> data = new List<ConfigLineNotify>();
            data = dataJson();
            string str_msg = "";
            string str_time = getCurHour();
            writeLog("start send line time ::: " + str_time + ":::");
            List<string> lst_str;
            

            //str_time = "-0";
            string[] str_hour_send;

            //-- test send more 1000 text ---
            List<string> lst_msg ;

            for (int i = 0; i < data.Count; i++) {

                if (data[i].Status == "enable") { 
               
                    str_hour_send = data[i].Hour_of_send.Split(',');
                    for (int t = 0;t < str_hour_send.Length; t++)
                    {
                        if((str_time == str_hour_send[t]) || (str_hour_send[t] == "test")) {
                            writeLog("send notify group == " + data[i].Group_name);

                            //-- send 1 msg ----------
                            //str_msg = getDataSend(data[i].Odbc_name, data[i].Query);
                            //sendLine(data[i].Token, str_msg);

                            //-- test send more 1000 text ---
                            lst_msg = new List<string>();
                            lst_msg = getDataSendWithCountText(data[i].Odbc_name, data[i].Query);
                            sendLineMore1000Text(data[i].Token, lst_msg);

                        }
                    }
                }

            }

        }

        public List<ConfigLineNotify> dataJson()
        {
            List<ConfigLineNotify> items = new List<ConfigLineNotify>();
            string pathConfig = System.Configuration.ConfigurationManager.AppSettings["pahtConfigLineNotify"];            
            using (StreamReader r = new StreamReader(pathConfig))
            {
                string json = r.ReadToEnd();
                items = JsonConvert.DeserializeObject<List<ConfigLineNotify>>(json);

                Console.WriteLine("");
            }
            return items;
        }

        public string getCurHour() {
           // string str_time = "";
            DateTime dt = DateTime.Now; // Or whatever
            //string s = dt.ToString("yyyyMMddHHmmss");
            return dt.ToString("HH") + dt.ToString("mm");            
        }

        public string getDataSend(string odbcName ,string cmdQuery) {

            List<string> lst_msg = new List<string>();

            string str_data ="" ;
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            int txtcount = 0;
            try {

                dt = oraManager.GetDataByODBC(odbcName,cmdQuery);
                for (int i=0; i < dt.Rows.Count;i++) {
                    //lst_msg.Add("");
                    //lst_msg.Add("");

                    str_data += dt.Rows[i][0].ToString();
                }
            }
            catch (Exception e) {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return str_data;
        }

        public void sendLine(string token, string msg) {
            LineNotify lineNoti = new LineNotify();
            string str_send = msg.Replace("\\n", "\n");
            writeLog("msg ==" + str_send);           

            if (lineNoti.SendMessage(token, "\n" + str_send))
            {
                writeLog("sent line notify success...\r\n");
                Console.Out.WriteLine("sent line notify success..." + lineNoti.LineError);
            }
            else
            {
                writeLog("sent line notify failed...");
                Console.Out.WriteLine("sent line notify failed...\r\n" + lineNoti.LineError);

                reSendLine(token, msg);

            }
        }

        public void reSendLine(string token ,string msg) {
            LineNotify lineNoti = new LineNotify();
            string str_send = msg.Replace("\\n", "\n");

            writeLog(" \r\n --------- re send line ------------- \r\n");
            writeLog("msg ==" + str_send);

            if (lineNoti.SendMessage(token, "\n" + str_send))
            {
                writeLog("-- re sent line notify success...\r\n");
                Console.Out.WriteLine("sent line notify success..." + lineNoti.LineError);
            }
            else
            {
                writeLog("-- re sent line notify failed...");
                Console.Out.WriteLine("sent line notify failed...\r\n" + lineNoti.LineError);

            }

        }

        private void writeLog(string log) {
           
            DateTime dt = DateTime.Now;   
            string str_format_date = dt.ToString("d/M/yyyy HH:mm:ss");
            string pathLog = System.Configuration.ConfigurationManager.AppSettings["pahtLog"];

            File.AppendAllText(pathLog, "\r\n" + str_format_date + "  " +  log);
            Console.WriteLine("");

        }

        private void checkMsgCount(string msg) {
            List<string> lst = new List<string>();
            string str_msg_1 = "";
            if (msg.Length > 1000) {
                lst.Add(msg.Substring(0, 1000));
                lst.Add(msg.Substring(1000));
                Console.WriteLine("ddd");
            }
            else
            {
                lst.Add(msg);
                Console.WriteLine("ddd");
            }

        }

        private List<string> subMsg1000(string msg) {
            List<string> lst_str = new List<string>();
            
            
            if (msg.Length > 1000)
            {
                lst_str.Add(msg.Substring(0, 1000));
                lst_str.Add(msg.Substring(1001));
            }
            else {
                lst_str.Add(msg);
            }

            Console.Write("ddd");

            return lst_str;
        }

        public List<string> getDataSendWithCountText(string odbcName, string cmdQuery)
        {
            List<string> lst_msg = new List<string>();

            string str_data = "";
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            int txtcount = 0;
            try
            {

                dt = oraManager.GetDataByODBC(odbcName, cmdQuery);
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    txtcount = txtcount + dt.Rows[i][0].ToString().Length;

                    if (txtcount < 1000)
                    {
                        str_data += dt.Rows[i][0].ToString();
                    }
                    else {
                        lst_msg.Add(str_data);
                        str_data = dt.Rows[i][0].ToString();
                        txtcount = dt.Rows[i][0].ToString().Length;
                    }
                }
                lst_msg.Add(str_data);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lst_msg;
        }


        public void sendLineMore1000Text(string token, List<string> msg)
        {
            LineNotify lineNoti = new LineNotify();

            for (int i = 0; i < msg.Count; i++) {

                string str_send = msg[i].Replace("\\n", "\n");
                writeLog("msg ==" + str_send);

                if (lineNoti.SendMessage(token, "\n" + str_send))
                {
                    writeLog("sent line notify success...\r\n");
                    Console.Out.WriteLine("sent line notify success..." + lineNoti.LineError);
                }
                else
                {
                    writeLog("sent line notify failed...");
                    Console.Out.WriteLine("sent line notify failed...\r\n" + lineNoti.LineError);

                    reSendLine(token, msg[i]);

                }

            }


        }


    }
}
