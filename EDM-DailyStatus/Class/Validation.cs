using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Data;
using System.IO;
using System.Text;
using System.Security.Cryptography;

namespace VLD.Class
{
    public class ClassValidation
    {
        public string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
        public string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
        public string RightString(string value, int length)
        {
            return value.Substring(value.Length - length);
        }
        public DateTime YearToDateTime(string _Year)
        {
            DateTime ConYear = new DateTime(int.Parse(_Year), 1, 1);
            return ConYear;
        }

        public double checkNullData(string doubleData)
        {
            double doubleReturn;
            if (string.IsNullOrEmpty(doubleData) == true)
            {
                doubleReturn = 0;
            }
            else
            {
                doubleReturn = double.Parse(doubleData);
            }

            return doubleReturn;
        }
        public string ReplaceQoute(string strReplace)
        {
            //Replace When Input " ' ,
            string pattern = "['\",]";
            string resultChk = (Regex.Replace(strReplace, pattern, string.Empty));
            return resultChk;
        }
        public bool ValidationNum(String strChk)
        {
            bool chk;
            string allowedChars = @"^[0-9]+$";
            if (Regex.IsMatch(strChk, allowedChars))
            {
                chk = true;
            }
            else
            {
                chk = false;
            }
            return chk;
        }
        public bool ValidationDouble(string text)
        {
            Double num = 0;
            bool isDouble = false;

            // Check for empty string.
            if (string.IsNullOrEmpty(text))
            {
                return false;
            }

            isDouble = Double.TryParse(text, out num);

            return isDouble;
        }
        public bool ValidationDate(string strDate)
        {
            bool chkDate;

            System.IFormatProvider format = new System.Globalization.CultureInfo("en-US");
            DateTime dDate;
            if (DateTime.TryParse(strDate, out dDate))
            {
                chkDate = true;
            }
            else
            {
                chkDate = false;
            }

            return chkDate;
        }
        public bool CheckExtensionFile(string[] _ExtensionMaster, string _ExtensionFile)
        {
            bool bl = false;
            for (int i = 0; i < _ExtensionMaster.Length; i++)
            {
                if (_ExtensionMaster[i].ToUpper() == _ExtensionFile.ToUpper())
                {
                    bl = true;
                    return bl;
                }
            }
            return bl;
        }
    }
}