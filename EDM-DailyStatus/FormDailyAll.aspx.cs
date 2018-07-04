using BTE.Class;
using EDM_DailyStatus.Class.data;
using EDM_DailyStatus.Class.service;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TDR.Class;


namespace EDM_DailyStatus
{
    public partial class FormDailyAll : System.Web.UI.Page
    {
        TeraManager tmm = new TeraManager();
        BoostrapEvent bte = new BoostrapEvent();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            
            System.Console.Out.Write("");
            //Thread t1 = new Thread(new ThreadStart(GetEDMProject));
 
            //get_PSS_TODAY_ERROR_LOG();

            GetEDMProject();
            
            lt_tier_daily.Text = GetEDMGroup("DAILY");
            //lt_tier_monthly.Text = GetEDMGroup("MONTHLY");
            cur_date.InnerText = GetCurrentDate();

            //-- table group summary ---
            lt_tbl_sum_group.Text = getGroupSum().ToString();

            //-- int data to group helthly --
            SetValueHeltly("");

            //-- int data sum sla project
            lt_table_sum_sla_project.Text = GetSumSLAProject().ToString();
            System.Console.Out.Write("");

        }
       
        public void SetValueHeltly(string group)
        {
            
            lt_table_alert.Text = GetAlertLog().ToString();
            //lt_table_tab_all.Text = GetStream("ALL", "TIER1", "ALL").ToString();
            //lt_table_tab_finish.Text = GetStream("ALL", "TIER1", "'btn btn-success'").ToString();
            //lt_table_tab_process.Text = GetStream("ALL", "TIER1", "'btn btn-warning'").ToString();
            //lt_table_tab_failed.Text = GetStream("ALL", "TIER1", "'btn btn-danger'").ToString();
            //lt_table_tab_notstart.Text = GetStream("ALL", "TIER1", "'btn'").ToString();
            //lt_table_tab_exception.Text = GetStream("ALL", "TIER1", "EXCEPTION").ToString();

            /* get all status in one query. Display to table page */
            GetStrem();
            
            
        }

        protected void GetEDMProject()
        {
            string str_select_project = string.Empty;
            DataTable dt_project = new DataTable();
            string str_project = "";
            try
            {
                //string myQuery = " select DISTINCT PROJECT FROM  DATALAB_OPER.PSS_GRP_ATTB_DAILY_4WEB_R2  WHERE  TIER = 'TIER1' AND PROJECT IS NOT NULL AND PROJECT <> ''  ORDER BY 1 ";

                string myQuery = " SELECT PROJECT FROM DATALAB_OPER.PSS_FOCUS_SLA_PROJECT GROUP BY PROJECT ";

                DataTable dt = new DataTable();
                // tmm.TDUsername = Request.Cookies["myCookie_Trackingsrc"]["user"].ToString();
                // tmm.TDPassword = Request.Cookies["myCookie_Trackingsrc"]["pass"].ToString();
                dt = tmm.GetDataTableTera(myQuery);

                int a = 1;

                for (int i = 0; dt.Rows.Count > i; i++)
                {
                    str_project = dt.Rows[i]["PROJECT"].ToString();
                    str_select_project += " <option value=" + str_project + ">" + str_project + "</option> \n ";
                }
                lt_select_project.Text = str_select_project;
            }
            catch(Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }
        }

        private string GetEDMGroup(string cycle)
        {

            string str_btn_group = string.Empty;

            string str_project = "";
            string str_group = "";
            string str_group_chk_prj = "";
            string str_color = "";

            try
            {
                string myQuery = " select PROJECT , GRP_NM , GRP_STATUS_BSTP  FROM  DATALAB_OPER.PSS_GRP_ATTB_DAILY_4WEB_R2  WHERE  TIER = 'TIER1' " +
                    "AND THE1STROW = 1 AND GRP_NM not like 'NoPrc%' AND CYCLE_FREQ ='" + cycle + "' order by GRP_NM ASC ";

                DataTable dt = new DataTable();
                //tmm.TDUsername = Request.Cookies["myCookie_Trackingsrc"]["user"].ToString();
                //tmm.TDPassword = Request.Cookies["myCookie_Trackingsrc"]["pass"].ToString();
                dt = tmm.GetDataTableTera(myQuery);

                for (int i = 0; dt.Rows.Count >= i; i++)
                {
                    str_project = dt.Rows[i]["PROJECT"].ToString();

                    if (str_project == "") { str_project = "proAll"; }

                    str_group = dt.Rows[i]["GRP_NM"].ToString();
                    str_color = dt.Rows[i]["GRP_STATUS_BSTP"].ToString();

                    if (str_color == "btn btn-success")
                    {
                        str_btn_group += " <button type = 'button' class=' allobj  " + str_color + " btn-sm rounded-0 btn-custom mb-1 " + str_project + " '>" + str_group + "</button> \n ";
                    }
                    else
                    {
                        if (str_project == "proAll")
                        {
                            str_btn_group += " <button type = 'button' class=' allobj " + str_color + " btn-sm rounded-0 btn-custom mb-1 " + str_project + " notwork'>" + str_group + "</button> \n ";
                        }
                        else {
                            str_btn_group += " <button type = 'button' class=' allobj " + str_color + " btn-sm rounded-0 btn-custom mb-1 " + str_project + " '>" + str_group + "</button> \n ";
                        }                        
                    }                    
                }
                Console.Out.WriteLine("for debug");
            }          

            catch(Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }
            return str_btn_group;
        }

