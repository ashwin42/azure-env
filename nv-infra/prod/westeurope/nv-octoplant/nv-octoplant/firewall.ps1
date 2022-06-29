netsh advfirewall firewall add rule name="VDogAdminServer" dir=in action=allow protocol=TCP localport=64001
netsh advfirewall firewall add rule name="VDogCheckInCheckOutServer" dir=in action=allow protocol=TCP localport=64002
netsh advfirewall firewall add rule name="VDogScheduler" dir=in action=allow protocol=TCP localport=64003
netsh advfirewall firewall add rule name="VDogOsServer" dir=in action=allow protocol=TCP localport=64004
netsh advfirewall firewall add rule name="VDogReportingServer" dir=in action=allow protocol=TCP localport=64006
netsh advfirewall firewall add rule name="VDogUploadAgent" dir=in action=allow protocol=TCP localport=64010
netsh advfirewall firewall add rule name="VDogCompareAgent" dir=in action=allow protocol=TCP localport=64011
netsh advfirewall firewall add rule name="VDogGateway" dir=in action=allow protocol=TCP localport=64012
netsh advfirewall firewall add rule name="VDogSecureConnect" dir=in action=allow protocol=TCP localport=64021
netsh advfirewall firewall add rule name="VDogApi" dir=in action=allow protocol=TCP localport=64023

netsh advfirewall firewall add rule name="VDogWebServer" dir=in action=allow protocol=TCP localport=80
netsh advfirewall firewall add rule name="VDogWebServer" dir=in action=allow protocol=TCP localport=443
