using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDM_DailyStatus.Class.data
{
    public class TimelineEDM
    {
        string timeline;
        string group_name;
        string group_status;
        string tier;

        public string Timeline { get ; set; }
        public string Group_name { get; set; }
        public string Group_status {
            get { return group_status; }

            set
            {
                //pulse - button

                if (value == "btn btn-danger")
                {
                    group_status = " <button type = 'button' class='button_status_timeline pulse-button btn " + value + " ' ></button>";
                }
                else if (value == "btn") {
                    group_status = " <button type = 'button' style ='background-color:#212529;' class='button_status_timeline btn' ></button>";

                } else if (value == "btn btn-warning") {
                    group_status = " <button type = 'button' class='button_status_timeline pulse-button btn btn-warning'></button>";
                }
                else
                {
                    group_status = " <button type = 'button' class='button_status_timeline btn " + value + " ' ></button>";
                }
                
            }
        }

        public string Tier { get => tier; set => tier = value; }
    }
}