using EDM_DailyStatus.Class.data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TDR.Class;

namespace EDM_DailyStatus.Class.service
{
    public class LoggingDAO
    {

        public List<LoggingError> getLogErrorToday(string start_date ,string end_date) {

            List<LoggingError> lst_log_error = new List<LoggingError>();
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();

            try {
                string strQuery = string.Empty;
                strQuery = " select CAST(CAST(update_ts AS  TIMESTAMP(6)) AS VARCHAR(19)) as update_ts ";   
                strQuery += " ,stream_key ,process_name ,auto_analyze_log ,sys_log  ";
                strQuery += " FROM DATALAB_OPER.PSS_TODAY_ERROR_LOG ";
                strQuery += " where CAST(CAST(update_ts AS date FORMAT 'YYYY-MM-DD') AS VARCHAR(10)) between '" + start_date +"' and ";
                strQuery += " '" + end_date + "' ";
                strQuery += " order by update_ts desc ";

                dt = tmm.GetDataTableTera(strQuery);
                LoggingError logError;

                for (int i = 0; i < dt.Rows.Count; i++) {
                    logError = new LoggingError();
                    logError.Update_ts = dt.Rows[i]["update_ts"].ToString();
                    logError.Stream_key = dt.Rows[i]["stream_key"].ToString();
                    logError.Process_name = dt.Rows[i]["process_name"].ToString();
                    logError.Auto_analyze_log = dt.Rows[i]["auto_analyze_log"].ToString();
                    logError.Sys_log = dt.Rows[i]["sys_log"].ToString();

                    lst_log_error.Add(logError);
                }

            } catch (Exception e) {
                System.Console.WriteLine(e.Message.ToString());
            }
            

            return lst_log_error;

        }

    }
}