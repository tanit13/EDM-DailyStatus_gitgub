using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;
using System.Text;
using System.Reflection;

namespace DBMS.Class
{  
    public class DatabaseManager
    {
        private string strConn = ConfigurationManager.ConnectionStrings["TimesheetConn"].ConnectionString;
        private SqlConnection SqlConn = new SqlConnection();

        private void OpenDb()
        {
            SqlConn = new SqlConnection(strConn);
            SqlConn.Open();
        }
        private void CloseDb()
        {
            SqlConn.Close();
        }
        public DataTable QueryDataTable(String sql)
        {
            OpenDb();
            DataTable dt = new DataTable();
            SqlDataAdapter ad = new SqlDataAdapter(sql, SqlConn);
            ad.Fill(dt);
            CloseDb();
            return dt;
        }
        public DataSet QueryDataSet(String sql)
        {
            OpenDb();
            DataSet ds = new DataSet();
            SqlDataAdapter ad = new SqlDataAdapter(sql, SqlConn);
            ad.Fill(ds);
            CloseDb();
            return ds;
        }

        public DataTable sps_CheckLeave()
        {
                DataTable dt = new DataTable();
                SqlCommand cmd = new SqlCommand("Transactions.sps_CheckLeave", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TB", dtSQL);
                SqlDataReader ad = cmd.ExecuteReader();
                dt.Load(ad);
            CloseDb();
            return dt;
        }



        public int PROC_STS { set; get; }
        public string ERROR_MSG { set; get; }


        public string EmployeeID { set; get; }
        public int PrefixID { set; get; }
        public string FirstName_Th { set; get; }
        public string LastName_Th { set; get; }
        public string FirstName_En { set; get; }
        public string LastName_En { set; get; }
        public string NickName { set; get; }
        public string ActiveEmployeeFlag { set; get; }
        public DateTime WorkStartDate { set; get; }
        public DateTime ResignDate { set; get; }
        public string UserType { set; get; }
        public int VendorID { set; get; }
        public int StaffLevelID { set; get; }
        public int StaffRoleID { set; get; }
        public int HireTypeID { set; get; }
        public DateTime ContactBeginDate { set; get; }
        public DateTime ContactEndDate { set; get; }
        public int ProjectLead { set; get; }
        public string VendorExpectFlag { set; get; }
        public int TeamID { set; get; }
        public string INFINITY_CONTACT { set; get; }
        public DataTable dtEmployee { set; get; }
        public int BypassLogin { set; get; }
       

        public int spi_Employee()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("Master.spi_Employee", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID);
                cmd.Parameters.AddWithValue("@PrefixID", PrefixID);
                cmd.Parameters.AddWithValue("@FirstName_Th", FirstName_Th);
                cmd.Parameters.AddWithValue("@LastName_Th", LastName_Th);
                cmd.Parameters.AddWithValue("@FirstName_En", FirstName_En);
                cmd.Parameters.AddWithValue("@LastName_En", LastName_En);
                cmd.Parameters.AddWithValue("@NickName", NickName);
                cmd.Parameters.AddWithValue("@ActiveEmployeeFlag", ActiveEmployeeFlag);
                cmd.Parameters.AddWithValue("@WorkStartDate", WorkStartDate);
                cmd.Parameters.AddWithValue("@ResignDate", ResignDate);
                cmd.Parameters.AddWithValue("@UserType", UserType);
                cmd.Parameters.AddWithValue("@VendorID", VendorID);
                cmd.Parameters.AddWithValue("@StaffLevelID", StaffLevelID);
                cmd.Parameters.AddWithValue("@StaffRoleID", StaffRoleID);
                cmd.Parameters.AddWithValue("@HireTypeID", HireTypeID);
                cmd.Parameters.AddWithValue("@ContactBeginDate", ContactBeginDate);
                cmd.Parameters.AddWithValue("@ContactEndDate", ContactEndDate);
                cmd.Parameters.AddWithValue("@ProjectLead", ProjectLead);
                cmd.Parameters.AddWithValue("@VendorExpectFlag", VendorExpectFlag);
                cmd.Parameters.AddWithValue("@TeamID", TeamID);
                cmd.Parameters.AddWithValue("@INFINITY_CONTACT", INFINITY_CONTACT);
                cmd.Parameters.AddWithValue("@BypassLogin", BypassLogin);
                
                cmd.Parameters.AddWithValue("@TB", dtEmployee);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int spu_Employee()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("Master.spu_Employee", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID);
                cmd.Parameters.AddWithValue("@PrefixID", PrefixID);
                cmd.Parameters.AddWithValue("@FirstName_Th", FirstName_Th);
                cmd.Parameters.AddWithValue("@LastName_Th", LastName_Th);
                cmd.Parameters.AddWithValue("@FirstName_En", FirstName_En);
                cmd.Parameters.AddWithValue("@LastName_En", LastName_En);
                cmd.Parameters.AddWithValue("@NickName", NickName);
                cmd.Parameters.AddWithValue("@ActiveEmployeeFlag", ActiveEmployeeFlag);
                cmd.Parameters.AddWithValue("@WorkStartDate", WorkStartDate);
                cmd.Parameters.AddWithValue("@ResignDate", ResignDate);
                cmd.Parameters.AddWithValue("@UserType", UserType);
                cmd.Parameters.AddWithValue("@VendorID", VendorID);
                cmd.Parameters.AddWithValue("@StaffLevelID", StaffLevelID);
                cmd.Parameters.AddWithValue("@StaffRoleID", StaffRoleID);
                cmd.Parameters.AddWithValue("@HireTypeID", HireTypeID);
                cmd.Parameters.AddWithValue("@ContactBeginDate", ContactBeginDate);
                cmd.Parameters.AddWithValue("@ContactEndDate", ContactEndDate);
                cmd.Parameters.AddWithValue("@ProjectLead", ProjectLead);
                cmd.Parameters.AddWithValue("@VendorExpectFlag", VendorExpectFlag);
                cmd.Parameters.AddWithValue("@TeamID", TeamID);
                cmd.Parameters.AddWithValue("@INFINITY_CONTACT", INFINITY_CONTACT);
                cmd.Parameters.AddWithValue("@EmployeeKey", EmployeeKey);
                cmd.Parameters.AddWithValue("@BypassLogin", BypassLogin);
                cmd.Parameters.AddWithValue("@TB", dtEmployee);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }



