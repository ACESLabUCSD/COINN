#!/bin/bash
onni_path="../../../onni"
files_path="."
$onni_path/bin/onni -f 4 --bw 16 -i 3 -o 64 -w 224 -g 7 --ba 16 -z 3 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-0-CONV/ --layerid 0
cp $files_path/layer-0-CONV/layer_0_OutputB.txt $files_path/layer-1-MP-RELU/layer_1_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 112 -g 3 --ba 8 --br 8 --stride 2 --padding 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-1-MP-RELU/ --layerid 1
cp $files_path/layer-1-MP-RELU/layer_1_OutputB.txt $files_path/layer-2-Bottleneck/CONV1/layer_2_InputB.txt
$onni_path/bin/onni -f 1 --bins 15 -i 64 -o 64 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/CONV1/ --layerid 2
cp $files_path/layer-2-Bottleneck/CONV1/layer_2_OutputB.txt $files_path/layer-2-Bottleneck/RELU1/layer_2_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 56 -g 1 --ba 9 --br 5 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/RELU1/ --layerid 2
cp $files_path/layer-2-Bottleneck/RELU1/layer_2_OutputB.txt $files_path/layer-2-Bottleneck/CONV2/layer_2_InputB.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 56 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/CONV2/ --layerid 2
cp $files_path/layer-2-Bottleneck/CONV2/layer_2_OutputB.txt $files_path/layer-2-Bottleneck/RELU2/layer_2_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 56 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/RELU2/ --layerid 2
cp $files_path/layer-2-Bottleneck/RELU2/layer_2_OutputB.txt $files_path/layer-2-Bottleneck/CONV3/layer_2_InputB.txt
$onni_path/bin/onni -f 1 --bins 11 -i 64 -o 256 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/CONV3/ --layerid 2
cp $files_path/layer-2-Bottleneck/CONV1/layer_2_InputB.txt $files_path/layer-2-Bottleneck/CONV-Residual/layer_2_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 64 -o 256 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/CONV-Residual/ --layerid 2
python3 run_residual.py --multiplier 8 --num_bits_act 16 --x_path $files_path/layer-2-Bottleneck/CONV-Residual/layer_2_OutputB.txt --y_path $files_path/layer-2-Bottleneck/CONV3/layer_2_OutputB.txt --out_path $files_path/layer-2-Bottleneck/RELU3/layer_2_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 56 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-2-Bottleneck/RELU3/ --layerid 2
cp $files_path/layer-2-Bottleneck/RELU3/layer_2_OutputB.txt $files_path/layer-3-Bottleneck/CONV1/layer_3_InputB.txt
$onni_path/bin/onni -f 1 --bins 12 -i 256 -o 64 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-3-Bottleneck/CONV1/ --layerid 3
cp $files_path/layer-3-Bottleneck/CONV1/layer_3_OutputB.txt $files_path/layer-3-Bottleneck/RELU1/layer_3_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 56 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-3-Bottleneck/RELU1/ --layerid 3
cp $files_path/layer-3-Bottleneck/RELU1/layer_3_OutputB.txt $files_path/layer-3-Bottleneck/CONV2/layer_3_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 64 -o 64 -w 56 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-3-Bottleneck/CONV2/ --layerid 3
cp $files_path/layer-3-Bottleneck/CONV2/layer_3_OutputB.txt $files_path/layer-3-Bottleneck/RELU2/layer_3_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 56 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-3-Bottleneck/RELU2/ --layerid 3
cp $files_path/layer-3-Bottleneck/RELU2/layer_3_OutputB.txt $files_path/layer-3-Bottleneck/CONV3/layer_3_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 64 -o 256 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-3-Bottleneck/CONV3/ --layerid 3
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-3-Bottleneck/CONV1/layer_3_InputB.txt --y_path $files_path/layer-3-Bottleneck/CONV3/layer_3_OutputB.txt --out_path $files_path/layer-3-Bottleneck/RELU3/layer_3_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 56 -g 1 --ba 9 --br 6 --sup --setup -k 2 -t 4 --dir $files_path/layer-3-Bottleneck/RELU3/ --layerid 3
cp $files_path/layer-3-Bottleneck/RELU3/layer_3_OutputB.txt $files_path/layer-4-Bottleneck/CONV1/layer_4_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 256 -o 64 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-4-Bottleneck/CONV1/ --layerid 4
cp $files_path/layer-4-Bottleneck/CONV1/layer_4_OutputB.txt $files_path/layer-4-Bottleneck/RELU1/layer_4_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 56 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-4-Bottleneck/RELU1/ --layerid 4
cp $files_path/layer-4-Bottleneck/RELU1/layer_4_OutputB.txt $files_path/layer-4-Bottleneck/CONV2/layer_4_InputB.txt
$onni_path/bin/onni -f 1 --bins 6 -i 64 -o 64 -w 56 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-4-Bottleneck/CONV2/ --layerid 4
cp $files_path/layer-4-Bottleneck/CONV2/layer_4_OutputB.txt $files_path/layer-4-Bottleneck/RELU2/layer_4_InputB.txt
$onni_path/bin/onni -f 2 -i 64 -w 56 -g 1 --ba 7 --br 9 --sup --setup -k 2 -t 4 --dir $files_path/layer-4-Bottleneck/RELU2/ --layerid 4
cp $files_path/layer-4-Bottleneck/RELU2/layer_4_OutputB.txt $files_path/layer-4-Bottleneck/CONV3/layer_4_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 64 -o 256 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-4-Bottleneck/CONV3/ --layerid 4
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-4-Bottleneck/CONV1/layer_4_InputB.txt --y_path $files_path/layer-4-Bottleneck/CONV3/layer_4_OutputB.txt --out_path $files_path/layer-4-Bottleneck/RELU3/layer_4_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 56 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-4-Bottleneck/RELU3/ --layerid 4
cp $files_path/layer-4-Bottleneck/RELU3/layer_4_OutputB.txt $files_path/layer-5-Bottleneck/CONV1/layer_5_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 256 -o 128 -w 56 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/CONV1/ --layerid 5
cp $files_path/layer-5-Bottleneck/CONV1/layer_5_OutputB.txt $files_path/layer-5-Bottleneck/RELU1/layer_5_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 56 -g 1 --ba 9 --br 5 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/RELU1/ --layerid 5
cp $files_path/layer-5-Bottleneck/RELU1/layer_5_OutputB.txt $files_path/layer-5-Bottleneck/CONV2/layer_5_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 128 -o 128 -w 56 -g 3 --ba 16 -z 1 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/CONV2/ --layerid 5
cp $files_path/layer-5-Bottleneck/CONV2/layer_5_OutputB.txt $files_path/layer-5-Bottleneck/RELU2/layer_5_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/RELU2/ --layerid 5
cp $files_path/layer-5-Bottleneck/RELU2/layer_5_OutputB.txt $files_path/layer-5-Bottleneck/CONV3/layer_5_InputB.txt
$onni_path/bin/onni -f 1 --bins 13 -i 128 -o 512 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/CONV3/ --layerid 5
cp $files_path/layer-5-Bottleneck/CONV1/layer_5_InputB.txt $files_path/layer-5-Bottleneck/CONV-Residual/layer_5_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 256 -o 512 -w 56 -g 1 --ba 16 -z 0 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/CONV-Residual/ --layerid 5
python3 run_residual.py --multiplier 1 --num_bits_act 16 --x_path $files_path/layer-5-Bottleneck/CONV3/layer_5_OutputB.txt --y_path $files_path/layer-5-Bottleneck/CONV-Residual/layer_5_OutputB.txt --out_path $files_path/layer-5-Bottleneck/RELU3/layer_5_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 28 -g 1 --ba 9 --br 6 --sup --setup -k 2 -t 4 --dir $files_path/layer-5-Bottleneck/RELU3/ --layerid 5
cp $files_path/layer-5-Bottleneck/RELU3/layer_5_OutputB.txt $files_path/layer-6-Bottleneck/CONV1/layer_6_InputB.txt
$onni_path/bin/onni -f 1 --bins 12 -i 512 -o 128 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-6-Bottleneck/CONV1/ --layerid 6
cp $files_path/layer-6-Bottleneck/CONV1/layer_6_OutputB.txt $files_path/layer-6-Bottleneck/RELU1/layer_6_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-6-Bottleneck/RELU1/ --layerid 6
cp $files_path/layer-6-Bottleneck/RELU1/layer_6_OutputB.txt $files_path/layer-6-Bottleneck/CONV2/layer_6_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 128 -o 128 -w 28 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-6-Bottleneck/CONV2/ --layerid 6
cp $files_path/layer-6-Bottleneck/CONV2/layer_6_OutputB.txt $files_path/layer-6-Bottleneck/RELU2/layer_6_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-6-Bottleneck/RELU2/ --layerid 6
cp $files_path/layer-6-Bottleneck/RELU2/layer_6_OutputB.txt $files_path/layer-6-Bottleneck/CONV3/layer_6_InputB.txt
$onni_path/bin/onni -f 1 --bins 15 -i 128 -o 512 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-6-Bottleneck/CONV3/ --layerid 6
python3 run_residual.py --multiplier 128 --num_bits_act 16 --x_path $files_path/layer-6-Bottleneck/CONV1/layer_6_InputB.txt --y_path $files_path/layer-6-Bottleneck/CONV3/layer_6_OutputB.txt --out_path $files_path/layer-6-Bottleneck/RELU3/layer_6_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 28 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-6-Bottleneck/RELU3/ --layerid 6
cp $files_path/layer-6-Bottleneck/RELU3/layer_6_OutputB.txt $files_path/layer-7-Bottleneck/CONV1/layer_7_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 512 -o 128 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-7-Bottleneck/CONV1/ --layerid 7
cp $files_path/layer-7-Bottleneck/CONV1/layer_7_OutputB.txt $files_path/layer-7-Bottleneck/RELU1/layer_7_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-7-Bottleneck/RELU1/ --layerid 7
cp $files_path/layer-7-Bottleneck/RELU1/layer_7_OutputB.txt $files_path/layer-7-Bottleneck/CONV2/layer_7_InputB.txt
$onni_path/bin/onni -f 1 --bins 15 -i 128 -o 128 -w 28 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-7-Bottleneck/CONV2/ --layerid 7
cp $files_path/layer-7-Bottleneck/CONV2/layer_7_OutputB.txt $files_path/layer-7-Bottleneck/RELU2/layer_7_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-7-Bottleneck/RELU2/ --layerid 7
cp $files_path/layer-7-Bottleneck/RELU2/layer_7_OutputB.txt $files_path/layer-7-Bottleneck/CONV3/layer_7_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 128 -o 512 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-7-Bottleneck/CONV3/ --layerid 7
cp $files_path/layer-7-Bottleneck/CONV3/layer_7_OutputB.txt $files_path/layer-7-Bottleneck/RELU3/layer_7_InputB.txt
cp $files_path/layer-7-Bottleneck/CONV1/layer_7_InputB.txt $files_path/layer-7-Bottleneck/RELU3/layer_7_InputRB.txt
$onni_path/bin/onni -f 6 -i 512 -w 28 -g 1 --ba 9 --br 7 --bs 9 --bl 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-7-Bottleneck/RELU3/ --layerid 7
cp $files_path/layer-7-Bottleneck/RELU3/layer_7_OutputB.txt $files_path/layer-8-Bottleneck/CONV1/layer_8_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 512 -o 128 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-8-Bottleneck/CONV1/ --layerid 8
cp $files_path/layer-8-Bottleneck/CONV1/layer_8_OutputB.txt $files_path/layer-8-Bottleneck/RELU1/layer_8_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 9 --br 6 --sup --setup -k 2 -t 4 --dir $files_path/layer-8-Bottleneck/RELU1/ --layerid 8
cp $files_path/layer-8-Bottleneck/RELU1/layer_8_OutputB.txt $files_path/layer-8-Bottleneck/CONV2/layer_8_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 128 -o 128 -w 28 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-8-Bottleneck/CONV2/ --layerid 8
cp $files_path/layer-8-Bottleneck/CONV2/layer_8_OutputB.txt $files_path/layer-8-Bottleneck/RELU2/layer_8_InputB.txt
$onni_path/bin/onni -f 2 -i 128 -w 28 -g 1 --ba 6 --br 10 --sup --setup -k 2 -t 4 --dir $files_path/layer-8-Bottleneck/RELU2/ --layerid 8
cp $files_path/layer-8-Bottleneck/RELU2/layer_8_OutputB.txt $files_path/layer-8-Bottleneck/CONV3/layer_8_InputB.txt
$onni_path/bin/onni -f 1 --bins 15 -i 128 -o 512 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-8-Bottleneck/CONV3/ --layerid 8
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-8-Bottleneck/CONV1/layer_8_InputB.txt --y_path $files_path/layer-8-Bottleneck/CONV3/layer_8_OutputB.txt --out_path $files_path/layer-8-Bottleneck/RELU3/layer_8_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 28 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-8-Bottleneck/RELU3/ --layerid 8
cp $files_path/layer-8-Bottleneck/RELU3/layer_8_OutputB.txt $files_path/layer-9-Bottleneck/CONV1/layer_9_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 512 -o 256 -w 28 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/CONV1/ --layerid 9
cp $files_path/layer-9-Bottleneck/CONV1/layer_9_OutputB.txt $files_path/layer-9-Bottleneck/RELU1/layer_9_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 28 -g 1 --ba 9 --br 5 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/RELU1/ --layerid 9
cp $files_path/layer-9-Bottleneck/RELU1/layer_9_OutputB.txt $files_path/layer-9-Bottleneck/CONV2/layer_9_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 256 -o 256 -w 28 -g 3 --ba 16 -z 1 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/CONV2/ --layerid 9
cp $files_path/layer-9-Bottleneck/CONV2/layer_9_OutputB.txt $files_path/layer-9-Bottleneck/RELU2/layer_9_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/RELU2/ --layerid 9
cp $files_path/layer-9-Bottleneck/RELU2/layer_9_OutputB.txt $files_path/layer-9-Bottleneck/CONV3/layer_9_InputB.txt
$onni_path/bin/onni -f 1 --bins 15 -i 256 -o 1024 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/CONV3/ --layerid 9
cp $files_path/layer-9-Bottleneck/CONV1/layer_9_InputB.txt $files_path/layer-9-Bottleneck/CONV-Residual/layer_9_InputB.txt
$onni_path/bin/onni -f 1 --bins 14 -i 512 -o 1024 -w 28 -g 1 --ba 16 -z 0 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/CONV-Residual/ --layerid 9
python3 run_residual.py --multiplier 2 --num_bits_act 16 --x_path $files_path/layer-9-Bottleneck/CONV-Residual/layer_9_OutputB.txt --y_path $files_path/layer-9-Bottleneck/CONV3/layer_9_OutputB.txt --out_path $files_path/layer-9-Bottleneck/RELU3/layer_9_InputB.txt
$onni_path/bin/onni -f 2 -i 1024 -w 14 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-9-Bottleneck/RELU3/ --layerid 9
cp $files_path/layer-9-Bottleneck/RELU3/layer_9_OutputB.txt $files_path/layer-10-Bottleneck/CONV1/layer_10_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 1024 -o 256 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-10-Bottleneck/CONV1/ --layerid 10
cp $files_path/layer-10-Bottleneck/CONV1/layer_10_OutputB.txt $files_path/layer-10-Bottleneck/RELU1/layer_10_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 7 --br 9 --sup --setup -k 2 -t 4 --dir $files_path/layer-10-Bottleneck/RELU1/ --layerid 10
cp $files_path/layer-10-Bottleneck/RELU1/layer_10_OutputB.txt $files_path/layer-10-Bottleneck/CONV2/layer_10_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 256 -o 256 -w 14 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-10-Bottleneck/CONV2/ --layerid 10
cp $files_path/layer-10-Bottleneck/CONV2/layer_10_OutputB.txt $files_path/layer-10-Bottleneck/RELU2/layer_10_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 9 --br 6 --sup --setup -k 2 -t 4 --dir $files_path/layer-10-Bottleneck/RELU2/ --layerid 10
cp $files_path/layer-10-Bottleneck/RELU2/layer_10_OutputB.txt $files_path/layer-10-Bottleneck/CONV3/layer_10_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 256 -o 1024 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-10-Bottleneck/CONV3/ --layerid 10
cp $files_path/layer-10-Bottleneck/CONV3/layer_10_OutputB.txt $files_path/layer-10-Bottleneck/RELU3/layer_10_InputB.txt
cp $files_path/layer-10-Bottleneck/CONV1/layer_10_InputB.txt $files_path/layer-10-Bottleneck/RELU3/layer_10_InputRB.txt
$onni_path/bin/onni -f 6 -i 1024 -w 14 -g 1 --ba 9 --br 7 --bs 9 --bl 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-10-Bottleneck/RELU3/ --layerid 10
cp $files_path/layer-10-Bottleneck/RELU3/layer_10_OutputB.txt $files_path/layer-11-Bottleneck/CONV1/layer_11_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 1024 -o 256 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-11-Bottleneck/CONV1/ --layerid 11
cp $files_path/layer-11-Bottleneck/CONV1/layer_11_OutputB.txt $files_path/layer-11-Bottleneck/RELU1/layer_11_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 9 --br 5 --sup --setup -k 2 -t 4 --dir $files_path/layer-11-Bottleneck/RELU1/ --layerid 11
cp $files_path/layer-11-Bottleneck/RELU1/layer_11_OutputB.txt $files_path/layer-11-Bottleneck/CONV2/layer_11_InputB.txt
$onni_path/bin/onni -f 1 --bins 6 -i 256 -o 256 -w 14 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-11-Bottleneck/CONV2/ --layerid 11
cp $files_path/layer-11-Bottleneck/CONV2/layer_11_OutputB.txt $files_path/layer-11-Bottleneck/RELU2/layer_11_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 7 --br 9 --sup --setup -k 2 -t 4 --dir $files_path/layer-11-Bottleneck/RELU2/ --layerid 11
cp $files_path/layer-11-Bottleneck/RELU2/layer_11_OutputB.txt $files_path/layer-11-Bottleneck/CONV3/layer_11_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 256 -o 1024 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-11-Bottleneck/CONV3/ --layerid 11
cp $files_path/layer-11-Bottleneck/CONV3/layer_11_OutputB.txt $files_path/layer-11-Bottleneck/RELU3/layer_11_InputB.txt
cp $files_path/layer-11-Bottleneck/CONV1/layer_11_InputB.txt $files_path/layer-11-Bottleneck/RELU3/layer_11_InputRB.txt
$onni_path/bin/onni -f 6 -i 1024 -w 14 -g 1 --ba 9 --br 7 --bs 9 --bl 10 --sup --setup -k 2 -t 4 --dir $files_path/layer-11-Bottleneck/RELU3/ --layerid 11
cp $files_path/layer-11-Bottleneck/RELU3/layer_11_OutputB.txt $files_path/layer-12-Bottleneck/CONV1/layer_12_InputB.txt
$onni_path/bin/onni -f 1 --bins 10 -i 1024 -o 256 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-12-Bottleneck/CONV1/ --layerid 12
cp $files_path/layer-12-Bottleneck/CONV1/layer_12_OutputB.txt $files_path/layer-12-Bottleneck/RELU1/layer_12_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-12-Bottleneck/RELU1/ --layerid 12
cp $files_path/layer-12-Bottleneck/RELU1/layer_12_OutputB.txt $files_path/layer-12-Bottleneck/CONV2/layer_12_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 256 -o 256 -w 14 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-12-Bottleneck/CONV2/ --layerid 12
cp $files_path/layer-12-Bottleneck/CONV2/layer_12_OutputB.txt $files_path/layer-12-Bottleneck/RELU2/layer_12_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-12-Bottleneck/RELU2/ --layerid 12
cp $files_path/layer-12-Bottleneck/RELU2/layer_12_OutputB.txt $files_path/layer-12-Bottleneck/CONV3/layer_12_InputB.txt
$onni_path/bin/onni -f 1 --bins 14 -i 256 -o 1024 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-12-Bottleneck/CONV3/ --layerid 12
cp $files_path/layer-12-Bottleneck/CONV3/layer_12_OutputB.txt $files_path/layer-12-Bottleneck/RELU3/layer_12_InputB.txt
cp $files_path/layer-12-Bottleneck/CONV1/layer_12_InputB.txt $files_path/layer-12-Bottleneck/RELU3/layer_12_InputRB.txt
$onni_path/bin/onni -f 6 -i 1024 -w 14 -g 1 --ba 9 --br 7 --bs 9 --bl 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-12-Bottleneck/RELU3/ --layerid 12
cp $files_path/layer-12-Bottleneck/RELU3/layer_12_OutputB.txt $files_path/layer-13-Bottleneck/CONV1/layer_13_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 1024 -o 256 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-13-Bottleneck/CONV1/ --layerid 13
cp $files_path/layer-13-Bottleneck/CONV1/layer_13_OutputB.txt $files_path/layer-13-Bottleneck/RELU1/layer_13_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 9 --br 6 --sup --setup -k 2 -t 4 --dir $files_path/layer-13-Bottleneck/RELU1/ --layerid 13
cp $files_path/layer-13-Bottleneck/RELU1/layer_13_OutputB.txt $files_path/layer-13-Bottleneck/CONV2/layer_13_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 256 -o 256 -w 14 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-13-Bottleneck/CONV2/ --layerid 13
cp $files_path/layer-13-Bottleneck/CONV2/layer_13_OutputB.txt $files_path/layer-13-Bottleneck/RELU2/layer_13_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 7 --br 9 --sup --setup -k 2 -t 4 --dir $files_path/layer-13-Bottleneck/RELU2/ --layerid 13
cp $files_path/layer-13-Bottleneck/RELU2/layer_13_OutputB.txt $files_path/layer-13-Bottleneck/CONV3/layer_13_InputB.txt
$onni_path/bin/onni -f 1 --bins 7 -i 256 -o 1024 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-13-Bottleneck/CONV3/ --layerid 13
cp $files_path/layer-13-Bottleneck/CONV3/layer_13_OutputB.txt $files_path/layer-13-Bottleneck/RELU3/layer_13_InputB.txt
cp $files_path/layer-13-Bottleneck/CONV1/layer_13_InputB.txt $files_path/layer-13-Bottleneck/RELU3/layer_13_InputRB.txt
$onni_path/bin/onni -f 6 -i 1024 -w 14 -g 1 --ba 9 --br 7 --bs 9 --bl 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-13-Bottleneck/RELU3/ --layerid 13
cp $files_path/layer-13-Bottleneck/RELU3/layer_13_OutputB.txt $files_path/layer-14-Bottleneck/CONV1/layer_14_InputB.txt
$onni_path/bin/onni -f 1 --bins 15 -i 1024 -o 256 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-14-Bottleneck/CONV1/ --layerid 14
cp $files_path/layer-14-Bottleneck/CONV1/layer_14_OutputB.txt $files_path/layer-14-Bottleneck/RELU1/layer_14_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-14-Bottleneck/RELU1/ --layerid 14
cp $files_path/layer-14-Bottleneck/RELU1/layer_14_OutputB.txt $files_path/layer-14-Bottleneck/CONV2/layer_14_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 256 -o 256 -w 14 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-14-Bottleneck/CONV2/ --layerid 14
cp $files_path/layer-14-Bottleneck/CONV2/layer_14_OutputB.txt $files_path/layer-14-Bottleneck/RELU2/layer_14_InputB.txt
$onni_path/bin/onni -f 2 -i 256 -w 14 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-14-Bottleneck/RELU2/ --layerid 14
cp $files_path/layer-14-Bottleneck/RELU2/layer_14_OutputB.txt $files_path/layer-14-Bottleneck/CONV3/layer_14_InputB.txt
$onni_path/bin/onni -f 1 --bins 13 -i 256 -o 1024 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-14-Bottleneck/CONV3/ --layerid 14
python3 run_residual.py --multiplier 128 --num_bits_act 16 --x_path $files_path/layer-14-Bottleneck/CONV1/layer_14_InputB.txt --y_path $files_path/layer-14-Bottleneck/CONV3/layer_14_OutputB.txt --out_path $files_path/layer-14-Bottleneck/RELU3/layer_14_InputB.txt
$onni_path/bin/onni -f 2 -i 1024 -w 14 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-14-Bottleneck/RELU3/ --layerid 14
cp $files_path/layer-14-Bottleneck/RELU3/layer_14_OutputB.txt $files_path/layer-15-Bottleneck/CONV1/layer_15_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 1024 -o 512 -w 14 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/CONV1/ --layerid 15
cp $files_path/layer-15-Bottleneck/CONV1/layer_15_OutputB.txt $files_path/layer-15-Bottleneck/RELU1/layer_15_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 14 -g 1 --ba 9 --br 5 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/RELU1/ --layerid 15
cp $files_path/layer-15-Bottleneck/RELU1/layer_15_OutputB.txt $files_path/layer-15-Bottleneck/CONV2/layer_15_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 512 -o 512 -w 14 -g 3 --ba 16 -z 1 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/CONV2/ --layerid 15
cp $files_path/layer-15-Bottleneck/CONV2/layer_15_OutputB.txt $files_path/layer-15-Bottleneck/RELU2/layer_15_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 7 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/RELU2/ --layerid 15
cp $files_path/layer-15-Bottleneck/RELU2/layer_15_OutputB.txt $files_path/layer-15-Bottleneck/CONV3/layer_15_InputB.txt
$onni_path/bin/onni -f 1 --bins 11 -i 512 -o 2048 -w 7 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/CONV3/ --layerid 15
cp $files_path/layer-15-Bottleneck/CONV1/layer_15_InputB.txt $files_path/layer-15-Bottleneck/CONV-Residual/layer_15_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 1024 -o 2048 -w 14 -g 1 --ba 16 -z 0 --stride 2 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/CONV-Residual/ --layerid 15
cp $files_path/layer-15-Bottleneck/CONV3/layer_15_OutputB.txt $files_path/layer-15-Bottleneck/RELU3/layer_15_InputB.txt
cp $files_path/layer-15-Bottleneck/CONV-Residual/layer_15_OutputB.txt $files_path/layer-15-Bottleneck/RELU3/layer_15_InputRB.txt
$onni_path/bin/onni -f 6 -i 2048 -w 7 -g 1 --ba 9 --br 7 --bs 14 --bl 3 --sup --setup -k 2 -t 4 --dir $files_path/layer-15-Bottleneck/RELU3/ --layerid 15
cp $files_path/layer-15-Bottleneck/RELU3/layer_15_OutputB.txt $files_path/layer-16-Bottleneck/CONV1/layer_16_InputB.txt
$onni_path/bin/onni -f 1 --bins 11 -i 2048 -o 512 -w 7 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-16-Bottleneck/CONV1/ --layerid 16
cp $files_path/layer-16-Bottleneck/CONV1/layer_16_OutputB.txt $files_path/layer-16-Bottleneck/RELU1/layer_16_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 7 -g 1 --ba 7 --br 9 --sup --setup -k 2 -t 4 --dir $files_path/layer-16-Bottleneck/RELU1/ --layerid 16
cp $files_path/layer-16-Bottleneck/RELU1/layer_16_OutputB.txt $files_path/layer-16-Bottleneck/CONV2/layer_16_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 512 -o 512 -w 7 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-16-Bottleneck/CONV2/ --layerid 16
cp $files_path/layer-16-Bottleneck/CONV2/layer_16_OutputB.txt $files_path/layer-16-Bottleneck/RELU2/layer_16_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 7 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-16-Bottleneck/RELU2/ --layerid 16
cp $files_path/layer-16-Bottleneck/RELU2/layer_16_OutputB.txt $files_path/layer-16-Bottleneck/CONV3/layer_16_InputB.txt
$onni_path/bin/onni -f 1 --bins 14 -i 512 -o 2048 -w 7 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-16-Bottleneck/CONV3/ --layerid 16
python3 run_residual.py --multiplier 128 --num_bits_act 16 --x_path $files_path/layer-16-Bottleneck/CONV1/layer_16_InputB.txt --y_path $files_path/layer-16-Bottleneck/CONV3/layer_16_OutputB.txt --out_path $files_path/layer-16-Bottleneck/RELU3/layer_16_InputB.txt
$onni_path/bin/onni -f 2 -i 2048 -w 7 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-16-Bottleneck/RELU3/ --layerid 16
cp $files_path/layer-16-Bottleneck/RELU3/layer_16_OutputB.txt $files_path/layer-17-Bottleneck/CONV1/layer_17_InputB.txt
$onni_path/bin/onni -f 1 --bins 9 -i 2048 -o 512 -w 7 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-17-Bottleneck/CONV1/ --layerid 17
cp $files_path/layer-17-Bottleneck/CONV1/layer_17_OutputB.txt $files_path/layer-17-Bottleneck/RELU1/layer_17_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 7 -g 1 --ba 8 --br 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-17-Bottleneck/RELU1/ --layerid 17
cp $files_path/layer-17-Bottleneck/RELU1/layer_17_OutputB.txt $files_path/layer-17-Bottleneck/CONV2/layer_17_InputB.txt
$onni_path/bin/onni -f 4 --bw 16 -i 512 -o 512 -w 7 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-17-Bottleneck/CONV2/ --layerid 17
cp $files_path/layer-17-Bottleneck/CONV2/layer_17_OutputB.txt $files_path/layer-17-Bottleneck/RELU2/layer_17_InputB.txt
$onni_path/bin/onni -f 2 -i 512 -w 7 -g 1 --ba 9 --br 7 --sup --setup -k 2 -t 4 --dir $files_path/layer-17-Bottleneck/RELU2/ --layerid 17
cp $files_path/layer-17-Bottleneck/RELU2/layer_17_OutputB.txt $files_path/layer-17-Bottleneck/CONV3/layer_17_InputB.txt
$onni_path/bin/onni -f 1 --bins 8 -i 512 -o 2048 -w 7 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 2 -t 4 --dir $files_path/layer-17-Bottleneck/CONV3/ --layerid 17
cp $files_path/layer-17-Bottleneck/CONV3/layer_17_OutputB.txt $files_path/layer-17-Bottleneck/RELU3/layer_17_InputB.txt
cp $files_path/layer-17-Bottleneck/CONV1/layer_17_InputB.txt $files_path/layer-17-Bottleneck/RELU3/layer_17_InputRB.txt
$onni_path/bin/onni -f 6 -i 2048 -w 7 -g 1 --ba 9 --br 7 --bs 9 --bl 8 --sup --setup -k 2 -t 4 --dir $files_path/layer-17-Bottleneck/RELU3/ --layerid 17
cp $files_path/layer-17-Bottleneck/RELU3/layer_17_OutputB.txt $files_path/layer-18-LINEAR/layer_18_InputB.txt
python3 run_sum_pool.py --path $files_path/layer-18-LINEAR/layer_18_InputB.txt --channels 2048 --width 7
$onni_path/bin/onni -f 4 --bw 16 -i 2048 -o 1000 -w 1 -g 1 --ba 16 -z 0 --sup --setup -k 2 -t 4 --dir $files_path/layer-18-LINEAR/ --layerid 18
