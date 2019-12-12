# Mini project for CS655
## Performance Comparison of various TCP versions
### Setup Diagram:
![setup diagram1](https://github.com/SelinaXQ/Mini-project/blob/master/archDiagram1.png)

![setup diagram2](https://github.com/SelinaXQ/Mini-project/blob/master/archDiagram2.png)
### Experiment 1:
#### (1) Install iperf & iperf3: 
Login to node PC1 and PC2
```console 
$sudo sh download.sh
``` 
#### (2) Setting the TCP version: 
Check the TCP version on PC1 and PC2 use 
```console 
$cat /proc/sys/net/ipv4/tcp_congestion_control
```
Change to specific version, such as Reno, Cubic or Vegas:
```console 
$sudo sysctl net.ipv4.tcp_congestion_control=cubic
```
Check if using Selective Repeat:
```console
$cat /proc/sys/net/ipv4/tcp_sack
```
If output ‘1’, means sack is enabled; if 0, use the following command to modify:
```console 
$sudo sysctl net.ipv4.tcp_sack=1
```

#### (3) Running iperf and do the experiment: 
Use PC2 as server, run the following command on the server to wait for client connection:
```console 
$iperf -s
```
Run the following command on PC1 as client to connect:
```console 
$iperf -c pc2 –t 50
```
Adjust link characteristics with no loss or corruption on node delay:
```console 
$sudo tc qdisc add dev eth1 root netem delay 5ms loss 0.0%
$sudo tc qdisc add dev eth2 root netem delay 5ms loss 0.0%
```
Adjust link characteristics with delay and loss
Set link parameters to 5ms delay and 0.01% packet loss (plr = 0.0001) and specify the same link parameters in the opposite direction:
```console 
$sudo tc qdisc add dev eth1 root netem delay 5ms loss 0.01%
$sudo tc qdisc add dev eth1 root netem delay 5ms loss 0.01%
```
Delete the rules:
```console 
$sudo tc qdisc del dev eth1 root netem 
$sudo tc qdisc del dev eth2 root netem
```
Adjust link characteristics with delay and corruption
Set link parameters to 5ms delay and 0.01% packet corruption (plr = 0.0001) and specify the same link parameters in the opposite direction:  
```console 
$sudo tc qdisc add dev eth1 root netem delay 5ms corrupt 0.01%
$sudo tc qdisc add dev eth1 root netem delay 5ms corrupt 0.01%
```
### Experiment 2:
Login to server and client node
Set the delay to 50ms on server side, run 
```console 
$sudo tc qdisc add dev eth1 root netem delay 50ms
```
Change window size to 2KB

On server side, run 
```console  
$iperf –s -w 2KB 
``` 
On client side, run 
```console 
$iperf –c server ‐t 10 -w 2KB 
```
Delete tc rules before change the delay, run 
```console  
$sudo tc qdisc del dev eth1 root 
```
Repeat previous steps with different delay and window size.


### Experiment 3: 
Using instruction in Experiment 1 to select TCP flavor and change delay, loss, and corruption. 

Run iperf3 on the server-side
```console 
$sudo iperf3 -s
```
Run following command on the client-side to generate json file in order to generate graph later

-i means interval, change 10.10.4.1 to corresponding server ip, -t means total time
```console 
$sudo iperf3 -C reno -c 10.10.4.1 -i 0.1 -J -t 10 | tee iperf3.json
```
Install required R library first if not installed using the following format
```console
install.packages('#packege_name')
```
Run Rscript to generate graph based on previous json file
```console 
$sudo Rscript visual.r
```
