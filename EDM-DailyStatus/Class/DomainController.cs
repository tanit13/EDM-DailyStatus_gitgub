using System;
using System.Collections.Generic;
using System.DirectoryServices.ActiveDirectory;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for DomainController
/// </summary>
public class DomainManager
{
    public DomainManager()
    {
        Domain domain = null;
        DomainController domainController = null;
        try
        {
            domain = Domain.GetCurrentDomain();
            DomainName = domain.Name;
            domainController = domain.PdcRoleOwner;
            DomainControllerName = domainController.Name.Split('.')[0];
            ComputerName = Environment.MachineName;
        }
        finally
        {
            if (domain != null)
                domain.Dispose();
            if (domainController != null)
                domainController.Dispose();
        }
    }

    public string DomainControllerName { get; private set; }

    public string ComputerName { get; private set; }

    public string DomainName { get; private set; }

    public string DomainPath
    {
        get
        {
            bool bFirst = true;
            StringBuilder sbReturn = new StringBuilder(200);
            string[] strlstDc = DomainName.Split('.');
            foreach (string strDc in strlstDc)
            {
                if (bFirst)
                {
                    sbReturn.Append("DC=");
                    bFirst = false;
                }
                else
                    sbReturn.Append(",DC=");

                sbReturn.Append(strDc);
            }
            return sbReturn.ToString();
        }
    }

    public string RootPath
    {
        get
        {
            return string.Format("LDAP://{0}/{1}", DomainName, DomainPath);
        }
    }
}
