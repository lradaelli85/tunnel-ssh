# tunnel-ssh
This is a simple script that allows you to create an SSH tunel.
This is an interactive script,below an explanation of used terms:

-LOCAL PORT         : port that will be used on local host to open a connection to DESTINATION SERVER REMOTE PORT

-SSH PROXY          : ssh server that forwards connections to DESTINATION SERVER

-SSH PROXY USER     : ssh user used for SSH PROXY authentication

-SSH PROXY PORT     : SSH PROXY port where ssh daemon listen on

-DESTINATION SERVER : Host that you want to reach through SSH PROXY

-REMOTE PORT        : Port on DESTINATION SERVER that you want to connect to


# Example
Let's say that you want to open an HTTP connection to DESTINATION SERVER.
You need to bind on local host on a random port,here i have choose 2222.
Open an SSH connection to SSH PROXY on port 22 and then it forwards the connection to
port 80 of the DESTINATION SERVER
 


```
									   192.168.122.207							 10.10.10.1
+---------+	 						  +----------------+					 +----------------+
|         |	local         	ssh proxy |	  			   |			remote	 |				  |
|		  |	port: 2222 		port: 22  |	  SSH PROXY	   |			port: 80 |	DESTINATION	  |
+---------+  ------------------------ |				   | --------------------|	   SERVER	  |
\          \						  | 			   | 					 | 				  |
 +----------+						  +----------------+					 +----------------+



luca@linux:~$ ./tunnel.sh 
insert the ip address or the hostname of the DESTINATION SERVER : 10.10.10.1
insert the REMOTE PORT of the destination server that you want to connect to: 80
insert LOCAL PORT [hint use a port between 1025 and 65535]: 2222
insert SSH PROXY USER for the SSH PROXY authentication: luca
insert the ip address or the hostname of the SSH PROXY: 192.168.122.207
insert the SSH PROXY PORT : 22
luca@192.168.122.207's password: 

Once the password has been inserted,
in another terminal check if there is a TCP socket on port 2222

luca@linux:~$ sudo ss -ntl |grep 2222
LISTEN   0         128               127.0.0.1:2222             0.0.0.0:*        users:(("ssh",pid=10949,fd=5))


open the connection

luca@linux:~$ curl -v http://127.0.0.1:2222/test
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 2222 (#0)
> GET /test HTTP/1.1
> Host: 127.0.0.1:2222
> User-Agent: curl/7.58.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Thu, 31 Oct 2019 10:56:54 GMT
< Server: Apache
< Pragma: no-cache
< Cache-control: no-cache
< Content-Type: text/html;charset=utf-8
< Content-Length: 1758

```

# NOTE

On ssh server you must set AllowTcpForwarding to yes.

