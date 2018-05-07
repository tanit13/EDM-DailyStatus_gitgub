using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Web.Security;
using System.Security.Principal;
using System.Collections;
using System.Text;
using System.Data;
using System.IO;
using System.Drawing;
using System.Configuration;
using System.Net;
using DBMS.Class;

//using System.DirectoryServices.AccountManagement;
//using System.DirectoryServices;

/// <summary>
/// Summary description for MailManager
/// </summary>
public class MailManager
{
    //ClassDB db = new ClassDB();
    //ClassChkAuthorization ca = new ClassChkAuthorization();
    DatabaseManager dbm = new DatabaseManager();

    public static Bitmap ByteToImage(byte[] blob)
    {
        using (MemoryStream mStream = new MemoryStream())
        {
            mStream.Write(blob, 0, blob.Length);
            mStream.Seek(0, SeekOrigin.Begin);

            Bitmap bm = new Bitmap(mStream);
            return bm;
        }
    }
    public static byte[] ImageToBinary(string imagePath)
    {
        FileStream fileStream = new FileStream(imagePath, FileMode.Open, FileAccess.Read);
        byte[] buffer = new byte[fileStream.Length];
        fileStream.Read(buffer, 0, (int)fileStream.Length);
        fileStream.Close();
        return buffer;
    }
    public string ErrorMail { set; get; }
    public void Sendmail(string _FromMail, string _FromName, string _ID)
    {

        string Subject_Mail = "";
        try
        {
            string toName = "";
            string MsgBody = "";
            MailMessage MailMsg = new MailMessage();
            MailMsg.From = new MailAddress(_FromMail);


            string _SiteLink = ConfigurationManager.AppSettings["Link_Mail"];
            _SiteLink += "?mail=1&id=" + _ID;


            DataSet ds = new DataSet();
            ds = dbm.QueryDataSet("EXEC sps_GetRequestDetail_Email '" + _ID + "'");
            DataTable dtRequestDetail = new DataTable();
            DataTable dtECB = new DataTable();
            DataTable dtMgr = new DataTable();
            DataTable dtRequstor = new DataTable();

            dtRequestDetail = ds.Tables[0];
            dtECB = ds.Tables[1];
            dtMgr = ds.Tables[2];
            dtRequstor = ds.Tables[3];




            string dSts = dtRequestDetail.Rows[0]["Status"].ToString();

            //MailMsg.CC.Add(new MailAddress(_FromMail.Trim()));
            //MailMsg.To.Add(new MailAddress("pornsak.termmee@smartrac-group.com"));

            string Space = "&nbsp;&nbsp;&nbsp;&nbsp;";
            string Space2 = "&nbsp;&nbsp;";
            string bgColor = "";
            string statusHeader = "";
            string fontColor = "";
            string HeaderMsg = "This is auto generate e-mail.";
            string SubHeaderMsg = "";

            if (dSts == "WECB")
            {

                Subject_Mail = "Product & Process Transfer Data: " + dtRequestDetail.Rows[0]["ADrawing"].ToString() + " - filing ";
                SubHeaderMsg = "Please follow the link below to approve the Product & Process transfer data.";
                bgColor = "Black";
                statusHeader = "Wait Approve";
                fontColor = "#ff6700";

                toName = "ECB and Product Manager";
                MsgBody = "Product Transfer has been Created on System, Please Approve";

                string _EmpMgr = dtRequestDetail.Rows[0]["MgrID"].ToString();
                string _MailMgr = (from myRow in dtMgr.AsEnumerable()
                                   where myRow.Field<string>("EmpID") == _EmpMgr
                                   select myRow.Field<string>("EMAIL")).First<string>();


                MailMsg.To.Add(new MailAddress(_MailMgr.Trim()));

                for (int y = 0; y < dtECB.Rows.Count; y++)
                {
                    if (dtECB.Rows[y]["Status"].ToString() =="1")
                    {
                        MailMsg.To.Add(new MailAddress(dtECB.Rows[y]["EMAIL"].ToString().Trim()));
                    }
                    
                }
                MailMsg.CC.Add(new MailAddress(_FromMail.Trim()));
            }

            if (dSts == "COMP")
            {
                bgColor = "Green";
                statusHeader = "Complete";
                fontColor = "Green";

                toName = dtRequestDetail.Rows[0]["Develop Engineer"].ToString();
                MsgBody = "This Product Transfer has been Complete";

                string _EmpMgr = dtRequestDetail.Rows[0]["MgrID"].ToString();
                string _MailMgr = (from myRow in dtMgr.AsEnumerable()
                                   where myRow.Field<string>("EmpID") == _EmpMgr
                                   select myRow.Field<string>("EMAIL")).First<string>();


                string _EmpEng = dtRequestDetail.Rows[0]["MgrID"].ToString().Trim();

                if (dtRequstor.Rows.Count > 0)
                {
                    MailMsg.To.Add(new MailAddress(dtRequstor.Rows[0]["EMAIL"].ToString().Trim()));
                }

                MailMsg.CC.Add(new MailAddress(_MailMgr.Trim()));

                for (int y = 0; y < dtECB.Rows.Count; y++)
                {
                    if (dtECB.Rows[y]["Status"].ToString() == "1")
                    {
                        MailMsg.CC.Add(new MailAddress(dtECB.Rows[y]["EMAIL"].ToString().Trim()));
                    }
                }
                MailMsg.CC.Add(new MailAddress(_FromMail.Trim()));

            }

            if (dSts == "RECB" || dSts == "RPMG")
            {

                Subject_Mail = "Product & Process Transfer Data: " + dtRequestDetail.Rows[0]["ADrawing"].ToString() + " - filing rejected ";
                SubHeaderMsg = "The below Product & Process transfer data is rejected, please correct and resubmit.";
                bgColor = "Red";
                statusHeader = "Reject";
                fontColor = "Red";

                toName = dtRequestDetail.Rows[0]["Develop Engineer"].ToString();
                MsgBody = "This Product Transfer has been Reject";

                //string _EmpMgr = dtRequestDetail.Rows[0]["MgrID"].ToString();
                //string _MailMgr = (from myRow in dtMgr.AsEnumerable()
                //                   where myRow.Field<string>("EmpID") == _EmpMgr
                //                   select myRow.Field<string>("EMAIL")).First<string>();
                //string EmpEng = dtRequestDetail.Rows[0]["MgrID"].ToString().Trim();

                if (dtRequstor.Rows.Count > 0)
                {
                    MailMsg.To.Add(new MailAddress(dtRequstor.Rows[0]["EMAIL"].ToString().Trim()));
                }


               // MailMsg.CC.Add(new MailAddress(_MailMgr.Trim()));

                //for (int y = 0; y < dtECB.Rows.Count; y++)
                //{
                //    if (dtECB.Rows[y]["Status"].ToString() == "1")
                //    {
                //        MailMsg.CC.Add(new MailAddress(dtECB.Rows[y]["EMAIL"].ToString().Trim()));
                //    }
                //}

                //MailMsg.CC.Add(new MailAddress(_FromMail.Trim()));
            }

            //Subject_Mail = "Alert Request ID: " + dtRequestDetail.Rows[0]["RequestID"].ToString() + ", A Drawing :" + dtRequestDetail.Rows[0]["ADrawing"].ToString() + ". Status " + statusHeader;
            MailMsg.Subject = Subject_Mail;

            MemoryStream ImageEmbed = new MemoryStream();

            //DataTable dtEmbed = new DataTable();
            //dtEmbed = dbm.QueryDataTable("exec sps_EmployeeDetailProfileEmp '"+empID+"'");


            //if (dtEmbed.Rows[0]["PersonPic"] != System.DBNull.Value)
            //{
            //    Byte[] data = new Byte[0];
            //    data = (Byte[])(dtEmbed.Rows[0]["PersonPic"]);

            //    Bitmap b = new Bitmap(ByteToImage(data));
            //    ImageConverter ic = new ImageConverter();
            //    Byte[] ba = (Byte[])ic.ConvertTo(b, typeof(Byte[]));
            //    MemoryStream ImageEmbedData = new MemoryStream(ba);
            //    ImageEmbed = ImageEmbedData;
            //}

            Byte[] data = new Byte[0];
            data = (Byte[])(ImageToBinary(HttpContext.Current.Server.MapPath("~/images/smt_logo.png")));

            Bitmap b = new Bitmap(ByteToImage(data));
            ImageConverter ic = new ImageConverter();
            Byte[] ba = (Byte[])ic.ConvertTo(b, typeof(Byte[]));
            MemoryStream ImageEmbedData = new MemoryStream(ba);
            ImageEmbed = ImageEmbedData;



            MailMsg.IsBodyHtml = true;

            string BodyMail_Header = "";
            string BodyMail_Image = "";
            string BodyMail_Footer = "";

            BodyMail_Header += "<table width='100%' style='font-family:Century Gothic' cellspacing='0'>";
            BodyMail_Header += "<tr>";
            BodyMail_Header += "<td>";
            BodyMail_Header += "</td>";
            BodyMail_Header += "</tr>";

            BodyMail_Header += "<tr valign='top'>";
            BodyMail_Header += "<td>";
            //BodyMail_Header += "<b><span style=color:#000'>Hi " + toName + " </span></b><br/><br/>";
            BodyMail_Header += "<span style=color:#000;font-size:12px'>" + HeaderMsg + "</span><br/>";
            BodyMail_Header += "<span style=color:#000;font-size:12px'>" + SubHeaderMsg + "</span><br/>";
            BodyMail_Header += "<span style=color:#000;font-size:12px'><a href='" + _SiteLink + "'> " + _SiteLink + "</a></span><br/>";
            BodyMail_Footer += "</tr>";


            BodyMail_Footer += "<tr>";
            BodyMail_Footer += "<td>";
            BodyMail_Footer += "<hr/></td>";
            BodyMail_Footer += "</tr>";


            //BodyMail_Image += "<tr bgcolor='" + bgColor + "'>";
            //BodyMail_Image += "<td> &nbsp;";
            //BodyMail_Image += "<br/><p> <img src=cid:companyLogo /> </p><br/>";
            //BodyMail_Image += "</td>";
            //BodyMail_Image += "</tr>";


            //BodyMail_Footer += "<tr>";
            //BodyMail_Footer += "<td style='font-size:12px'>";
            //BodyMail_Footer += "<br/><p style='font-family:Century Gothic'>" + MsgBody + ", More detail as below.<br />";
            //BodyMail_Footer += "<br/><span style='font-family:Century Gothic'><b><u>Detail:</u></b></span><br/>";
            //BodyMail_Footer += "</td>";
            //BodyMail_Footer += "</tr>";
            BodyMail_Footer += "<tr>";
            BodyMail_Footer += "<td style='margin-left:100px; font-size:12px'>";


            BodyMail_Footer += "" + Space + "<b>ID: </b>" + Space2 + dtRequestDetail.Rows[0]["RequestID"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>A Drawing: </b>" + Space2 + dtRequestDetail.Rows[0]["ADrawing"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>D Drawing: </b>" + Space2 + dtRequestDetail.Rows[0]["DDrawing"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>PMP: </b>" + Space2 + dtRequestDetail.Rows[0]["PMP"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Develop Engineer: </b>" + Space2 + dtRequestDetail.Rows[0]["Develop Engineer"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Product Manager: </b>" + Space2 + dtRequestDetail.Rows[0]["Product Manager"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Request Date: </b>" + Space2 + dtRequestDetail.Rows[0]["Request Date"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Status: </b><span style='color:" + fontColor + "'>" + Space2 + dtRequestDetail.Rows[0]["Status_full"].ToString() + "</span><br/>";

            BodyMail_Footer += "</td>";
            BodyMail_Footer += "</tr>";
            //BodyMail_Footer += "<tr>";
            //BodyMail_Footer += "<td style='font-size:12px'>";
            //BodyMail_Footer += "<br/><span style='font-family:Century Gothic'><b>Link: </b></span><span><a href='" + _SiteLink + "'> Product Transfer System </a></span><br/><br/><br/>";
            //BodyMail_Footer += "</td>";
            //BodyMail_Footer += "</tr>";
            BodyMail_Footer += "</table>";

            BodyMail_Footer += "<hr/>";
            //BodyMail_Footer += "<span style='font-family:Century Gothic; font-size:16px'><b>Best Regards.</b></span><br/>";
            //BodyMail_Footer += "<span style='font-family:Century Gothic; font-size:16px'>" + _FromName + "</span><br/>";
            //BodyMail_Footer += "<p> <img height='63' width='213' src=cid:EmployeeImage /> </p>";



            LinkedResource EmbedImg = new LinkedResource(ImageEmbed, "image/png");
            EmbedImg.ContentId = "EmployeeImage";
            AlternateView AllMailBody = AlternateView.CreateAlternateViewFromString(MailMsg.Body = BodyMail_Header + BodyMail_Image + BodyMail_Footer, null, "text/html");
            //AllMailBody.LinkedResources.Add(EmbedImg);
            MailMsg.AlternateViews.Add(AllMailBody);



            try
            {
                SmtpClient smtp = new SmtpClient("172.20.42.84", 25);
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.UseDefaultCredentials = true;
                smtp.Send(MailMsg);
                smtp.Dispose();
            }
            catch (SmtpException ex)
            {

            }

        }
        catch (Exception ex)
        {

            MailMessage MailMsg = new MailMessage();
            MailMsg.From = new MailAddress(_FromMail);
            MailMsg.To.Add(new MailAddress("Pornsak.Termmee@smartrac-group.com"));
            MailMsg.CC.Add(new MailAddress(_FromMail));
            MailMsg.Subject = Subject_Mail;


            MailMsg.IsBodyHtml = true;
            MailMsg.Body = "Process Complete But System Cannot Send Email: Error" + ex.Message;


            try
            {

                SmtpClient smtp = new SmtpClient("172.20.42.84", 25);
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.UseDefaultCredentials = true;
                smtp.Send(MailMsg);
                smtp.Dispose();

            }
            catch (SmtpException exn)
            {

            }
        }
    }
    public void Sendmail2(string _FromMail, string _FromName, string _ID)
    {

        string Subject_Mail = "";
        try
        {
            string toName = "";
            string MsgBody = "";
            MailMessage MailMsg = new MailMessage();
            MailMsg.From = new MailAddress(_FromMail);


            string _SiteLink = ConfigurationManager.AppSettings["Link_Mail"];
            _SiteLink += "?mail=1&id=" + _ID;


            DataSet ds = new DataSet();
            ds = dbm.QueryDataSet("EXEC sps_GetRequestDetail_Email '" + _ID + "'");
            DataTable dtRequestDetail = new DataTable();
            DataTable dtECB = new DataTable();
            DataTable dtMgr = new DataTable();
            DataTable dtRequstor = new DataTable();

            dtRequestDetail = ds.Tables[0];
            dtECB = ds.Tables[1];
            dtMgr = ds.Tables[2];
            dtRequstor = ds.Tables[3];




            string dSts = dtRequestDetail.Rows[0]["Status"].ToString();

            MailMsg.CC.Add(new MailAddress(_FromMail.Trim()));
            MailMsg.To.Add(new MailAddress("pornsak.termmee@smartrac-group.com"));
            MailMsg.To.Add(new MailAddress("taotechnocom02@smartrac-group.com"));
            MailMsg.To.Add(new MailAddress("taotechnocom@gmail.com"));

            string Space = "&nbsp;&nbsp;&nbsp;&nbsp;";
            string Space2 = "&nbsp;&nbsp;";
            string bgColor = "";
            string statusHeader = "";
            string fontColor = "";



            Subject_Mail = "Alert Request ID: " + dtRequestDetail.Rows[0]["RequestID"].ToString() + ", A Drawing :" + dtRequestDetail.Rows[0]["ADrawing"].ToString() + ". Status " + statusHeader;
            MailMsg.Subject = Subject_Mail;

            MemoryStream ImageEmbed = new MemoryStream();

    


            MailMsg.IsBodyHtml = true;

            string BodyMail_Header = "";
            string BodyMail_Image = "";
            string BodyMail_Footer = "";

            BodyMail_Header += "<table width='100%' style='font-family:Century Gothic' cellspacing='0'>";
            BodyMail_Header += "<tr>";
            BodyMail_Header += "<td>";
            BodyMail_Header += "</td>";
            BodyMail_Header += "</tr>";

            BodyMail_Header += "<tr valign='top'>";
            BodyMail_Header += "<td>";
            BodyMail_Header += "<b><span style=color:#000'>Hi " + toName + " </span></b><br/><br/>";
            BodyMail_Header += "<span style=color:#000'>This is Alert Email Product Transfer System </span><br/>";
            BodyMail_Header += "<span style=color:#000'>The following email was sent to you by " + _FromName + ".</span></span>";
            BodyMail_Footer += "</tr>";


            BodyMail_Footer += "<tr>";
            BodyMail_Footer += "<td>";
            BodyMail_Footer += "<hr/></td>";
            BodyMail_Footer += "</tr>";


            //BodyMail_Image += "<tr bgcolor='" + bgColor + "'>";
            //BodyMail_Image += "<td> &nbsp;";
            //BodyMail_Image += "<br/><p> <img src=cid:companyLogo /> </p><br/>";
            //BodyMail_Image += "</td>";
            //BodyMail_Image += "</tr>";


            BodyMail_Footer += "<tr>";
            BodyMail_Footer += "<td style='font-size:12px'>";
            BodyMail_Footer += "<br/><p style='font-family:Century Gothic'>" + MsgBody + ", More detail as below.<br />";
            BodyMail_Footer += "<br/><span style='font-family:Century Gothic'><b><u>Detail:</u></b></span><br/>";
            BodyMail_Footer += "</td>";
            BodyMail_Footer += "</tr>";
            BodyMail_Footer += "<tr>";
            BodyMail_Footer += "<td style='margin-left:100px; font-size:12px'>";


            BodyMail_Footer += "" + Space + "<b>ID: </b>" + Space2 + dtRequestDetail.Rows[0]["RequestID"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>A Drawing: </b>" + Space2 + dtRequestDetail.Rows[0]["ADrawing"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>D Drawing: </b>" + Space2 + dtRequestDetail.Rows[0]["DDrawing"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>PMP: </b>" + Space2 + dtRequestDetail.Rows[0]["PMP"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Develop Engineer: </b>" + Space2 + dtRequestDetail.Rows[0]["Develop Engineer"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Product Manager: </b>" + Space2 + dtRequestDetail.Rows[0]["Product Manager"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Request Date: </b>" + Space2 + dtRequestDetail.Rows[0]["Request Date"].ToString() + "<br/>";
            BodyMail_Footer += "" + Space + "<b>Status: </b><span style='color:" + fontColor + "'>" + Space2 + dtRequestDetail.Rows[0]["Status_full"].ToString() + "</span><br/>";

            BodyMail_Footer += "</td>";
            BodyMail_Footer += "</tr>";
            BodyMail_Footer += "<tr>";
            BodyMail_Footer += "<td style='font-size:12px'>";
            BodyMail_Footer += "<br/><span style='font-family:Century Gothic'><b>Link: </b></span><span><a href='" + _SiteLink + "'> Product Transfer System </a></span><br/><br/><br/>";
            BodyMail_Footer += "</td>";
            BodyMail_Footer += "</tr>";
            BodyMail_Footer += "</table>";

            BodyMail_Footer += "<hr/><span style='font-family:Century Gothic; font-size:16px'><b>Best Regards.</b></span><br/>";
            BodyMail_Footer += "<span style='font-family:Century Gothic; font-size:16px'>" + _FromName + "</span><br/>";
            BodyMail_Footer += "<p> <img height='63' width='213' src=cid:EmployeeImage /> </p>";



            //LinkedResource EmbedImg = new LinkedResource(ImageEmbed, "image/png");
            //EmbedImg.ContentId = "EmployeeImage";
            AlternateView AllMailBody = AlternateView.CreateAlternateViewFromString(MailMsg.Body = BodyMail_Header + BodyMail_Image + BodyMail_Footer, null, "text/html");
            //AllMailBody.LinkedResources.Add(EmbedImg);
            MailMsg.AlternateViews.Add(AllMailBody);

            SmtpClient smtp = new SmtpClient("172.20.42.84", 25);

            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.UseDefaultCredentials = true;
            
            MailMsg.DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess | DeliveryNotificationOptions.OnFailure | DeliveryNotificationOptions.Delay;;

            try
            {
                smtp.Send(MailMsg);
                smtp.Dispose();
            }
            catch (SmtpFailedRecipientsException ex)
            {
                for (int i = 0; i < ex.InnerExceptions.Length; i++)
                {
                    SmtpStatusCode status = ex.InnerExceptions[i].StatusCode;
                    if (status == SmtpStatusCode.MailboxBusy ||
                        status == SmtpStatusCode.MailboxUnavailable)
                    {
                        System.Threading.Thread.Sleep(5000);
                        smtp.Send(MailMsg);
                        smtp.Dispose();
                    }
                    else
                    {
                        ErrorMail= "Failed to deliver message to {0} " +ex.InnerExceptions[i].FailedRecipient.ToString();
                    }
                }
            }
            catch (SmtpException ex)
            {
                ErrorMail= ex.Message.ToString();
            }

        }
        catch (Exception ex)
        {

            MailMessage MailMsg = new MailMessage();
            MailMsg.From = new MailAddress(_FromMail);
            MailMsg.To.Add(new MailAddress("Pornsak.Termmee@smartrac-group.com"));
            MailMsg.CC.Add(new MailAddress(_FromMail));
            MailMsg.Subject = Subject_Mail;


            MailMsg.IsBodyHtml = true;
            MailMsg.Body = "Process Complete But System Cannot Send Email: Error" + ex.Message;


            try
            {

                SmtpClient smtp = new SmtpClient("172.20.42.84", 25);
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.UseDefaultCredentials = true;
                smtp.Send(MailMsg);
                smtp.Dispose();

            }
            catch (SmtpException exn)
            {
                ErrorMail = exn.Message.ToString();
            }
        }



    }

}