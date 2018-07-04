using EDM_DailyStatus.Class.data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using TDR.Class;

namespace EDM_DailyStatus.Class.service
{
    public class GroupDAO
    {
        public List<Group> getGroupSummary() {
            List<Group> lst_group = new List<Group>();
            TeraManager tmm = new TeraManager();
            DataTable dt = new DataTable();
            

            try {
                string strQuery = string.Empty;
                strQuery = " select group_ ,completed ,running ,failed ,notstarted ,total  ,excep ";
                strQuery += " FROM DATALAB_OPER.pss_report_sumary_status_grp_src_01 order by failed desc , group_ ";

                dt = tmm.GetDataTableTera(strQuery);
                Group obj_group;


                for (int i=0; i<dt.Rows.Count; i++)
                {
                    obj_group = new Group();

                    obj_group.Group_name = dt.Rows[i]["group_"].ToString();
                    obj_group.Completed = Convert.ToInt16(dt.Rows[i]["completed"].ToString());
                    obj_group.Running = Convert.ToInt16(dt.Rows[i]["running"].ToString());
                    obj_group.Failed = Convert.ToInt16(dt.Rows[i]["failed"].ToString());
                    obj_group.Notstart = Convert.ToInt16(dt.Rows[i]["notstarted"].ToString());
                    obj_group.Except = Convert.ToInt16(dt.Rows[i]["excep"].ToString());
                    obj_group.Total = Convert.ToInt16(dt.Rows[i]["total"].ToString());

                    lst_group.Add(obj_group);
                }
            }
            catch (Exception e) {
                Console.WriteLine(e.Message.ToString());
            }
            return lst_group;
        }
    }
}