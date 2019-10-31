#!/usr/bin/env bash
#
#Description:script that creates an ssh tunnel to access remote servers
#
#Author: Luca Radaelli <lradaelli85@users.noreply.github.com>

SSH=`which ssh`
dst_srv_port=""
local_port=""
local_bind_ip="127.0.0.1"
remote_port=""
destination_server=""


while [ -z "$destination_server" ]
do
read -p "insert the ip address or the hostname of the DESTINATION SERVER : " destination_server
done

until [[ "$dst_srv_port" =~ ^-?[0-9]+$ ]] && [ "$dst_srv_port" -ge 1 ] && [ "$dst_srv_port" -le 65535 ]
do
read -p "insert the REMOTE PORT of the destination server that you want to connect to: " dst_srv_port
done

until [[ "$local_port" =~ ^-?[0-9]+$ ]] && [ "$local_port" -ge 1 ] && [ "$local_port" -le 65535 ]
do
read -p "insert LOCAL PORT [hint use a port between 1025 and 65535]: " local_port
done

while [ -z "$ssh_user" ]
do
read -p "insert SSH PROXY USER for the SSH PROXY authentication: " ssh_user
done

while [ -z "$ssh_proxy" ]
do
read -p "insert the ip address or the hostname of the SSH PROXY: " ssh_proxy
done

until [[ "$remote_port" =~ ^-?[0-9]+$ ]] && [ "$remote_port" -ge 1 ] && [ "$remote_port" -le 65535 ]
do
read -p "insert the SSH PROXY PORT : " remote_port
done

$SSH -N -L $local_bind_ip:$local_port:$destination_server:$dst_srv_port $ssh_user@$ssh_proxy -p $remote_port