        private StringBuilder GetAlertLog()
        {


            string str_sql = " SELECT STREAM_KEY ,STREAM_NAME ,AUTO_LOG  FROM DATALAB_OPER.PSS_AUTOLOG_BY_GROUP_T1 ORDER BY STREAM_NAME ";

            string str_stream_key = "";
            string str_name = "";
            string str_auto_log = "";
            StringBuilder strBldrContent = new StringBuilder();


            try
            {
                DataTable dt = new DataTable();
                dt = tmm.GetDataTableTera(str_sql);
                //cnt_row = dt.Rows.Count;
                bdg_alert.InnerText = dt.Rows.Count.ToString();
                string str_stream_key_info ;
                for (int i = 0; dt.Rows.Count > i; i++)
                {

                    str_stream_key = dt.Rows[i]["STREAM_KEY"].ToString();
                    str_name = dt.Rows[i]["STREAM_NAME"].ToString();
                    str_auto_log = dt.Rows[i]["AUTO_LOG"].ToString();

                    str_stream_key_info = str_stream_key;
                    str_stream_key_info += " <a class='fa fa-info-circle text-info menu-links' onclick='streamInfo(" + str_stream_key + ")'></a>";

                    strBldrContent.Append("<tr>");
                    strBldrContent.Append("<td><button type = 'button' Class = 'button_status' Style = 'background-color:#dc3545;' ></button></td >");
                    strBldrContent.Append("<td>").Append(str_stream_key_info).Append("</td>");
                    strBldrContent.Append("<td>").Append(str_name).Append("</td>");
                    strBldrContent.Append("<td>").Append(str_auto_log).Append("</td>");
                    strBldrContent.Append("</tr>");

                }
            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message.ToString());
            }
            return strBldrContent;

        }

        private string GetCurrentDate()
        {
            string str_current_date = "";
            DateTime dt = DateTime.Now; // Or whatever
            str_current_date = dt.ToString("dddd, d-MMM-yyyy hh:mm tt");            
            return str_current_date;
        }

        private StringBuilder GetStream(string strSourceName, string tierID, string status)
        {
            string strQuery = string.Empty;
            StringBuilder str_bl = new StringBuilder();

            strQuery += " SELECT STM_STATUS_CR, STM_EXCEPTION_FLG, STREAM_KEY, STREAM_NAME, GROUP_";
            strQuery += ", CAST(CAST(STM_LAST_BUSDATE AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) ";
            //strQuery += ",CAST(CAST(STM_START_TIME AS DATE FORMAT 'YYYY-MM-DD HH:MM:SS') AS VARCHAR(15))";
            strQuery += " ,CAST(CAST(STM_START_TIME AS  TIMESTAMP(6)) AS VARCHAR(19))";
            //strQuery += ",CAST(CAST(STM_END_TIME AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15))";
            strQuery += " ,CAST(CAST(STM_END_TIME AS  TIMESTAMP(6)) AS VARCHAR(19))";
            strQuery += " FROM DATALAB_OPER.pss_report_detail_status_prj_stm_01 ";
            strQuery += " WHERE TIER = '" + tierID.ToString().Trim() + "' ";
            strQuery += " AND GROUP_ not like 'NoPrc%' ";

            if (status.Equals("EXCEPTION")) {
                strQuery += " AND STM_EXCEPTION_FLG IS NOT NULL ";
            } else { 
                strQuery += " AND STM_EXCEPTION_FLG IS NULL ";
            }

            if (!strSourceName.Equals("ALL"))
            {
                strQuery += " AND GROUP_ = '" + strSourceName.ToString().Trim().Replace('+', ' ') + "' ";
            }
            else { strQuery += " and project = '' "; }

            if ((!status.Equals("ALL")) && (!status.Equals("EXCEPTION")))
            {
                strQuery += " AND STATUS_COLOR_BST in(" + status + ") ";
            }
            strQuery += " AND CYCLE_FREQ= 'DAILY' ";

            strQuery += " ORDER BY STM_LAST_BUSDATE, STM_END_TIME, STREAM_KEY ";

            DataTable dt = new DataTable();
            //tmm.TDUsername = Request.Cookies["myCookie_Trackingsrc"]["user"].ToString();
            //tmm.TDPassword = Request.Cookies["myCookie_Trackingsrc"]["pass"].ToString();
            dt = tmm.GetDataTableTera(strQuery);            
            string str_stream_key;
            for (int i = 0; i < dt.Rows.Count; i++)
            {

                str_stream_key = dt.Rows[i]["STREAM_KEY"].ToString();
                str_stream_key += " <a class='fa fa-info-circle text-info menu-links' onclick='streamInfo(" + dt.Rows[i]["STREAM_KEY"].ToString() + ")'></a>";

                str_bl.Append("<tr> <td><button type='button' Class='button_status' Style='background-color:" + dt.Rows[i]["STM_STATUS_CR"].ToString() + ";'></button></td>");
                str_bl.Append("<td> ").Append(str_stream_key).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STREAM_NAME"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["GROUP_"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STM_LAST_BUSDATE"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STM_START_TIME"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STM_END_TIME"].ToString()).Append("</td></tr>");

            }

            return str_bl;
        }

        private void GetStrem() {
            string strQuery = string.Empty;
            StringBuilder str_bl = new StringBuilder();
            StringBuilder str_all = new StringBuilder();
            StringBuilder str_completed = new StringBuilder();
            StringBuilder str_running = new StringBuilder();
            StringBuilder str_failed = new StringBuilder();
            StringBuilder str_notstart = new StringBuilder();
            StringBuilder str_exception = new StringBuilder();


            strQuery += " SELECT STATUS_COLOR_BST, STM_STATUS_CR, STM_EXCEPTION_FLG, STREAM_KEY, STREAM_NAME, GROUP_";
            strQuery += ", CAST(CAST(STM_LAST_BUSDATE AS DATE FORMAT 'YYYY-MM-DD') AS VARCHAR(15)) ";            
            strQuery += " ,CAST(CAST(STM_START_TIME AS  TIMESTAMP(6)) AS VARCHAR(19))";            
            strQuery += " ,CAST(CAST(STM_END_TIME AS  TIMESTAMP(6)) AS VARCHAR(19))";
            strQuery += " FROM DATALAB_OPER.pss_report_detail_status_prj_stm_01 ";
            strQuery += " WHERE TIER = 'TIER1' ";
            strQuery += " and project = '' ";
            strQuery += " AND GROUP_ not like 'NoPrc%' ";

            DataTable dt = new DataTable();            
            dt = tmm.GetDataTableTera(strQuery);
            string str_stream_key;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                str_bl.Clear();
                str_stream_key = dt.Rows[i]["STREAM_KEY"].ToString();
                str_stream_key += " <a class='fa fa-info-circle text-info menu-links' onclick='streamInfo(" + dt.Rows[i]["STREAM_KEY"].ToString() + ")'></a>";

                str_bl.Append("<tr> <td><button type='button' Class='button_status' Style='background-color:" + dt.Rows[i]["STM_STATUS_CR"].ToString() + ";'></button></td>");
                str_bl.Append("<td> ").Append(str_stream_key).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STREAM_NAME"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["GROUP_"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STM_LAST_BUSDATE"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STM_START_TIME"].ToString()).Append("</td>");
                str_bl.Append("<td> ").Append(dt.Rows[i]["STM_END_TIME"].ToString()).Append("</td></tr>");


                System.Console.Out.Write("");

                /*-- add row data status (completed ,running ,failed ,not start ) --- */
                if (dt.Rows[i]["STM_EXCEPTION_FLG"].ToString() != "1")
                {
                    /* -- add row data ALL status ---- */
                    str_all.Append(str_bl.ToString());

                    if (dt.Rows[i]["STATUS_COLOR_BST"].ToString() == "btn btn-success")
                    {
                        str_completed.Append(str_bl.ToString());
                    }
                    else if (dt.Rows[i]["STATUS_COLOR_BST"].ToString() == "btn btn-warning")
                    {
                        str_running.Append(str_bl.ToString());
                    }
                    else if (dt.Rows[i]["STATUS_COLOR_BST"].ToString() == "btn btn-danger")
                    {
                        str_failed.Append(str_bl.ToString());
                    }
                    else { /* status not start */
                        str_notstart.Append(str_bl.ToString());
                    }

                }else { /* -- add row data Exception --- */
                    str_exception.Append(str_bl.ToString());
                }



            }

            /* add data to table display page */
            lt_table_tab_all.Text = str_all.ToString();
            lt_table_tab_finish.Text = str_completed.ToString();
            lt_table_tab_process.Text = str_running.ToString();
            lt_table_tab_failed.Text = str_failed.ToString();
            lt_table_tab_notstart.Text = str_notstart.ToString();
            lt_table_tab_exception.Text = str_exception.ToString();
        }


        private StringBuilder GetSumSLAProject() {

            StringBuilder str_data = new StringBuilder();
            string strQuery = string.Empty;

            strQuery = " SELECT project ,miss ,meet ,total ,meet_p ";
            strQuery += " FROM DATALAB_OPER.pss_report_sumary_sla_prj_stm_01 order by project";

            DataTable dt = new DataTable();
            dt = tmm.GetDataTableTera(strQuery);
            double meet = 0;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                meet = Convert.ToDouble(dt.Rows[i]["meet_p"].ToString());

                str_data.Append("<tr>");

                if (dt.Rows[i]["project"].ToString() == "") {
                    str_data.Append("<td><strong>ALL</strong></td>");
                } else {
                    str_data.Append("<td><strong>").Append(dt.Rows[i]["project"].ToString()).Append("</strong></td>");
                }                

                str_data.Append("<td>").Append(dt.Rows[i]["miss"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["meet"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["total"].ToString()).Append("</td>");
                
                if (meet < 50) { 
                    str_data.Append("<td><span class='badge badge-pill badge-danger'>Miss</span></td>");
    }
                else {
                    str_data.Append("<td><span class='badge badge-pill badge-success'>Meet</span></td>");
                    
                }
                str_data.Append("</tr>");




            }


                return str_data;
        }

        private StringBuilder getGroupSum() {
            StringBuilder strbd = new StringBuilder();
            GroupDAO groupDAO = new GroupDAO();
            List<Group> lstGrp = new List<Group>();

            lstGrp = groupDAO.getGroupSummary();
            string str_num_failed = "";

            for (int i = 0; i < lstGrp.Count; i++) {

                if (lstGrp[i].Failed != 0)
                {
                    str_num_failed = "<span class='badge badge-danger'>" + lstGrp[i].Failed + "</span>";
                }else {
                    str_num_failed = lstGrp[i].Failed.ToString();
                }

                strbd.Append("<tr>");
                strbd.Append("<td><strong>").Append(lstGrp[i].Group_name).Append("</strong></td>");
                strbd.Append("<td>").Append(lstGrp[i].Completed).Append("</td>");
                strbd.Append("<td>").Append(lstGrp[i].Running).Append("</td>");
                strbd.Append("<td>").Append(str_num_failed).Append("</td>");
                strbd.Append("<td>").Append(lstGrp[i].Notstart).Append("</td>");
                strbd.Append("<td>").Append(lstGrp[i].Except).Append("</td>");
                strbd.Append("<td>").Append(lstGrp[i].Total).Append("</td>");
                strbd.Append("</tr>");
            }

            return strbd;
        }

        private void get_PSS_TODAY_ERROR_LOG()
        {

            StringBuilder str_data = new StringBuilder();
            string strQuery = string.Empty;

            strQuery = " select CAST(CAST(update_ts AS  TIMESTAMP(6)) AS VARCHAR(19)) as update_ts ,stream_key ,process_name ,auto_analyze_log   ,sys_log  FROM DATALAB_OPER.PSS_TODAY_ERROR_LOG ";




            DataTable dt = new DataTable();
            dt = tmm.GetDataTableTera(strQuery);
            double meet = 0;

            for (int i = 0; i < dt.Rows.Count; i++)
            {

                str_data.Append("<tr>");
                str_data.Append("<td>").Append(dt.Rows[i]["update_ts"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["stream_key"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["process_name"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["auto_analyze_log"].ToString()).Append("</td>");
                str_data.Append("<td>").Append(dt.Rows[i]["sys_log"].ToString()).Append("</td>");
                str_data.Append("</tr>");






            }

           // lt_today_error.Text = str_data.ToString();




        }


    }
}