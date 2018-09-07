# Geoffrey Kanteles
# Lab 1 Powershell script for CSEC464
# Literally my first ever powershell script, so buckle up.
# NOTE: I tried to implement writing to a CSV, but my output
# wasn't the actual output of the commands. Some issue I couldn't solve.
# Submitting like this so that at least when it runs, the output will
# appear in powershell.


$date = Get-Date
$zone = Get-TimeZone
$os = Get-WmiObject win32_operatingsystem
$uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance CIM_Processor
$ram = Get-CimInstance CIM_ComputerSystem
$FQDN = (Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain
$task = Get-ScheduledTask

""
"----Time----"

"Date: " + $date
"Timezone: " + $zone
"Uptime: " + $uptime.Days + " days, " + $uptime.Hours + " hours, " + $uptime.Minutes + " minutes"
""

"----OS----"
"OS: " + $os.Caption
"Version: " + $os.Version
"Major Ver.: " + $os.ServicePackMajorVersion
"Minor Ver.: " + $os.ServicePackMinorVersion

""

"----Hardware----"
"CPU: " + $cpu.Name
"RAM: " + ($ram.TotalPhysicalMemory/1GB) + "GB"
""
"Drives:"
Get-PSDrive -PSProvider FileSystem
""

"----Hostname & Domain----"
"FQDN: " + $FQDN
""

"----Users----"
"--Local"
Get-WmiObject Win32_UserAccount
#"--Domain"
""

"----Boot----"
Get-CimInstance Win32_StartupCommand
""

"----Tasks----"
Get-ScheduledTask | Select State, TaskName
""

"----Network----"
"--ARP"
arp -a
""
"--Interfaces"
Get-NetIPConfiguration | Select InterfaceAlias, InterfaceIndex, IPv6Address, IPv4Address, IPv6DefaultGateway, IPv4DefaultGateway, DnsServer
""
"--Routing table"
Get-WmiObject -Class Win32_IP4RouteTable
""
"--DNS"
Get-DnsClientServerAddress | Select ElementName, ServerAddresses
""
"--DHCP"
Get-WmiObject Win32_NetworkAdapterConfiguration
""
"--Listening Services"
netstat -ano
""
"--Network Shares/Printers/Wifi"
Get-WmiObject Win32_Share
""
Get-WmiObject Win32_Printer
""
netsh wlan show network
""
"----Installed Programs----"
Get-WmiObject win32_product
""
"----Processes----"
Get-Process
""
"----Drivers----"
Get-WmiObject Win32_PnPSignedDriver| Select DeviceName, DriverDate, DriverVersion, Manufacturer, Location
""
"----Files----"
"--Documents"
Get-ChildItem C:\Users\*\Documents\*
""
"--Downloads"
Get-ChildItem C:\Users\*\Downloads\*
""
"----3 Additions----"
"--Connection Test"
Test-Connection google.com
""
"--Clipboard Dump"
Get-Clipboard
""
"History Dump"
Get-History