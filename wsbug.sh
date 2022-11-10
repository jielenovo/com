#!/bin/bash
BGGREEN='\e[1;42'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
BGRED='\e[1;41m'
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
echo -e ""
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}                     ┃ V2RAY/VLESS ┃                              ${NC}"
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/v2ray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
read -p "SNI (BUG)     : " sni
read -p "Bug Address (Example: www.google.com) : " sub
dom=$sub$domain
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vnone.json
vlesslink1="vless://${uuid}@${dom}:$tls?path=/v2ray&security=tls&encryption=none&type=ws&sni=$sni#${user}"
vlesslink2="vless://${uuid}@${dom}:$none?path=/v2ray&encryption=none&type=ws&sni=$sni#${user}"
systemctl restart v2ray@vless
systemctl restart v2ray@vnone
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e ""
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}                     ┃ V2RAY/VLESS ┃                              ${NC}"
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks        : ${user}"
echo -e "IP Server      : $MYIP"
echo -e "Domain         : ${domain}"
echo -e "Subdomain      : ${dom}"
echo -e "port TLS       : $tls"
echo -e "port none TLS  : $none"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "network        : ws"
echo -e "path           : /v2ray"
echo -e "SNI            : $sni"
echo -e " ${ORANGE}=================================${NC}"
echo -e "link TLS       : ${vlesslink1}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "link none TLS  : ${vlesslink2}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Created   : $hariini"
echo -e "Expired   : $exp"
# MENU VLESS WS
echo -e "\e[0m                                                       "
echo -e "\e[94m    .----------------------------------------------------.    "
echo -e "\e[94m    |                    V2RAY VLESS MENU                |    "
echo -e "\e[94m    '----------------------------------------------------'    "
echo -e ""
echo -e "$RED VLess Non TLS      : $(grep -c -E "^###" "/etc/v2ray/vnone.json")${NC}"
echo -e "$RED VLess TLS          : $(grep -c -E "^###" "/etc/v2ray/vless.json")${NC}"
echo -e ""
echo -e "\e[1;31m* [1]\e[0m \e[1;32m: Create V2RAY Vless Websocket Account\e[0m"
echo -e "\e[1;31m* [2]\e[0m \e[1;32m: Deleting V2RAY Vless Websocket Account\e[0m"
echo -e "\e[1;31m* [3]\e[0m \e[1;32m: Extending VLESS Account Active Life\e[0m"
echo -e "\e[1;31m* [4]\e[0m \e[1;32m: Check User Login V2RAY VLESS\e[0m"
echo -e ""
echo -e ""
read -p "        Select From Options [1-4 or x]: " menuvless
echo -e ""
case $menuvless in
1)
add-vless
;;
2)
del-vless
;;
3)
renew-vless
;;
4)
cek-vless
;;
x)
menu
;;
*)
echo " Please enter an correct number!!"
;;
esac