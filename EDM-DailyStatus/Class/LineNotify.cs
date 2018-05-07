
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;

namespace EDM_DailyStatus.Class
{
    public class LineNotify
    {
      

        public static void Main() {

            string conOra = "DSN=";
            DataTable _dt = new DataTable();

            OdbcConnection cn = null;
            OdbcCommand cmd;

            try
            {
                cn = new OdbcConnection(conOra);
                cmd = new OdbcCommand(conOra, cn);
                cn.Open();

                using (OdbcDataAdapter da = new OdbcDataAdapter())
                {
                    da.SelectCommand = cmd;
                    da.Fill(_dt);
                }




            }
            catch (Exception e)
            {
                System.Console.Out.WriteLine(e.Message.ToString());
            }
            finally
            {
                cn.Close();
            }






        }


        public void getMessage() {
            string str_msg = "";
            DataTable dt = new DataTable();

            //dt = GetDataTableTera("");

            //for (int i = 0; i < dt.Rows.Count; i++)
            //{

            //}



            //    return str_msg;

        }

        private DataTable GetDataTableTera(string cmdQuery)
        {                    
            string conOra = "DSN=";
            DataTable _dt = new DataTable();           
            try
            {
                //cn = new OdbcConnection(conOra);
                //cmd = new OdbcCommand(cmdQuery, cn);
                //cn.Open();

                //using (OdbcDataAdapter da = new OdbcDataAdapter())
                //{
                //    da.SelectCommand = cmd;
                //    da.Fill(_dt);
                //}
            }
            catch (Exception e)
            {
                System.Console.Out.WriteLine(e.Message.ToString());
            }
            finally
            {
                //cn.Close();
            }



            return _dt;
        }

    }
}