#!/bin/bash
echo "What do you want to do?"
echo "Current Zone is : " && firewall-cmd --get-zones
echo "[1] Show Open Ports and Services	[2] Open Port	[3] Remove Port	[4] Add Service	[5] Remove Service"
read dec
echo "What Zone do you want to edit"
read zone
while [ $dec -lt 6 ]
do 

case "$dec" in
		1)
		firewall-cmd --zone=$zone --list-services
		firewall-cmd --zone=$zone --list-ports
		;;
		2)
		echo "Which port should be opened? Example input: 443/tcp"
		read port
		firewall-cmd --zone=$zone --add-port=$port --permanent
		echo "Port "$port" opened!" >> /var/log/firwallchanges
		;;
		3)
		echo "Which port should be closed? Example input: 443/tcp"
		read port
		firewall-cmd --zone=$zone --remove-port=$port --permanent
		echo "Port "$port "closed!" >> /var/log/firwallchanges
		;;
		4)
		echo "Which service should be added?"
		read service
		firewall-cmd --zone=$zone --add-service=$service
		echo $service" access granted!" >> /var/log/firwallchanges
		;;
		5)
		echo "Which service should be blocke?"
		read service
		firewall-cmd --zone=$zone --remove-service=$service
		echo $service " removed!" >> /var/log/firwallchanges
		;;
		*)
exit 1
esac

echo "[1] Show Open Ports and Services  [2] Open Port   [3] Remove Port [4] Add Service [5] Remove Service [6] EXIT"
read dec
done

firewall-cmd --reload
echo "Firewall reload succesfull!"

