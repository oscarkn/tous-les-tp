#!/srv/idcard/

# This is an ID card script. You must run this script as sudo and you must have curl installed.

machinename=$(hostname)
echo "Machine name : $machinename"

os=$(uname)
kernelversion=$(uname -r)
echo "OS $os and kernel version is $kernelversion "

machineip=$(ip a | grep enp0s8 | grep inet | cut -d " " -f6)
echo "IP : $machineip"

echo "RAM : $(cat /proc/meminfo | grep MemFree | cut -d" " -f12) kB/ $(cat /proc/meminfo | grep MemTotal | cut -d" " -f9) Ko"

echo "Disque : $(df -h | grep /dev/sda5 | cut -d" " -f12) left"

echo "Top 5 processes by RAM usage :"

echo "- $(ps --sort -rss -eo %mem,cmd,pid | head -1)"
echo "- $(ps --sort -rss -eo %mem,cmd,pid | head -2 | tail -n+2)"
echo "- $(ps --sort -rss -eo %mem,cmd,pid | head -3 | tail -n+3)"
echo "- $(ps --sort -rss -eo %mem,cmd,pid | head -4 | tail -n+4)"
echo "- $(ps --sort -rss -eo %mem,cmd,pid | head -5 | tail -n+5)"
echo "- $(ps --sort -rss -eo %mem,cmd,pid | head -6 | tail -n+6)"

echo "Listening ports :"
ss -alnpt | sed "1 d" | while read  line
do
        port=$(echo $line | tr -s ' ' | cut -d' ' -f4 | rev | cut -d':'  -f1 | rev)
	program=$(echo $line | tr -s ' ' | cut -d' ' -f6 | cut -d'"' -f2)
	echo "- $port : $program"
done
