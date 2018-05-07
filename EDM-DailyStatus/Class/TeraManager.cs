using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Teradata.Client.Provider;
using System.Data;
using System.Configuration;
using System.Data.Odbc;

namespace TDR.Class
{
    public class TeraManager
    {
        OdbcConnection cn;
        OdbcCommand cmd;
        //string conOra = System.Configuration.ConfigurationManager.ConnectionStrings["connTera"].ConnectionString;
        //connTera_tier1

        //connTera
        public string TDUsername { set ; get; }
        public string TDPassword { set ; get; }

        


        public DataTable GetDataTableTera(string cmdQuery)
        {

            string connODBC = ConfigurationManager.AppSettings["connODBC"];

            //string conOra = "DSN=TeraData_7E020301;UID=EDW_UR_333229;PWD=BAY@201706";
             //string conOra = "DSN=" + connODBC + ";UID=" + TDUsername + ";PWD=" + TDPassword + "";
            //string conOra = "DSN=" + connODBC + ";UID=EDW_AU_PSSWEB"  + ";PWD=Krungsri@123"+ ""; // 2017-11-08 : P'A Edit

            

            //string conOra = "DSN=" + connODBC + ";UID=EDW_AU_PSSWEB" + ";PWD=Krungsri@123" + ""; // 2017-11-08 : P'A Edit
            string conOra = "DSN=" + connODBC+"";

            DataTable _dt = new DataTable();

            try
            {
                cn = new OdbcConnection(conOra);
                cmd = new OdbcCommand(cmdQuery, cn);
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
            finally {
                cn.Close();
            }

            

           
            return _dt;
        }
    }
}