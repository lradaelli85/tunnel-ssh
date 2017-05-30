#!/bin/bash
#Description:script that create an ssh tunnel
#Author: Luca Radaelli <lradaelli85@users.noreply.github.com>

SSH=`which ssh`
dst_srv_port="0"
local_port="0"
remote_port="0"

while [ -z "$destination_server" ]; do
read -p "insert the ip address or the hostname of the destination server: " destination_server
done

until [[ "$dst_srv_port" =~ ^-?[0-9]+$ ]] && [ "$dst_srv_port" -ge 1 ] && [ "$dst_srv_port" -le 65535 ]; do
read -p "insert the ports of the destination server that you want to connect to: " dst_srv_port
done

until [[ "$local_port" =~ ^-?[0-9]+$ ]] && [ "$local_port" -ge 1 ] && [ "$local_port" -le 65535 ]; do
read -p "insert local port to use [hint use a port between 1025 and 65535]: " local_port
done

while [ -z "$ssh_user" ]; do
read -p "insert ssh user to use for the ssh proxy connection: " ssh_user
done

while [ -z "$ssh_proxy" ]; do
read "insert the ip address or the hostname of the ssh proxy: " ssh_proxy
done

until [[ "$remote_port" =~ ^-?[0-9]+$ ]] && [ "$remote_port" -ge 1 ] && [ "$remote_port" -le 65535 ]; do
read -p "insert the port of the ssh proxy to use for ssh connection: "remote_port
done

$SSH -N -L $local_port:$destination_server:$dst_srv_port $ssh_user@$ssh_proxy -p $remote_port
