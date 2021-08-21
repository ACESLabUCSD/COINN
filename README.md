Executables for "COINN: Crypto/ML Codesign for Oblivious Inference via Neural Networks"

## simulating bandwidth
simulate latency and bandwidth by running ```bash simulate_lan.sh``` or ```bash simulate_lan.sh```.
## downloading files
download files [here](https://drive.google.com/file/d/1ow3WqRm4FYok2Kxgq4Ob8wWNLVgZxJPI/view?usp=sharing) and extract them.
## setting up docker container
download the docker container (siam please put instructions)

copy the bash_files into the docker container:

```docker cp bash_files coinn:/home/_COINN_/```

## starting the docker container
```docker container start coinn```

```docker container attach coinn```

once attached to the docker:

```cd home/_COINN_```

## splitting the terminal
use tmux to split the teminal in two as follows:
- run ```tmux```
- press ```ctrl+b```, then ```shift+quotation mark (")```. the terminal will be split in two.
- press ```ctrl+b```, then ```up``` or ```down``` to navigate between splitted terminals


## running oblivious inference
In the first terminal, run the following commands. Be sure to replace ```NETWORK``` with one of the four benchmarks available inside ```bash_files```.
- ```cd bash_files/NETWORK/server```
- ```bash commands_setup.sh``` (the first time you run inference) or  ```bash commands.sh``` (from the second time on).

Navigate to the other terminal and run the following:
- ```cd bash_files/NETWORK/client```
- ```bash commands_setup.sh > ../../../timing_reports/NETWORK.txt``` or ```bash commands.sh > ../../../timing_reports/NETWORK.txt```.
- The script will run, and layer-wise runtimes will be written to ```timing_reports/NETWORK.txt```.
## summarizing runtimes
after running all networks, run the following to summarize the runtimes:
- ```python3 summarize_results timing_reports```
- The summary will be produced at ```timing_reports/summary.csv```