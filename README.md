# Mini project for CS655
##### Experiment 5: 
Run iperf3 on server side
```console 
$sudo iperf3 -s
```
Run following command on client side to generate json file in order to generate graph later
```console 
$sudo iperf3 -C reno -c 10.10.4.1 -i 0.1 -J -t 10 | tee iperf3.json
```
Install required R library first if not installed using following format
```console
install.packages('#packege_name')
```
Run Rscript to generate graph based on previous json file
```console 
$sudo Rscript visual.R
```
