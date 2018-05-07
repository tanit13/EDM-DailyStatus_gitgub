using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Odbc;
using System.Data;
using System.Configuration;

namespace ORA.Class
{

    public class OraManager
    {
        private OdbcConnection cn;
        private OdbcCommand cmd;
        private string conOra = System.Configuration.ConfigurationManager.ConnectionStrings["connOra"].ConnectionString;
        private string connEDW = System.Configuration.ConfigurationManager.ConnectionStrings["connOdbcEDW"].ConnectionString;
        
        public DataTable GetDataTableOra(string cmdQuery)
        {
            DataTable _dt = new DataTable();

            cn = new OdbcConnection(conOra);
            cmd = new OdbcCommand(cmdQuery, cn);
            cn.Open();

            using (OdbcDataAdapter da = new OdbcDataAdapter())
            {
                da.SelectCommand = cmd;
                da.Fill(_dt);
            }
            cn.Close();
            return _dt;
        }

        public DataTable GetDataEDW(string cmdQuery) {
            DataTable dt = new DataTable();
            try
            {
                cn = new OdbcConnection(connEDW);
                cmd = new OdbcCommand(cmdQuery, cn);
                cn.Open();

                using (OdbcDataAdapter da = new OdbcDataAdapter())
                {
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }
            finally {
                cn.Close();
            }           
            return dt;
        }

    }    
}