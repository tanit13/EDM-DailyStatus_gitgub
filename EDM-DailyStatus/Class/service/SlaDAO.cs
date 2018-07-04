using EDM_DailyStatus.Class.data;
using System;
using System.Collections.Generic;
using System.Data;

using TDR.Class;

namespace EDM_DailyStatus.Class.service
{
    public class SlaDAO
    {
        public List<Sla> summarySlaEDM() {
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            List<Sla> lst = new List<Sla>();
            Sla sla;

            try {
                string strQuery = string.Empty;
                strQuery = " select meet ,miss ,meet_p , miss_p ,completed ";
                strQuery += " from DATALAB_OPER.pss_report_sumary_prj_stm_01 ";
                strQuery += " where project='' and tier ='TIER1' ";

                dt = tmm.GetDataTableTera(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++) {
                    sla = new Sla();
                    sla.Meet = Int16.Parse(dt.Rows[i]["meet"].ToString());
                    sla.Miss = Int16.Parse(dt.Rows[i]["miss"].ToString());
                    sla.Meet_p = Int16.Parse(dt.Rows[i]["meet_p"].ToString());
                    sla.Miss_p = Int16.Parse(dt.Rows[i]["miss_p"].ToString());
                    sla.Completed = Int16.Parse(dt.Rows[i]["completed"].ToString());
                    lst.Add(sla);
                }
            }
            catch (Exception e) {
                Console.Out.WriteLine(e.Message.ToString());
            }

            return lst;
        }
    }
}