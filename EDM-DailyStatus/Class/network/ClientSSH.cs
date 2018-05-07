using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Renci.SshNet;

namespace EDM_DailyStatus.Class.network
{
    public class ClientSSH
    {
        //192.168.33.108 dsadm/g=up'.s,j
        public string sentSshCommand(string host, string user, string password, string commandText) {

            string str_result = "";

            using (var client = new SshClient(host, user, password)) {
                client.Connect();

                var ssh_command = client.CreateCommand(commandText);
                str_result = ssh_command.Execute();
                
            }

            return str_result;
        }


    }
}