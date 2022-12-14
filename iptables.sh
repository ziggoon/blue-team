iptables -N ACCEPT_LOG
iptables -A ACCEPT_LOG -j LOG --log-level 6 --log-prefix ':accept_log:'
iptables -A ACCEPT_LOG -j ACCEPT
iptables -N DROP_LOG
iptables -A DROP_LOG -j LOG --log-level 6 --log-prefix ':drop_log:'
iptables -A DROP_LOG -j DROP
iptables -A INPUT -p tcp -m multiport --dports #21,22,23,25,80,110,143,443,1526,4200,8000,8080 -m state --state NEW,ESTABLISHED -j ACCEPT_LOG
iptables -A OUTPUT -p tcp -m multiport --sports #21,22,23,25,80,110,143,443,1526,4200,8000,8080 -m state --state NEW,ESTABLISHED -j ACCEPT_LOG
iptables -A INPUT -p udp -m state --state NEW,ESTABLISHED -m multiport --dports 53,123 -j ACCEPT_LOG
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -m multiport --sports 53,123 -j ACCEPT_LOG
iptables -A INPUT -s 172.16.0.0/12 -j ACCEPT_LOG
iptables -A OUTPUT -d 172.16.0.0/12  -j ACCEPT_LOG
iptables -A OUTPUT -o lo  -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -F
iptables -A INPUT -j DROP_LOG
iptables -A OUTPUT -j DROP_LOG
