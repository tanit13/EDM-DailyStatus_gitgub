using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class BigMonitor
    {
        
        string status;
        string work_name;
        string first_supportor_id;
        string sla;
        string process_no;
        string process_id;
        string frequency;
        string business_date;
        string process_start_ts;
        string process_end_ts;

        public string Status {
            get { return status; }

            set
            {
                if (value == "COMPLETE")
                {
                    status = " <button type = 'button' class='button_status btn btn-success' ></button>";                    
                }
                else if (value == "ERROR")
                {
                    status = " <button type = 'button' class='button_status btn btn-danger' ></button>";                    
                }
                else
                {                   
                    status = " <button type = 'button' class='button_status btn' ></button>";                   
                }
            }
        }
        public string Work_name { get; set; }
        public string First_supportor_id { get; set; }
        public string Sla { get; set; }
        public string Process_no { get; set; }
        public string Process_id { get; set; }
        public string Frequency { get; set; }
        public string Business_date { get; set; }
        public string Process_start_ts { get; set; }
        public string Process_end_ts { get; set; }
        
    }
}