netsh advfirewall firewall add rule name="Octoplant Server 64001-64006" dir=in action=allow protocol=TCP localport=64001-64006
netsh advfirewall firewall add rule name="Octoplant Server 64021" dir=in action=allow protocol=TCP localport=64021

netsh advfirewall firewall add rule name="FL.F1 IT-Network" dir=in action=allow protocol=TCP remoteip=0.101.194.128/26