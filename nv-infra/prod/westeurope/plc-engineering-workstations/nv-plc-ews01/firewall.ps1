netsh advfirewall firewall add rule name="Octoplant Server 64001-64006" dir=in action=allow protocol=TCP localport=64001-64006
netsh advfirewall firewall add rule name="Octoplant Server 64021" dir=in action=allow protocol=TCP localport=64021

netsh advfirewall firewall add rule name="FL.P1 IT-Network" dir=in action=allow protocol=TCP remoteip=10.101.200.128/26