        public string ProjectCategoryName { set; get; }
        public int ProjectCategoryStatus { set; get; }
        public int ProjectCategoryID { set; get; }

        //***************************Admin Category Management
        public int spi_Admin_MasterProjectCategory()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spi_Admin_MasterProjectCategory]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProjectCategoryName", ProjectCategoryName);
                cmd.Parameters.AddWithValue("@ProjectCategoryStatus", ProjectCategoryStatus);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int TeamLead { set; get; }


        public int spu_TeamOrganization()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("Master.spu_TeamOrganization", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProjectLead", ProjectLead);
                cmd.Parameters.AddWithValue("@TeamLead", TeamLead);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int spi_TeamOrganization()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spi_TeamOrganization]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProjectLead", ProjectLead);
                cmd.Parameters.AddWithValue("@TeamLead", TeamLead);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int spd_Admin_MasterProjectCategory()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spd_Admin_MasterProjectCategory]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProjectCategoryID", ProjectCategoryID);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int spu_Admin_MasterProjectCategory()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spu_Admin_MasterProjectCategory]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProjectCategoryID", ProjectCategoryID);
                cmd.Parameters.AddWithValue("@ProjectCategoryName", ProjectCategoryName);
                cmd.Parameters.AddWithValue("@ProjectCategoryStatus", ProjectCategoryStatus);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        //***************************Admin Phase Management

        public string PhaseName { set; get; }
        public int PhaseStatus { set; get; }
        public int PhaseID { set; get; }

        public int spi_Admin_MasterPhase()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spi_Admin_MasterPhase]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PhaseName", PhaseName);
                cmd.Parameters.AddWithValue("@PhaseStatus", PhaseStatus);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int spd_Admin_MasterPhase()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spd_Admin_MasterPhase]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PhaseID", PhaseID);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int spu_Admin_MasterPhase()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spu_Admin_MasterPhase]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PhaseID", PhaseID);
                cmd.Parameters.AddWithValue("@PhaseName", PhaseName);
                cmd.Parameters.AddWithValue("@PhaseStatus", PhaseStatus);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        //***************************Admin Status Management

        public string StatusName { set; get; }
        public int Status { set; get; }
        public string StatusID { set; get; }

        public int spi_Admin_MasterStatus()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spi_Admin_MasterStatus]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatusID", StatusID);
                cmd.Parameters.AddWithValue("@StatusName", StatusName);
                cmd.Parameters.AddWithValue("@Status", Status);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int spd_Admin_MasterStatus()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spd_Admin_MasterStatus]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@StatusID", StatusID);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int spu_Admin_MasterStatus()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spu_Admin_MasterSatus]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatusID", StatusID);
                cmd.Parameters.AddWithValue("@StatusName", StatusName);
                cmd.Parameters.AddWithValue("@Status", Status);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public DataTable dtSQL { set; get; }

        public int spi_Form_InputTimesheet()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Transactions].[spi_Form_InputTimesheet_2]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TB", dtSQL);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public string ProjectName { set; get; }
        public string ProjectDescription { set; get; }
        public int ProjectOwnerEmployeeKey { set; get; }
        public int CreateBy { set; get; }
        public string PROJ_CODE { set; get; }

        public int spi_FormInputProjectList_User()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Master].[spi_FormInputProjectList_User]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProjectName", ProjectName);
                cmd.Parameters.AddWithValue("@ProjectDescription", ProjectDescription);
                cmd.Parameters.AddWithValue("@ProjectOwnerEmployeeKey", ProjectOwnerEmployeeKey);
                cmd.Parameters.AddWithValue("@CreateBy", CreateBy);

                cmd.Parameters.Add("@PROJ_CODE", SqlDbType.NVarChar, 400);
                cmd.Parameters["@PROJ_CODE"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROJ_CODE = (string)cmd.Parameters["@PROJ_CODE"].Value;
                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int HeaderID { set; get; }
        public int spd_Form_DeleteHeaderTransaction()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Transactions].[spd_Form_DeleteHeaderTransaction]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@HeaderID", HeaderID);

                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int spu_Form_InputTimesheet()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("[Transactions].[spu_Form_InputTimesheet_4]", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TB", dtSQL);
                cmd.Parameters.AddWithValue("@HeaderID", HeaderID);
                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                // ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;

                ERROR_MSG = (cmd.Parameters["@ERROR_MSG"].Value == DBNull.Value) ? string.Empty : cmd.Parameters["@ERROR_MSG"].Value.ToString();
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }

        public int Month_of_calendar { set; get; }
        public int EmployeeKey { set; get; }
        public int Submit_Status_Up { set; get; }
        public int Submit_Status_Se { set; get; }
        public int spu_TimeSheet_Submit()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("Transactions.spu_TimeSheet_Submit", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Month_of_calendar", Month_of_calendar);
                cmd.Parameters.AddWithValue("@EmployeeKey", EmployeeKey);
                cmd.Parameters.AddWithValue("@Submit_Status_Up", Submit_Status_Up);
                cmd.Parameters.AddWithValue("@Submit_Status_Se", Submit_Status_Se);

                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int RowUpdate { set; get; }
        public int spu_UnlockSubmit()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("Transactions.spu_UnlockSubmit", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Month_of_calendar", Month_of_calendar);
                cmd.Parameters.AddWithValue("@EmployeeKey", EmployeeKey);

                cmd.Parameters.Add("@RowUpdate", SqlDbType.Int);
                cmd.Parameters["@RowUpdate"].Direction = ParameterDirection.Output;


                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                RowUpdate = int.Parse(cmd.Parameters["@RowUpdate"].Value.ToString());
                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }


        public int DaysTimer { set; get; }
        public int spi_LoginDaysTimer()
        {
            int sts = 1;
            try
            {
                SqlCommand cmd = new SqlCommand("Master.spi_LoginDaysTimer", SqlConn);
                OpenDb();
                cmd.Connection = SqlConn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DaysTimer", DaysTimer);

                cmd.Parameters.Add("@PROC_STS", SqlDbType.Int);
                cmd.Parameters["@PROC_STS"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@ERROR_MSG", SqlDbType.NVarChar, 400);
                cmd.Parameters["@ERROR_MSG"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();


                PROC_STS = int.Parse(cmd.Parameters["@PROC_STS"].Value.ToString());
                ERROR_MSG = (string)cmd.Parameters["@ERROR_MSG"].Value;
                CloseDb();
            }
            catch (Exception ex)
            {
                sts = 0;
                ERROR_MSG = (ex.ToString());
            }
            return sts;
        }
    }
}













