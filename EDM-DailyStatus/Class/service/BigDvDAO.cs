using EDM_DailyStatus.Class.data;
using ORA.Class;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.service
{
    public class BigDvDAO
    {
        
        public List<List<BigMonitor>> getDataBigMonitor()
        {
            List<BigMonitor> lstBigMoni = new List<BigMonitor>();
            List<BigMonitor> lstBigComple = new List<BigMonitor>();
            List<BigMonitor> lstBigError = new List<BigMonitor>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            BigMonitor obj_bigMoni;

            List<List<BigMonitor>> lstObj = new List<List<BigMonitor>>();

            try
            {
                string strQuery = string.Empty;
                strQuery = " select status ,work_name , first_supportor_id  ";
                strQuery += " ,sla ,process_no ,process_id ,frequency ";
                strQuery += " ,business_date ,process_start_ts ,process_end_ts ";
                strQuery += " from ops.monitor_big ";

                dt = oraManager.GetDataBigData(strQuery);

                for (int i=0;i<dt.Rows.Count; i++) {
                    obj_bigMoni = new BigMonitor();                    
                    obj_bigMoni.Status = dt.Rows[i]["status"].ToString();
                    obj_bigMoni.Work_name = dt.Rows[i]["work_name"].ToString();
                    obj_bigMoni.First_supportor_id = dt.Rows[i]["first_supportor_id"].ToString();
                    obj_bigMoni.Sla = dt.Rows[i]["sla"].ToString();
                    obj_bigMoni.Process_no = dt.Rows[i]["process_no"].ToString();
                    obj_bigMoni.Process_id = dt.Rows[i]["process_id"].ToString();
                    obj_bigMoni.Frequency = dt.Rows[i]["frequency"].ToString();
                    obj_bigMoni.Business_date = dt.Rows[i]["business_date"].ToString();
                    obj_bigMoni.Process_start_ts = dt.Rows[i]["process_start_ts"].ToString();
                    obj_bigMoni.Process_end_ts = dt.Rows[i]["process_end_ts"].ToString();

                    lstBigMoni.Add(obj_bigMoni);

                    if (dt.Rows[i]["status"].ToString() == "COMPLETE") {
                        lstBigComple.Add(obj_bigMoni);

                    } else if (dt.Rows[i]["status"].ToString() == "ERROR") {
                        lstBigError.Add(obj_bigMoni);
                    }
                    else { }
                }

                lstObj.Add(lstBigMoni);
                lstObj.Add(lstBigComple);
                lstObj.Add(lstBigError);


            }
            catch (Exception e){
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lstObj;
        }

        public List<List<DvMonitor>> getDataDvMonitor()
        {
            List<DvMonitor> lstDvMoni = new List<DvMonitor>();
            List<DvMonitor> lstDvComple = new List<DvMonitor>();
            List<DvMonitor> lstDvError = new List<DvMonitor>();
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            DvMonitor obj_dvMoni;

            List<List<DvMonitor>> lstObj = new List<List<DvMonitor>>();

            try
            {
                string strQuery = string.Empty;
                strQuery = " select status ,work_name , sla  ";
                strQuery += " ,frequency ,asofdate ,process_start_ts ,process_end_ts ";                
                strQuery += " from ops.monitor_dv ";

                dt = oraManager.GetDataBigData(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_dvMoni = new DvMonitor();
                    obj_dvMoni.Status = dt.Rows[i]["status"].ToString();
                    obj_dvMoni.Work_name = dt.Rows[i]["work_name"].ToString();
                    obj_dvMoni.Sla = dt.Rows[i]["sla"].ToString();
                    obj_dvMoni.Frequency = dt.Rows[i]["frequency"].ToString();
                    obj_dvMoni.Asofdate = dt.Rows[i]["asofdate"].ToString();
                    obj_dvMoni.Process_start_ts = dt.Rows[i]["process_start_ts"].ToString();
                    obj_dvMoni.Process_end_ts = dt.Rows[i]["process_end_ts"].ToString();
                   

                    lstDvMoni.Add(obj_dvMoni);

                    if (dt.Rows[i]["status"].ToString() == "COMPLETE")
                    {
                        lstDvComple.Add(obj_dvMoni);

                    }
                    else if (dt.Rows[i]["status"].ToString() == "ERROR")
                    {
                        lstDvError.Add(obj_dvMoni);
                    }
                    else { }
                }

                lstObj.Add(lstDvMoni);
                lstObj.Add(lstDvComple);
                lstObj.Add(lstDvError);


            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }


            return lstObj;
        }

        public List<BigDvStatus> getDataBigDvStatus()
        {
            List<BigDvStatus> lstBigDv = new List<BigDvStatus>();
          
            OraManager oraManager = new OraManager();
            DataTable dt = new DataTable();
            BigDvStatus obj_bigdv;            

            try
            {
                string strQuery = string.Empty;
                strQuery = " select work_name , batch_name  ,pg ";
                strQuery += " ,completed ,failed ,total ";
                strQuery += " from ops.monitor_status ";
                
                dt = oraManager.GetDataBigData(strQuery);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    obj_bigdv = new BigDvStatus();
                    obj_bigdv.Work_name = dt.Rows[i]["work_name"].ToString();
                    obj_bigdv.Batch_name = dt.Rows[i]["batch_name"].ToString();
                    obj_bigdv.Pg = dt.Rows[i]["pg"].ToString();
                    obj_bigdv.Completed = dt.Rows[i]["completed"].ToString();
                    obj_bigdv.Failed = dt.Rows[i]["failed"].ToString();
                    obj_bigdv.Total = dt.Rows[i]["total"].ToString();
                    lstBigDv.Add(obj_bigdv);
                }
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message.ToString());
            }
            return lstBigDv;
        }

    }
}
