Executables for "COINN: Crypto/ML Codesign for Oblivious Inference via Neural Networks"

## simulating bandwidth
simulate latency and bandwidth by running ```bash simulate_lan.sh``` or ```bash simulate_lan.sh```.

## running oblivious inference
Run the following commands. Be sure to replace ```NETWORK``` with one of the four benchmarks available inside ```bash_files```.
- ```cd bash_files/NETWORK/server```
- ```bash commands.sh```
- open another terminal, cd to the COINN directory
- ```cd bash_files/NETWORK/client```
- ```bash commands.sh > ../../../timing_reports/NETWORK.txt```
- The script will run, and layer-wise runtimes will be written to ```timing_reports/NETWORK.txt```.
## summarizing runtimes
after running all networks, run the following to summarize the runtimes:
- ```python3 summarize_results timing_reports```
- The summary will be produced at ```timing_reports/summary.csv```