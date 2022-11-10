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
vlesslink1="vless://${uuid}@ufuture.uitm.edu.my:443?path=wss%3A%2F%2Fufuture.uitm.edu.my%2Fxray-vlessws-tls&sni=ufuture.uitm.edu.my&host=${domain}&security=tls&encryption=none&type=ws&sni=ufuture.uitm.edu.my#${user}"
vlesslink2="vless://${uuid}@www.ukm.my.${domain}:$none?path=/xray-vlessws-none-tls&encryption=none&host=app.maxis.com.my&type=ws#${user}"
vlesslink3="vless://${uuid}@onlinepayment.celcom.com.my:443?path=wss%3A%2F%2Fonlinepayment.celcom.com.my%2Fxray-vlessws-tls&sni=onlinepayment.celcom.com.my&host=${domain}&security=tls&encryption=none&type=ws&sni=onlinepayment.celcom.com.my#${user}"
vlesslink4="vless://${uuid}@tv.iqiyi.site:$none?path=/xray-vlessws-none-tls&encryption=none&host=${domain}&type=ws#${user}"
vlesslink5="vless://${uuid}@m.pokemon.com.${domain}:443?path=/xray-vlessws-tls&sni=m.pokemon.com&host=m.pokemon.com&security=tls&encryption=none&type=ws&sni=m.pokemon.com#${user}"
vlesslink6="vless://${uuid}@cdn.who.int:$none?path=wss%3A%2F%2Fcdn.who.int%2Fxray-vlessws-none-tls&encryption=none&host=${domain}&type=ws#${user}"
vlesslink7="vless://${uuid}@${sts}${domain}:443?path=/xray-vlessws-tls&sni=maingame.com.my&host=maingame.com.my&security=tls&encryption=none&type=ws&sni=maingame.com.my#${user}"
vlesslink8="vless://${uuid}@esports.pubgmobile.com.${domain}:443?path=/xray-vlessws-tls&sni=esports.pubgmobile.com&host=esports.pubgmobile.com&security=tls&encryption=none&type=ws&sni=esports.pubgmobile.com#${user}"
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
echo -e "\e[$line════════════════════════\e[m"
echo -e " ✓ MAXIS TANPA LANGGAN✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink1}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ MAXIS HUNT IP✓ " 
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink2}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ CELCOM TANPA LANGGAN✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink3}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ DIGI BOOSTER✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink4}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ DIGI POKEMON✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink5}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ YESS TANPA LANGGAN✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink6}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ UMOBILE TANPA LANGGAN✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink7}"
echo -e "\e[$line════════════════════════\e[m"
echo -e "✓ YOODO GAME & UMOBILE✓ "
echo -e "\e[$line════════════════════════\e[m"
echo     " ${vlesslink8}"
echo -e "\e[$line════════════════════════\e[m"
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