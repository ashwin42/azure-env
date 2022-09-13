netsh advfirewall firewall add rule name="Octoplant Server 64001-64006" dir=in action=allow protocol=TCP localport=64001-64006
netsh advfirewall firewall add rule name="Octoplant Server 64021" dir=in action=allow protocol=TCP localport=64021

netsh advfirewall firewall add rule name="Fl.A1 Range 1" dir=in action=allow protocol=TCP remoteip=10.101.196.0/23
netsh advfirewall firewall add rule name="FL.A1 Range 2" dir=in action=allow protocol=TCP remoteip=10.101.198.0/25
netsh advfirewall firewall add rule name="FL.A1.CO.PHC01" dir=in action=allow protocol=TCP remoteip=10.101.192.0/26
netsh advfirewall firewall add rule name="FL.C1 Range 1" dir=in action=allow protocol=TCP remoteip=10.101.198.128/20
netsh advfirewall firewall add rule name="FL.C1 Range 2" dir=in action=allow protocol=TCP remoteip=10.101.199.0/24


