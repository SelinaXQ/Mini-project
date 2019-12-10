# Mini project for CS655
## Performance Comparison of various TCP versions
### Experiment 1: 
Run download.sh to install iperf and iperf3
```console 
$sudo sh download.sh
```
### Experiment 5: 
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
