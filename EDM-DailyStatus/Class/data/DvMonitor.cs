using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class DvMonitor
    {
        string status;
        string work_name;
        string sla;
        string frequency;
        string asofdate;
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
        public string Sla { get; set; }
        public string Frequency { get; set; }
        public string Asofdate { get; set; }
        public string Process_start_ts { get; set; }
        public string Process_end_ts { get; set; }
    }
}