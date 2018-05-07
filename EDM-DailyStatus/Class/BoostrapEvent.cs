using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for BoostrapEvent
/// </summary>
/// 
namespace BTE.Class
{
    public class BoostrapEvent
    {
        public string Popup_Msg(string _Header, string _messageDetail, int _ststus)
        {
            string _HeaderIcons = "";
            string header_popup_calss = "";
            string DetailPopup = "";
            switch (_ststus)
            {
                case 0:
                    header_popup_calss = "red-bg-popup-color";
                    _HeaderIcons = "<i class='fa fa-info-circle fa-margin-10px'></i>";
                    break;
                case 1:
                    header_popup_calss = "green-bg-popup-color";
                    _HeaderIcons = "<i class='fa fa-info-circle fa-margin-10px'></i>";
                    break;
                default:
                    header_popup_calss = "gray-bg-popup-color";
                    _HeaderIcons = "<i class='fa fa-info-circle fa-margin-10px'></i>";
                    break;

            }

            DetailPopup += "<div class='modal-header " + header_popup_calss + "' runat='server' id='header_popup'>";
            DetailPopup += "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>";
            DetailPopup += "<span aria-hidden='true'>&times;</span></button>";
            DetailPopup += "<h4 class='modal-title'>";
            DetailPopup += "<span style='color:#fff'>" + _HeaderIcons + _Header + "</span>";
            DetailPopup += "</h4>";
            DetailPopup += "</div>";
            DetailPopup += "<div class='modal-body' runat='server' id='myDiv'>" + _messageDetail + "</div>";


            return DetailPopup;

            // ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>$( document ).ready(function() { $('#myModal').modal('show')});</script>", false);
        }
        public string AlertLabel(string _MsgHead, string _MsgDetail, int _status)
        {
            string _strStatus = "";
            switch (_status)
            {
                case 1:
                    _strStatus = "alert-success";
                    break;
                default:
                    _strStatus = "alert-danger";
                    break;
            }

            string _strAlert = "";

            _strAlert += "<div class='alert " + _strStatus + "'>";
            _strAlert += "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a> ";
            _strAlert += "<strong>";
            _strAlert += _MsgHead + ": </strong> " + _MsgDetail;
            _strAlert += "</div>";


            return _strAlert;

        }
    }
}