#!/bin/bash
onni_path="../../../onni"
files_path="."
$onni_path/bin/onni -f 1 --bins 8 -i 3 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-0-CONV/ --layerid 0
cp $files_path/layer-0-CONV/layer_0_OutputB.txt $files_path/layer-1-RELU/layer_1_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 8 --br 7 --sup  -k 2 -t 4 --dir $files_path/layer-1-RELU/ --layerid 1
cp $files_path/layer-1-RELU/layer_1_OutputB.txt $files_path/layer-2-BasicBlock/CONV1/layer_2_InputB.txt
$onni_path/bin/onni -f 1 --bins 12 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-2-BasicBlock/CONV1/ --layerid 2
cp $files_path/layer-2-BasicBlock/CONV1/layer_2_OutputB.txt $files_path/layer-2-BasicBlock/RELU1/layer_2_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 8 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-2-BasicBlock/RELU1/ --layerid 2
cp $files_path/layer-2-BasicBlock/RELU1/layer_2_OutputB.txt $files_path/layer-2-BasicBlock/CONV2/layer_2_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-2-BasicBlock/CONV2/ --layerid 2
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-2-BasicBlock/CONV1/layer_2_InputB.txt --y_path $files_path/layer-2-BasicBlock/CONV2/layer_2_OutputB.txt --out_path $files_path/layer-2-BasicBlock/RELU2/layer_2_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 4 --sup  -k 2 -t 4 --dir $files_path/layer-2-BasicBlock/RELU2/ --layerid 2
cp $files_path/layer-2-BasicBlock/RELU2/layer_2_OutputB.txt $files_path/layer-3-BasicBlock/CONV1/layer_3_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-3-BasicBlock/CONV1/ --layerid 3
cp $files_path/layer-3-BasicBlock/CONV1/layer_3_OutputB.txt $files_path/layer-3-BasicBlock/RELU1/layer_3_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 7 --br 8 --sup  -k 2 -t 4 --dir $files_path/layer-3-BasicBlock/RELU1/ --layerid 3
cp $files_path/layer-3-BasicBlock/RELU1/layer_3_OutputB.txt $files_path/layer-3-BasicBlock/CONV2/layer_3_InputB.txt
$onni_path/bin/onni -f 1 --bins 13 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-3-BasicBlock/CONV2/ --layerid 3
python3 run_residual.py --multiplier 8 --num_bits_act 16 --x_path $files_path/layer-3-BasicBlock/CONV1/layer_3_InputB.txt --y_path $files_path/layer-3-BasicBlock/CONV2/layer_3_OutputB.txt --out_path $files_path/layer-3-BasicBlock/RELU2/layer_3_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 11 --br 2 --sup  -k 2 -t 4 --dir $files_path/layer-3-BasicBlock/RELU2/ --layerid 3
cp $files_path/layer-3-BasicBlock/RELU2/layer_3_OutputB.txt $files_path/layer-4-BasicBlock/CONV1/layer_4_InputB.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-4-BasicBlock/CONV1/ --layerid 4
cp $files_path/layer-4-BasicBlock/CONV1/layer_4_OutputB.txt $files_path/layer-4-BasicBlock/RELU1/layer_4_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 5 --br 10 --sup  -k 2 -t 4 --dir $files_path/layer-4-BasicBlock/RELU1/ --layerid 4
cp $files_path/layer-4-BasicBlock/RELU1/layer_4_OutputB.txt $files_path/layer-4-BasicBlock/CONV2/layer_4_InputB.txt
$onni_path/bin/onni -f 1 --bins 14 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-4-BasicBlock/CONV2/ --layerid 4
python3 run_residual.py --multiplier 2 --num_bits_act 16 --x_path $files_path/layer-4-BasicBlock/CONV2/layer_4_OutputB.txt --y_path $files_path/layer-4-BasicBlock/CONV1/layer_4_InputB.txt --out_path $files_path/layer-4-BasicBlock/RELU2/layer_4_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 1 --sup  -k 2 -t 4 --dir $files_path/layer-4-BasicBlock/RELU2/ --layerid 4
cp $files_path/layer-4-BasicBlock/RELU2/layer_4_OutputB.txt $files_path/layer-5-BasicBlock/CONV1/layer_5_InputB.txt
$onni_path/bin/onni -f 1 --bins 6 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-5-BasicBlock/CONV1/ --layerid 5
cp $files_path/layer-5-BasicBlock/CONV1/layer_5_OutputB.txt $files_path/layer-5-BasicBlock/RELU1/layer_5_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-5-BasicBlock/RELU1/ --layerid 5
cp $files_path/layer-5-BasicBlock/RELU1/layer_5_OutputB.txt $files_path/layer-5-BasicBlock/CONV2/layer_5_InputB.txt
$onni_path/bin/onni -f 1 --bins 3 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-5-BasicBlock/CONV2/ --layerid 5
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-5-BasicBlock/CONV1/layer_5_InputB.txt --y_path $files_path/layer-5-BasicBlock/CONV2/layer_5_OutputB.txt --out_path $files_path/layer-5-BasicBlock/RELU2/layer_5_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 8 --br 8 --sup  -k 2 -t 4 --dir $files_path/layer-5-BasicBlock/RELU2/ --layerid 5
cp $files_path/layer-5-BasicBlock/RELU2/layer_5_OutputB.txt $files_path/layer-6-BasicBlock/CONV1/layer_6_InputB.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-6-BasicBlock/CONV1/ --layerid 6
cp $files_path/layer-6-BasicBlock/CONV1/layer_6_OutputB.txt $files_path/layer-6-BasicBlock/RELU1/layer_6_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 4 --sup  -k 2 -t 4 --dir $files_path/layer-6-BasicBlock/RELU1/ --layerid 6
cp $files_path/layer-6-BasicBlock/RELU1/layer_6_OutputB.txt $files_path/layer-6-BasicBlock/CONV2/layer_6_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-6-BasicBlock/CONV2/ --layerid 6
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-6-BasicBlock/CONV1/layer_6_InputB.txt --y_path $files_path/layer-6-BasicBlock/CONV2/layer_6_OutputB.txt --out_path $files_path/layer-6-BasicBlock/RELU2/layer_6_InputB.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-6-BasicBlock/RELU2/ --layerid 6
cp $files_path/layer-6-BasicBlock/RELU2/layer_6_OutputB.txt $files_path/layer-7-BasicBlock/CONV1/layer_7_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 16 -o 32 -w 32 -g 3 --ba 16 -z 1 --stride 2 --sup  -k 2 -t 4 --dir $files_path/layer-7-BasicBlock/CONV1/ --layerid 7
cp $files_path/layer-7-BasicBlock/CONV1/layer_7_OutputB.txt $files_path/layer-7-BasicBlock/RELU1/layer_7_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 9 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-7-BasicBlock/RELU1/ --layerid 7
cp $files_path/layer-7-BasicBlock/RELU1/layer_7_OutputB.txt $files_path/layer-7-BasicBlock/CONV2/layer_7_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-7-BasicBlock/CONV2/ --layerid 7
cp $files_path/layer-7-BasicBlock/CONV1/layer_7_InputB.txt $files_path/layer-7-BasicBlock/CONV-Residual/layer_7_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 16 -o 32 -w 32 -g 1 --ba 16 -z 0 --stride 2 --sup  -k 2 -t 4 --dir $files_path/layer-7-BasicBlock/CONV-Residual/ --layerid 7
python3 run_residual.py --multiplier 2 --num_bits_act 16 --x_path $files_path/layer-7-BasicBlock/CONV-Residual/layer_7_OutputB.txt --y_path $files_path/layer-7-BasicBlock/CONV2/layer_7_OutputB.txt --out_path $files_path/layer-7-BasicBlock/RELU2/layer_7_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-7-BasicBlock/RELU2/ --layerid 7
cp $files_path/layer-7-BasicBlock/RELU2/layer_7_OutputB.txt $files_path/layer-8-BasicBlock/CONV1/layer_8_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-8-BasicBlock/CONV1/ --layerid 8
cp $files_path/layer-8-BasicBlock/CONV1/layer_8_OutputB.txt $files_path/layer-8-BasicBlock/RELU1/layer_8_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 6 --br 9 --sup  -k 2 -t 4 --dir $files_path/layer-8-BasicBlock/RELU1/ --layerid 8
cp $files_path/layer-8-BasicBlock/RELU1/layer_8_OutputB.txt $files_path/layer-8-BasicBlock/CONV2/layer_8_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-8-BasicBlock/CONV2/ --layerid 8
python3 run_residual.py --multiplier 16 --num_bits_act 16 --x_path $files_path/layer-8-BasicBlock/CONV1/layer_8_InputB.txt --y_path $files_path/layer-8-BasicBlock/CONV2/layer_8_OutputB.txt --out_path $files_path/layer-8-BasicBlock/RELU2/layer_8_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 4 --sup  -k 2 -t 4 --dir $files_path/layer-8-BasicBlock/RELU2/ --layerid 8
cp $files_path/layer-8-BasicBlock/RELU2/layer_8_OutputB.txt $files_path/layer-9-BasicBlock/CONV1/layer_9_InputB.txt
$onni_path/bin/onni -f 1 --bins 12 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-9-BasicBlock/CONV1/ --layerid 9
cp $files_path/layer-9-BasicBlock/CONV1/layer_9_OutputB.txt $files_path/layer-9-BasicBlock/RELU1/layer_9_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 11 --br 3 --sup  -k 2 -t 4 --dir $files_path/layer-9-BasicBlock/RELU1/ --layerid 9
cp $files_path/layer-9-BasicBlock/RELU1/layer_9_OutputB.txt $files_path/layer-9-BasicBlock/CONV2/layer_9_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-9-BasicBlock/CONV2/ --layerid 9
cp $files_path/layer-9-BasicBlock/CONV2/layer_9_OutputB.txt $files_path/layer-9-BasicBlock/RELU2/layer_9_InputB.txt
cp $files_path/layer-9-BasicBlock/CONV1/layer_9_InputB.txt $files_path/layer-9-BasicBlock/RELU2/layer_9_InputRB.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 9 --br 7 --bs 10 --bl 7 --sup  -k 2 -t 4 --dir $files_path/layer-9-BasicBlock/RELU2/ --layerid 9
cp $files_path/layer-9-BasicBlock/RELU2/layer_9_OutputB.txt $files_path/layer-10-BasicBlock/CONV1/layer_10_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-10-BasicBlock/CONV1/ --layerid 10
cp $files_path/layer-10-BasicBlock/CONV1/layer_10_OutputB.txt $files_path/layer-10-BasicBlock/RELU1/layer_10_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 8 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-10-BasicBlock/RELU1/ --layerid 10
cp $files_path/layer-10-BasicBlock/RELU1/layer_10_OutputB.txt $files_path/layer-10-BasicBlock/CONV2/layer_10_InputB.txt
$onni_path/bin/onni -f 1 --bins 4 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-10-BasicBlock/CONV2/ --layerid 10
python3 run_residual.py --multiplier 8 --num_bits_act 16 --x_path $files_path/layer-10-BasicBlock/CONV1/layer_10_InputB.txt --y_path $files_path/layer-10-BasicBlock/CONV2/layer_10_OutputB.txt --out_path $files_path/layer-10-BasicBlock/RELU2/layer_10_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 2 --sup  -k 2 -t 4 --dir $files_path/layer-10-BasicBlock/RELU2/ --layerid 10
cp $files_path/layer-10-BasicBlock/RELU2/layer_10_OutputB.txt $files_path/layer-11-BasicBlock/CONV1/layer_11_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-11-BasicBlock/CONV1/ --layerid 11
cp $files_path/layer-11-BasicBlock/CONV1/layer_11_OutputB.txt $files_path/layer-11-BasicBlock/RELU1/layer_11_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 11 --br 4 --sup  -k 2 -t 4 --dir $files_path/layer-11-BasicBlock/RELU1/ --layerid 11
cp $files_path/layer-11-BasicBlock/RELU1/layer_11_OutputB.txt $files_path/layer-11-BasicBlock/CONV2/layer_11_InputB.txt
$onni_path/bin/onni -f 1 --bins 5 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-11-BasicBlock/CONV2/ --layerid 11
python3 run_residual.py --multiplier 32 --num_bits_act 16 --x_path $files_path/layer-11-BasicBlock/CONV1/layer_11_InputB.txt --y_path $files_path/layer-11-BasicBlock/CONV2/layer_11_OutputB.txt --out_path $files_path/layer-11-BasicBlock/RELU2/layer_11_InputB.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 9 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-11-BasicBlock/RELU2/ --layerid 11
cp $files_path/layer-11-BasicBlock/RELU2/layer_11_OutputB.txt $files_path/layer-12-BasicBlock/CONV1/layer_12_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 32 -o 64 -w 16 -g 3 --ba 16 -z 1 --stride 2 --sup  -k 2 -t 4 --dir $files_path/layer-12-BasicBlock/CONV1/ --layerid 12
cp $files_path/layer-12-BasicBlock/CONV1/layer_12_OutputB.txt $files_path/layer-12-BasicBlock/RELU1/layer_12_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 9 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-12-BasicBlock/RELU1/ --layerid 12
cp $files_path/layer-12-BasicBlock/RELU1/layer_12_OutputB.txt $files_path/layer-12-BasicBlock/CONV2/layer_12_InputB.txt
$onni_path/bin/onni -f 1 --bins 11 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-12-BasicBlock/CONV2/ --layerid 12
cp $files_path/layer-12-BasicBlock/CONV1/layer_12_InputB.txt $files_path/layer-12-BasicBlock/CONV-Residual/layer_12_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 32 -o 64 -w 16 -g 1 --ba 16 -z 0 --stride 2 --sup  -k 2 -t 4 --dir $files_path/layer-12-BasicBlock/CONV-Residual/ --layerid 12
python3 run_residual.py --multiplier 1 --num_bits_act 16 --x_path $files_path/layer-12-BasicBlock/CONV2/layer_12_OutputB.txt --y_path $files_path/layer-12-BasicBlock/CONV-Residual/layer_12_OutputB.txt --out_path $files_path/layer-12-BasicBlock/RELU2/layer_12_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 8 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-12-BasicBlock/RELU2/ --layerid 12
cp $files_path/layer-12-BasicBlock/RELU2/layer_12_OutputB.txt $files_path/layer-13-BasicBlock/CONV1/layer_13_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-13-BasicBlock/CONV1/ --layerid 13
cp $files_path/layer-13-BasicBlock/CONV1/layer_13_OutputB.txt $files_path/layer-13-BasicBlock/RELU1/layer_13_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-13-BasicBlock/RELU1/ --layerid 13
cp $files_path/layer-13-BasicBlock/RELU1/layer_13_OutputB.txt $files_path/layer-13-BasicBlock/CONV2/layer_13_InputB.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-13-BasicBlock/CONV2/ --layerid 13
python3 run_residual.py --multiplier 128 --num_bits_act 16 --x_path $files_path/layer-13-BasicBlock/CONV1/layer_13_InputB.txt --y_path $files_path/layer-13-BasicBlock/CONV2/layer_13_OutputB.txt --out_path $files_path/layer-13-BasicBlock/RELU2/layer_13_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 11 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-13-BasicBlock/RELU2/ --layerid 13
cp $files_path/layer-13-BasicBlock/RELU2/layer_13_OutputB.txt $files_path/layer-14-BasicBlock/CONV1/layer_14_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-14-BasicBlock/CONV1/ --layerid 14
cp $files_path/layer-14-BasicBlock/CONV1/layer_14_OutputB.txt $files_path/layer-14-BasicBlock/RELU1/layer_14_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 9 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-14-BasicBlock/RELU1/ --layerid 14
cp $files_path/layer-14-BasicBlock/RELU1/layer_14_OutputB.txt $files_path/layer-14-BasicBlock/CONV2/layer_14_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-14-BasicBlock/CONV2/ --layerid 14
python3 run_residual.py --multiplier 32 --num_bits_act 16 --x_path $files_path/layer-14-BasicBlock/CONV1/layer_14_InputB.txt --y_path $files_path/layer-14-BasicBlock/CONV2/layer_14_OutputB.txt --out_path $files_path/layer-14-BasicBlock/RELU2/layer_14_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 8 --br 8 --sup  -k 2 -t 4 --dir $files_path/layer-14-BasicBlock/RELU2/ --layerid 14
cp $files_path/layer-14-BasicBlock/RELU2/layer_14_OutputB.txt $files_path/layer-15-BasicBlock/CONV1/layer_15_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-15-BasicBlock/CONV1/ --layerid 15
cp $files_path/layer-15-BasicBlock/CONV1/layer_15_OutputB.txt $files_path/layer-15-BasicBlock/RELU1/layer_15_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 7 --br 7 --sup  -k 2 -t 4 --dir $files_path/layer-15-BasicBlock/RELU1/ --layerid 15
cp $files_path/layer-15-BasicBlock/RELU1/layer_15_OutputB.txt $files_path/layer-15-BasicBlock/CONV2/layer_15_InputB.txt
$onni_path/bin/onni -f 1 --bins 6 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-15-BasicBlock/CONV2/ --layerid 15
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-15-BasicBlock/CONV1/layer_15_InputB.txt --y_path $files_path/layer-15-BasicBlock/CONV2/layer_15_OutputB.txt --out_path $files_path/layer-15-BasicBlock/RELU2/layer_15_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 9 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-15-BasicBlock/RELU2/ --layerid 15
cp $files_path/layer-15-BasicBlock/RELU2/layer_15_OutputB.txt $files_path/layer-16-BasicBlock/CONV1/layer_16_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-16-BasicBlock/CONV1/ --layerid 16
cp $files_path/layer-16-BasicBlock/CONV1/layer_16_OutputB.txt $files_path/layer-16-BasicBlock/RELU1/layer_16_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 7 --br 8 --sup  -k 2 -t 4 --dir $files_path/layer-16-BasicBlock/RELU1/ --layerid 16
cp $files_path/layer-16-BasicBlock/RELU1/layer_16_OutputB.txt $files_path/layer-16-BasicBlock/CONV2/layer_16_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup  -k 2 -t 4 --dir $files_path/layer-16-BasicBlock/CONV2/ --layerid 16
python3 run_residual.py --multiplier 16 --num_bits_act 16 --x_path $files_path/layer-16-BasicBlock/CONV1/layer_16_InputB.txt --y_path $files_path/layer-16-BasicBlock/CONV2/layer_16_OutputB.txt --out_path $files_path/layer-16-BasicBlock/RELU2/layer_16_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 8 --br 5 --sup  -k 2 -t 4 --dir $files_path/layer-16-BasicBlock/RELU2/ --layerid 16
cp $files_path/layer-16-BasicBlock/RELU2/layer_16_OutputB.txt $files_path/layer-17-SUMPOOL2D/layer_17_InputB.txt
python3 run_sum_pool.py --path $files_path/layer-17-SUMPOOL2D/layer_17_InputB.txt --num_bits 16 --channels 64 --width 8
$onni_path/bin/onni -f 2 -i 64 -w 1 -g 1 --ba 8 --br 6 --sup  -k 2 -t 4 --dir $files_path/layer-17-SUMPOOL2D/ --layerid 17
cp $files_path/layer-17-SUMPOOL2D/layer_17_OutputB.txt $files_path/layer-18-LINEAR/layer_18_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 64 -o 100 -w 1 -g 1 --ba 16 -z 0 --sup  -k 2 -t 4 --dir $files_path/layer-18-LINEAR/ --layerid 18
cp $files_path/layer-18-LINEAR/layer_18_OutputB.txt $files_path/layer-19-ARGMAX/layer_19_InputB.txt
$onni_path/bin/onni -f 7 -e 100 --sup  -k 2 -t 1 --dir $files_path/layer-19-ARGMAX/ --layerid 19
