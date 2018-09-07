#!/bin/bash
# Geoffrey Kanteles
# CSEC464 Lab 1 Bash Script
# Collects system artifacts
# Literally my first bash script, buckle up.

time=$(date +"%H:%M:%S") # get current time from date in H:M:S format
timezone=$(date +"%Z %z") # get alphabetical timezone code and offset from date
uptime=$(uptime -p | cut -d " " -f2-) # get uptime from uptime
hostname=$(hostname)
fqdn=$(hostname -f)
domain=$(domainname)
localusr=$(cut -d: -f 1,3 /etc/passwd)
login=$(last) # WARN: messy
arp=$(arp -a)
intmac=$(ip -o link | awk '{print $2,$17}')
route=$(ip route list)
intip=$(ip a | awk '{print $2,$16}')
dhcp=$(cat /var/lib/dhcp3/dhclient.leases)
dns=$(cat /etc/resolv.conf)
gateway=$(/sbin/ip route | awk '/default/ {print $3}')
ports=$(lsof -i) # i very sorry about this - not sure how to fix the formatting
network=$(mount) # very, very sorry
compgen=$(compgen -c)
ps=$(ps -A)
lsmod=$(lsmod)
docs=$(ls /home/*/Documents/)
down=$(ls /home/*/Downloads)
history=$(history)
cal=$(cal)
du=$(du)

function osver {
	echo $(lsb_release -a | grep 'Description')
	echo "Kernel version:" $(uname -a | awk {'print $3'})
}
function cpuinfo {
	echo "--CPU"
	echo $(lscpu | grep 'Model name')
	echo $(lscpu | grep 'Architecture')
}
function meminfo {
	echo "--RAM"
	echo "Total:" $(grep 'MemTotal' /proc/meminfo | awk '{print $2 " " $3}')
}
function storeinfo {	 # WARN: placeholder lacking actual output
	echo "--Storage"
	echo $(fdisk -l) #TODO: clean up output
	echo $(findmnt -l)  #TODO: clean up output
}
#function ip {
#	echo "Interface IPs:"

echo "----TIME----" >> output.csv 
echo "Current time: " $time >> output.csv
echo "System time zone: " $timezone >> output.csv
echo "System uptime: " $uptime >> output.csv
echo >> output.csv
echo "----OS----" >> output.csv
osver >> output.csv
echo >> output.csv
echo "----Hardware----" >> output.csv
cpuinfo >> output.csv
meminfo >> output.csv
storeinfo >> output.csv
echo >> output.csv
echo "----Network----" >> output.csv
echo "Hostname:" $hostname >> output.csv
echo "Domain:" $domain >> output.csv
echo "FQDN:" $fqdn >> output.csv
echo >> output.csv
echo "----Users----" >> output.csv
echo "Local Users:" >> output.csv
printf "\t%s\n" $localusr >> output.csv
echo "Login History:" >> output.csv
printf "\t%s" $login >> output.csv
echo >> output.csv
echo "----Network----" >> output.csv
echo "ARP Table:" $arp >> output.csv
echo >> output.csv
echo "Interface MAC Addresses:" >> output.csv
printf "\t%s\n" $intmac >> output.csv
echo >> output.csv
echo "Routing Table: " >> output.csv
printf "\t%s" $route >> output.csv
echo >> output.csv
echo "Interfaces: " $intip >> output.csv
echo >> output.csv
echo "DHCP server: " $dhcp >> output.csv
echo "DNS server: " $dns >> output.csv
echo "Default gateway: " $gateway >> output.csv
echo "Ports: " $ports >> output.csv
echo >> output.csv
echo "----Network Shares/Printers/Wifi----" >> output.csv
echo $network >> output.csv
echo >> output.csv
echo "----Installed Software----" >> output.csv
echo $compgen >> output.csv
echo >> output.csv
echo "----Processes----" >> output.csv
echo >> output.csv
echo $ps >> output.csv
echo >> output.csv
echo "----Drivers----" >> output.csv
echo >> output.csv
echo $lsmod >> output.csv
echo >> output.csv
echo "----Documents----" >> output.csv
echo >> output.csv
echo $docs >> output.csv
echo >> output.csv
echo "----Downloads----" >> output.csv
echo >> output.csv
echo $down >> output.csv
echo >> output.csv
echo "----Three Additional----" >> output.csv
echo >> output.csv
echo $history >> output.csv
echo >> output.csv
echo $du >> output.csv
echo >> output.csv
echo $cal >> output.csv
