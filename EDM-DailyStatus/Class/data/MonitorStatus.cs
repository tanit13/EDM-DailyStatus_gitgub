using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class MonitorStatus
    {
        private string status;
        private string status_name;
        private string work_name;
        private string batch_name;
        private string business_date;
        private string job_start_date;
        private string job_end_date;
        private string est_hours;
        private string frequency;
        private string stream;
        private string sla;
        private string c_sla;
        private string avg_c;
        private string avg;
        private string min;
        private string max;
        private string first_supportor_id;
        private string wait_appl;
        private string impact_appl;

        public string Status_name { get; set; }
        public string Work_name { get; set; }
        public string Batch_name { get; set; }
        public string Business_date { get; set; }
        public string Job_start_date { get { return job_start_date; } set { job_start_date = value.Equals(null) ? "" : value; }  }
        public string Job_end_date { get { return job_end_date; } set { job_end_date = value.Equals(null) ? "" : value;  } }
        public string Est_hours { get; set; }
        public string Frequency { get; set; }
        public string Stream { get; set; }
        public string Sla { get; set; }

        public string Avg { get; set; }
        public string Min { get; set; }
        public string Max { get; set; }       

        public string C_sla { get { return c_sla; }

            set {
                if (value.Equals("Meet"))
                {
                    c_sla = "<span class='badge badge-pill badge-success'>Meet</span>";
                }
                else if (value.Equals("Miss"))
                {
                    c_sla = "<span class='badge badge-pill badge-danger'>Miss</span>";
                }
                else { c_sla = value; }
            }
        }

        public string Status
        {
            get { return status; }

            set
            {
                if (value == "1")
                {
                    status = " <button type = 'button' class='button_status btn' ></button>";
                }
                else if (value == "2")
                {
                    status = " <button type = 'button' class='button_status btn btn-warning' ></button>";
                    //status = "btn btn-warning";
                }
                else {
                    // value == 3
                    status = " <button type = 'button' class='button_status btn btn-success' ></button>";
                    //status = "btn btn-success";
                }                 
            }
        }

        public string Avg_c { get { return avg_c; }
            set {
                if (value =="Up")
                {
                    avg_c = "<i class='fa fa-arrow-up text-success'></i>";
                }
                else if (value == "Down")
                {
                    avg_c = "<i class='fa fa-arrow-down text-danger'></i>";
                }
                else {
                    avg_c = value;
                }
            } }

        public string First_supportor_id { get ; set ; }
        public string Wait_appl { get; set; }
        public string Impact_appl { get; set; }
    }
}