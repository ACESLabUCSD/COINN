
# COINN: Crypto/ML Codesign for Oblivious Inference via Neural Networks
This repo contains the executables for benchmarking the runtime for oblivious inference through COINN. The executable is run inside a [docker](https://www.docker.com/).

## Start docker
```bash
docker pull siamumar/ubuntu18.04-coinn:first
docker run -it --cap-add=NET_ADMIN ubuntu18.04-coinn /bin/bash
cd home/_COINN_
```

## Download necessary files
inside ``/home/_COINN_``, clone the COINN repository:
```bash
git clone https://github.com/ACESLabUCSD/COINN.git
cp -rf COINN/bash_files .
```
A folder named ``bash_files`` will appear, which contains the commands needed to run for each neural network benchmark in the paper.

## Simulate LAN and WAN bandwidth
Run one of the follwing commands to simulate LAN or WAN bandwidth on `localhost`
```bash
bash simulate_lan.sh # LAN
bash simulate_wan.sh # WAN
```




## Split the terminal to run `server` and `client`
Use tmux to split the teminal in two as follows:
- run `tmux`
- press `ctrl + b`, then `shift + quotation mark (")`. the terminal will be split in two.
- press `ctrl + b`, then `up` or `down` arrows to navigate between splitted terminals.


## Run oblivious inference benchmarks
In the following commands, replace `<NETWORK>` with one from the list: `cifar10-BC1`, `cifar10-resnet110`, `cifar100-resnet32`, `imagenet-resnet50`.

In the `server` terminal, run 

```bash
cd bash_files/<NETWORK>/server
bash commands_setup.sh # the first time inference is run
bash commands.sh # from the second time on
```

In the `client` terminal, run 

```bash
cd bash_files/NETWORK/client
bash commands_setup.sh > ../../../timing_reports/NETWORK.txt # the first time inference is run
bash commands.sh > ../../../timing_reports/<NETWORK>.txt # from the second time on
```

The layer-wise runtimes are written to `timing_reports/<NETWORK>.txt`.

## Summarize runtimes
After running all networks, run the following to summarize the runtimes.

```bash
python3 summarize_results timing_reports
```
The summary is written to ```timing_reports/summary.csv```
