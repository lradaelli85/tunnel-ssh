# tunnel-ssh
This is a simple script that allows you to create an SSH tunel.
This is an interactive script,below a little explanation of terms used:

-ssh server  [ssh proxy]         : ssh server to use for the connection to the remote host

-remote host [destination server]: host that you want to connect to using ssh host

Note: on ssh server you should set AllowTcpForwarding to yes.
If you need to tunnel the connection through the ssh server,you have to open a connection to your localhost ip on the port that you have choosen as local port.

