#!/bin/bash
onni_path="../../../onni"
files_path="."
$onni_path/bin/onni -f 1 --bins 9 -i 3 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-0-CONV/ --layerid 0
cp $files_path/layer-0-CONV/layer_0_OutputA.txt $files_path/layer-1-RELU/layer_1_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-1-RELU/ --layerid 1
cp $files_path/layer-1-RELU/layer_1_OutputA.txt $files_path/layer-2-BasicBlock/CONV1/layer_2_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-2-BasicBlock/CONV1/ --layerid 2
cp $files_path/layer-2-BasicBlock/CONV1/layer_2_OutputA.txt $files_path/layer-2-BasicBlock/RELU1/layer_2_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-2-BasicBlock/RELU1/ --layerid 2
cp $files_path/layer-2-BasicBlock/RELU1/layer_2_OutputA.txt $files_path/layer-2-BasicBlock/CONV2/layer_2_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-2-BasicBlock/CONV2/ --layerid 2
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-2-BasicBlock/CONV1/layer_2_InputA.txt --y_path $files_path/layer-2-BasicBlock/CONV2/layer_2_OutputA.txt --out_path $files_path/layer-2-BasicBlock/RELU2/layer_2_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-2-BasicBlock/RELU2/ --layerid 2
cp $files_path/layer-2-BasicBlock/RELU2/layer_2_OutputA.txt $files_path/layer-3-BasicBlock/CONV1/layer_3_InputA.txt
$onni_path/bin/onni -f 1 --bins 15 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-3-BasicBlock/CONV1/ --layerid 3
cp $files_path/layer-3-BasicBlock/CONV1/layer_3_OutputA.txt $files_path/layer-3-BasicBlock/RELU1/layer_3_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-3-BasicBlock/RELU1/ --layerid 3
cp $files_path/layer-3-BasicBlock/RELU1/layer_3_OutputA.txt $files_path/layer-3-BasicBlock/CONV2/layer_3_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-3-BasicBlock/CONV2/ --layerid 3
python3 run_residual.py --multiplier 32 --num_bits_act 16 --x_path $files_path/layer-3-BasicBlock/CONV1/layer_3_InputA.txt --y_path $files_path/layer-3-BasicBlock/CONV2/layer_3_OutputA.txt --out_path $files_path/layer-3-BasicBlock/RELU2/layer_3_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-3-BasicBlock/RELU2/ --layerid 3
cp $files_path/layer-3-BasicBlock/RELU2/layer_3_OutputA.txt $files_path/layer-4-BasicBlock/CONV1/layer_4_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-4-BasicBlock/CONV1/ --layerid 4
cp $files_path/layer-4-BasicBlock/CONV1/layer_4_OutputA.txt $files_path/layer-4-BasicBlock/RELU1/layer_4_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-4-BasicBlock/RELU1/ --layerid 4
cp $files_path/layer-4-BasicBlock/RELU1/layer_4_OutputA.txt $files_path/layer-4-BasicBlock/CONV2/layer_4_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-4-BasicBlock/CONV2/ --layerid 4
cp $files_path/layer-4-BasicBlock/CONV2/layer_4_OutputA.txt $files_path/layer-4-BasicBlock/RELU2/layer_4_InputA.txt
cp $files_path/layer-4-BasicBlock/CONV1/layer_4_InputA.txt $files_path/layer-4-BasicBlock/RELU2/layer_4_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-4-BasicBlock/RELU2/ --layerid 4
cp $files_path/layer-4-BasicBlock/RELU2/layer_4_OutputA.txt $files_path/layer-5-BasicBlock/CONV1/layer_5_InputA.txt
$onni_path/bin/onni -f 1 --bins 13 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-5-BasicBlock/CONV1/ --layerid 5
cp $files_path/layer-5-BasicBlock/CONV1/layer_5_OutputA.txt $files_path/layer-5-BasicBlock/RELU1/layer_5_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-5-BasicBlock/RELU1/ --layerid 5
cp $files_path/layer-5-BasicBlock/RELU1/layer_5_OutputA.txt $files_path/layer-5-BasicBlock/CONV2/layer_5_InputA.txt
$onni_path/bin/onni -f 1 --bins 3 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-5-BasicBlock/CONV2/ --layerid 5
cp $files_path/layer-5-BasicBlock/CONV2/layer_5_OutputA.txt $files_path/layer-5-BasicBlock/RELU2/layer_5_InputA.txt
cp $files_path/layer-5-BasicBlock/CONV1/layer_5_InputA.txt $files_path/layer-5-BasicBlock/RELU2/layer_5_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-5-BasicBlock/RELU2/ --layerid 5
cp $files_path/layer-5-BasicBlock/RELU2/layer_5_OutputA.txt $files_path/layer-6-BasicBlock/CONV1/layer_6_InputA.txt
$onni_path/bin/onni -f 1 --bins 10 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-6-BasicBlock/CONV1/ --layerid 6
cp $files_path/layer-6-BasicBlock/CONV1/layer_6_OutputA.txt $files_path/layer-6-BasicBlock/RELU1/layer_6_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-6-BasicBlock/RELU1/ --layerid 6
cp $files_path/layer-6-BasicBlock/RELU1/layer_6_OutputA.txt $files_path/layer-6-BasicBlock/CONV2/layer_6_InputA.txt
$onni_path/bin/onni -f 1 --bins 3 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-6-BasicBlock/CONV2/ --layerid 6
cp $files_path/layer-6-BasicBlock/CONV2/layer_6_OutputA.txt $files_path/layer-6-BasicBlock/RELU2/layer_6_InputA.txt
cp $files_path/layer-6-BasicBlock/CONV1/layer_6_InputA.txt $files_path/layer-6-BasicBlock/RELU2/layer_6_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-6-BasicBlock/RELU2/ --layerid 6
cp $files_path/layer-6-BasicBlock/RELU2/layer_6_OutputA.txt $files_path/layer-7-BasicBlock/CONV1/layer_7_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-7-BasicBlock/CONV1/ --layerid 7
cp $files_path/layer-7-BasicBlock/CONV1/layer_7_OutputA.txt $files_path/layer-7-BasicBlock/RELU1/layer_7_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-7-BasicBlock/RELU1/ --layerid 7
cp $files_path/layer-7-BasicBlock/RELU1/layer_7_OutputA.txt $files_path/layer-7-BasicBlock/CONV2/layer_7_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-7-BasicBlock/CONV2/ --layerid 7
cp $files_path/layer-7-BasicBlock/CONV2/layer_7_OutputA.txt $files_path/layer-7-BasicBlock/RELU2/layer_7_InputA.txt
cp $files_path/layer-7-BasicBlock/CONV1/layer_7_InputA.txt $files_path/layer-7-BasicBlock/RELU2/layer_7_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-7-BasicBlock/RELU2/ --layerid 7
cp $files_path/layer-7-BasicBlock/RELU2/layer_7_OutputA.txt $files_path/layer-8-BasicBlock/CONV1/layer_8_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-8-BasicBlock/CONV1/ --layerid 8
cp $files_path/layer-8-BasicBlock/CONV1/layer_8_OutputA.txt $files_path/layer-8-BasicBlock/RELU1/layer_8_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-8-BasicBlock/RELU1/ --layerid 8
cp $files_path/layer-8-BasicBlock/RELU1/layer_8_OutputA.txt $files_path/layer-8-BasicBlock/CONV2/layer_8_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-8-BasicBlock/CONV2/ --layerid 8
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-8-BasicBlock/CONV1/layer_8_InputA.txt --y_path $files_path/layer-8-BasicBlock/CONV2/layer_8_OutputA.txt --out_path $files_path/layer-8-BasicBlock/RELU2/layer_8_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-8-BasicBlock/RELU2/ --layerid 8
cp $files_path/layer-8-BasicBlock/RELU2/layer_8_OutputA.txt $files_path/layer-9-BasicBlock/CONV1/layer_9_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-9-BasicBlock/CONV1/ --layerid 9
cp $files_path/layer-9-BasicBlock/CONV1/layer_9_OutputA.txt $files_path/layer-9-BasicBlock/RELU1/layer_9_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-9-BasicBlock/RELU1/ --layerid 9
cp $files_path/layer-9-BasicBlock/RELU1/layer_9_OutputA.txt $files_path/layer-9-BasicBlock/CONV2/layer_9_InputA.txt
$onni_path/bin/onni -f 1 --bins 13 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-9-BasicBlock/CONV2/ --layerid 9
cp $files_path/layer-9-BasicBlock/CONV2/layer_9_OutputA.txt $files_path/layer-9-BasicBlock/RELU2/layer_9_InputA.txt
cp $files_path/layer-9-BasicBlock/CONV1/layer_9_InputA.txt $files_path/layer-9-BasicBlock/RELU2/layer_9_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-9-BasicBlock/RELU2/ --layerid 9
cp $files_path/layer-9-BasicBlock/RELU2/layer_9_OutputA.txt $files_path/layer-10-BasicBlock/CONV1/layer_10_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-10-BasicBlock/CONV1/ --layerid 10
cp $files_path/layer-10-BasicBlock/CONV1/layer_10_OutputA.txt $files_path/layer-10-BasicBlock/RELU1/layer_10_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-10-BasicBlock/RELU1/ --layerid 10
cp $files_path/layer-10-BasicBlock/RELU1/layer_10_OutputA.txt $files_path/layer-10-BasicBlock/CONV2/layer_10_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-10-BasicBlock/CONV2/ --layerid 10
cp $files_path/layer-10-BasicBlock/CONV2/layer_10_OutputA.txt $files_path/layer-10-BasicBlock/RELU2/layer_10_InputA.txt
cp $files_path/layer-10-BasicBlock/CONV1/layer_10_InputA.txt $files_path/layer-10-BasicBlock/RELU2/layer_10_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-10-BasicBlock/RELU2/ --layerid 10
cp $files_path/layer-10-BasicBlock/RELU2/layer_10_OutputA.txt $files_path/layer-11-BasicBlock/CONV1/layer_11_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-11-BasicBlock/CONV1/ --layerid 11
cp $files_path/layer-11-BasicBlock/CONV1/layer_11_OutputA.txt $files_path/layer-11-BasicBlock/RELU1/layer_11_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-11-BasicBlock/RELU1/ --layerid 11
cp $files_path/layer-11-BasicBlock/RELU1/layer_11_OutputA.txt $files_path/layer-11-BasicBlock/CONV2/layer_11_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-11-BasicBlock/CONV2/ --layerid 11
cp $files_path/layer-11-BasicBlock/CONV2/layer_11_OutputA.txt $files_path/layer-11-BasicBlock/RELU2/layer_11_InputA.txt
cp $files_path/layer-11-BasicBlock/CONV1/layer_11_InputA.txt $files_path/layer-11-BasicBlock/RELU2/layer_11_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-11-BasicBlock/RELU2/ --layerid 11
cp $files_path/layer-11-BasicBlock/RELU2/layer_11_OutputA.txt $files_path/layer-12-BasicBlock/CONV1/layer_12_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-12-BasicBlock/CONV1/ --layerid 12
cp $files_path/layer-12-BasicBlock/CONV1/layer_12_OutputA.txt $files_path/layer-12-BasicBlock/RELU1/layer_12_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-12-BasicBlock/RELU1/ --layerid 12
cp $files_path/layer-12-BasicBlock/RELU1/layer_12_OutputA.txt $files_path/layer-12-BasicBlock/CONV2/layer_12_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-12-BasicBlock/CONV2/ --layerid 12
cp $files_path/layer-12-BasicBlock/CONV2/layer_12_OutputA.txt $files_path/layer-12-BasicBlock/RELU2/layer_12_InputA.txt
cp $files_path/layer-12-BasicBlock/CONV1/layer_12_InputA.txt $files_path/layer-12-BasicBlock/RELU2/layer_12_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-12-BasicBlock/RELU2/ --layerid 12
cp $files_path/layer-12-BasicBlock/RELU2/layer_12_OutputA.txt $files_path/layer-13-BasicBlock/CONV1/layer_13_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-13-BasicBlock/CONV1/ --layerid 13
cp $files_path/layer-13-BasicBlock/CONV1/layer_13_OutputA.txt $files_path/layer-13-BasicBlock/RELU1/layer_13_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-13-BasicBlock/RELU1/ --layerid 13
cp $files_path/layer-13-BasicBlock/RELU1/layer_13_OutputA.txt $files_path/layer-13-BasicBlock/CONV2/layer_13_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-13-BasicBlock/CONV2/ --layerid 13
cp $files_path/layer-13-BasicBlock/CONV2/layer_13_OutputA.txt $files_path/layer-13-BasicBlock/RELU2/layer_13_InputA.txt
cp $files_path/layer-13-BasicBlock/CONV1/layer_13_InputA.txt $files_path/layer-13-BasicBlock/RELU2/layer_13_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-13-BasicBlock/RELU2/ --layerid 13
cp $files_path/layer-13-BasicBlock/RELU2/layer_13_OutputA.txt $files_path/layer-14-BasicBlock/CONV1/layer_14_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-14-BasicBlock/CONV1/ --layerid 14
cp $files_path/layer-14-BasicBlock/CONV1/layer_14_OutputA.txt $files_path/layer-14-BasicBlock/RELU1/layer_14_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-14-BasicBlock/RELU1/ --layerid 14
cp $files_path/layer-14-BasicBlock/RELU1/layer_14_OutputA.txt $files_path/layer-14-BasicBlock/CONV2/layer_14_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-14-BasicBlock/CONV2/ --layerid 14
cp $files_path/layer-14-BasicBlock/CONV2/layer_14_OutputA.txt $files_path/layer-14-BasicBlock/RELU2/layer_14_InputA.txt
cp $files_path/layer-14-BasicBlock/CONV1/layer_14_InputA.txt $files_path/layer-14-BasicBlock/RELU2/layer_14_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-14-BasicBlock/RELU2/ --layerid 14
cp $files_path/layer-14-BasicBlock/RELU2/layer_14_OutputA.txt $files_path/layer-15-BasicBlock/CONV1/layer_15_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-15-BasicBlock/CONV1/ --layerid 15
cp $files_path/layer-15-BasicBlock/CONV1/layer_15_OutputA.txt $files_path/layer-15-BasicBlock/RELU1/layer_15_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-15-BasicBlock/RELU1/ --layerid 15
cp $files_path/layer-15-BasicBlock/RELU1/layer_15_OutputA.txt $files_path/layer-15-BasicBlock/CONV2/layer_15_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-15-BasicBlock/CONV2/ --layerid 15
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-15-BasicBlock/CONV1/layer_15_InputA.txt --y_path $files_path/layer-15-BasicBlock/CONV2/layer_15_OutputA.txt --out_path $files_path/layer-15-BasicBlock/RELU2/layer_15_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-15-BasicBlock/RELU2/ --layerid 15
cp $files_path/layer-15-BasicBlock/RELU2/layer_15_OutputA.txt $files_path/layer-16-BasicBlock/CONV1/layer_16_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-16-BasicBlock/CONV1/ --layerid 16
cp $files_path/layer-16-BasicBlock/CONV1/layer_16_OutputA.txt $files_path/layer-16-BasicBlock/RELU1/layer_16_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-16-BasicBlock/RELU1/ --layerid 16
cp $files_path/layer-16-BasicBlock/RELU1/layer_16_OutputA.txt $files_path/layer-16-BasicBlock/CONV2/layer_16_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-16-BasicBlock/CONV2/ --layerid 16
cp $files_path/layer-16-BasicBlock/CONV2/layer_16_OutputA.txt $files_path/layer-16-BasicBlock/RELU2/layer_16_InputA.txt
cp $files_path/layer-16-BasicBlock/CONV1/layer_16_InputA.txt $files_path/layer-16-BasicBlock/RELU2/layer_16_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-16-BasicBlock/RELU2/ --layerid 16
cp $files_path/layer-16-BasicBlock/RELU2/layer_16_OutputA.txt $files_path/layer-17-BasicBlock/CONV1/layer_17_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-17-BasicBlock/CONV1/ --layerid 17
cp $files_path/layer-17-BasicBlock/CONV1/layer_17_OutputA.txt $files_path/layer-17-BasicBlock/RELU1/layer_17_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-17-BasicBlock/RELU1/ --layerid 17
cp $files_path/layer-17-BasicBlock/RELU1/layer_17_OutputA.txt $files_path/layer-17-BasicBlock/CONV2/layer_17_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-17-BasicBlock/CONV2/ --layerid 17
cp $files_path/layer-17-BasicBlock/CONV2/layer_17_OutputA.txt $files_path/layer-17-BasicBlock/RELU2/layer_17_InputA.txt
cp $files_path/layer-17-BasicBlock/CONV1/layer_17_InputA.txt $files_path/layer-17-BasicBlock/RELU2/layer_17_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-17-BasicBlock/RELU2/ --layerid 17
cp $files_path/layer-17-BasicBlock/RELU2/layer_17_OutputA.txt $files_path/layer-18-BasicBlock/CONV1/layer_18_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-18-BasicBlock/CONV1/ --layerid 18
cp $files_path/layer-18-BasicBlock/CONV1/layer_18_OutputA.txt $files_path/layer-18-BasicBlock/RELU1/layer_18_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-18-BasicBlock/RELU1/ --layerid 18
cp $files_path/layer-18-BasicBlock/RELU1/layer_18_OutputA.txt $files_path/layer-18-BasicBlock/CONV2/layer_18_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-18-BasicBlock/CONV2/ --layerid 18
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-18-BasicBlock/CONV1/layer_18_InputA.txt --y_path $files_path/layer-18-BasicBlock/CONV2/layer_18_OutputA.txt --out_path $files_path/layer-18-BasicBlock/RELU2/layer_18_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-18-BasicBlock/RELU2/ --layerid 18
cp $files_path/layer-18-BasicBlock/RELU2/layer_18_OutputA.txt $files_path/layer-19-BasicBlock/CONV1/layer_19_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-19-BasicBlock/CONV1/ --layerid 19
cp $files_path/layer-19-BasicBlock/CONV1/layer_19_OutputA.txt $files_path/layer-19-BasicBlock/RELU1/layer_19_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 32 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-19-BasicBlock/RELU1/ --layerid 19
cp $files_path/layer-19-BasicBlock/RELU1/layer_19_OutputA.txt $files_path/layer-19-BasicBlock/CONV2/layer_19_InputA.txt
$onni_path/bin/onni -f 1 --bins 14 -i 16 -o 16 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-19-BasicBlock/CONV2/ --layerid 19
cp $files_path/layer-19-BasicBlock/CONV2/layer_19_OutputA.txt $files_path/layer-19-BasicBlock/RELU2/layer_19_InputA.txt
cp $files_path/layer-19-BasicBlock/CONV1/layer_19_InputA.txt $files_path/layer-19-BasicBlock/RELU2/layer_19_InputRA.txt
$onni_path/bin/onni -f 6 -i 16 -w 32 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-19-BasicBlock/RELU2/ --layerid 19
cp $files_path/layer-19-BasicBlock/RELU2/layer_19_OutputA.txt $files_path/layer-20-BasicBlock/CONV1/layer_20_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 16 -o 32 -w 32 -g 3 --ba 16 -z 1 --stride 2 --sup --setup -k 1 -t 4 --dir $files_path/layer-20-BasicBlock/CONV1/ --layerid 20
cp $files_path/layer-20-BasicBlock/CONV1/layer_20_OutputA.txt $files_path/layer-20-BasicBlock/RELU1/layer_20_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-20-BasicBlock/RELU1/ --layerid 20
cp $files_path/layer-20-BasicBlock/RELU1/layer_20_OutputA.txt $files_path/layer-20-BasicBlock/CONV2/layer_20_InputA.txt
$onni_path/bin/onni -f 1 --bins 15 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-20-BasicBlock/CONV2/ --layerid 20
cp $files_path/layer-20-BasicBlock/CONV1/layer_20_InputA.txt $files_path/layer-20-BasicBlock/CONV-Residual/layer_20_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 16 -o 32 -w 32 -g 1 --ba 16 -z 0 --stride 2 --sup --setup -k 1 -t 4 --dir $files_path/layer-20-BasicBlock/CONV-Residual/ --layerid 20
python3 run_residual.py --multiplier 2 --num_bits_act 16 --x_path $files_path/layer-20-BasicBlock/CONV-Residual/layer_20_OutputA.txt --y_path $files_path/layer-20-BasicBlock/CONV2/layer_20_OutputA.txt --out_path $files_path/layer-20-BasicBlock/RELU2/layer_20_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-20-BasicBlock/RELU2/ --layerid 20
cp $files_path/layer-20-BasicBlock/RELU2/layer_20_OutputA.txt $files_path/layer-21-BasicBlock/CONV1/layer_21_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-21-BasicBlock/CONV1/ --layerid 21
cp $files_path/layer-21-BasicBlock/CONV1/layer_21_OutputA.txt $files_path/layer-21-BasicBlock/RELU1/layer_21_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-21-BasicBlock/RELU1/ --layerid 21
cp $files_path/layer-21-BasicBlock/RELU1/layer_21_OutputA.txt $files_path/layer-21-BasicBlock/CONV2/layer_21_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-21-BasicBlock/CONV2/ --layerid 21
cp $files_path/layer-21-BasicBlock/CONV2/layer_21_OutputA.txt $files_path/layer-21-BasicBlock/RELU2/layer_21_InputA.txt
cp $files_path/layer-21-BasicBlock/CONV1/layer_21_InputA.txt $files_path/layer-21-BasicBlock/RELU2/layer_21_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-21-BasicBlock/RELU2/ --layerid 21
cp $files_path/layer-21-BasicBlock/RELU2/layer_21_OutputA.txt $files_path/layer-22-BasicBlock/CONV1/layer_22_InputA.txt
$onni_path/bin/onni -f 1 --bins 15 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-22-BasicBlock/CONV1/ --layerid 22
cp $files_path/layer-22-BasicBlock/CONV1/layer_22_OutputA.txt $files_path/layer-22-BasicBlock/RELU1/layer_22_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-22-BasicBlock/RELU1/ --layerid 22
cp $files_path/layer-22-BasicBlock/RELU1/layer_22_OutputA.txt $files_path/layer-22-BasicBlock/CONV2/layer_22_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-22-BasicBlock/CONV2/ --layerid 22
cp $files_path/layer-22-BasicBlock/CONV2/layer_22_OutputA.txt $files_path/layer-22-BasicBlock/RELU2/layer_22_InputA.txt
cp $files_path/layer-22-BasicBlock/CONV1/layer_22_InputA.txt $files_path/layer-22-BasicBlock/RELU2/layer_22_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-22-BasicBlock/RELU2/ --layerid 22
cp $files_path/layer-22-BasicBlock/RELU2/layer_22_OutputA.txt $files_path/layer-23-BasicBlock/CONV1/layer_23_InputA.txt
$onni_path/bin/onni -f 4 --bw 16 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-23-BasicBlock/CONV1/ --layerid 23
cp $files_path/layer-23-BasicBlock/CONV1/layer_23_OutputA.txt $files_path/layer-23-BasicBlock/RELU1/layer_23_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-23-BasicBlock/RELU1/ --layerid 23
cp $files_path/layer-23-BasicBlock/RELU1/layer_23_OutputA.txt $files_path/layer-23-BasicBlock/CONV2/layer_23_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-23-BasicBlock/CONV2/ --layerid 23
cp $files_path/layer-23-BasicBlock/CONV2/layer_23_OutputA.txt $files_path/layer-23-BasicBlock/RELU2/layer_23_InputA.txt
cp $files_path/layer-23-BasicBlock/CONV1/layer_23_InputA.txt $files_path/layer-23-BasicBlock/RELU2/layer_23_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-23-BasicBlock/RELU2/ --layerid 23
cp $files_path/layer-23-BasicBlock/RELU2/layer_23_OutputA.txt $files_path/layer-24-BasicBlock/CONV1/layer_24_InputA.txt
$onni_path/bin/onni -f 1 --bins 13 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-24-BasicBlock/CONV1/ --layerid 24
cp $files_path/layer-24-BasicBlock/CONV1/layer_24_OutputA.txt $files_path/layer-24-BasicBlock/RELU1/layer_24_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-24-BasicBlock/RELU1/ --layerid 24
cp $files_path/layer-24-BasicBlock/RELU1/layer_24_OutputA.txt $files_path/layer-24-BasicBlock/CONV2/layer_24_InputA.txt
$onni_path/bin/onni -f 1 --bins 13 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-24-BasicBlock/CONV2/ --layerid 24
cp $files_path/layer-24-BasicBlock/CONV2/layer_24_OutputA.txt $files_path/layer-24-BasicBlock/RELU2/layer_24_InputA.txt
cp $files_path/layer-24-BasicBlock/CONV1/layer_24_InputA.txt $files_path/layer-24-BasicBlock/RELU2/layer_24_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-24-BasicBlock/RELU2/ --layerid 24
cp $files_path/layer-24-BasicBlock/RELU2/layer_24_OutputA.txt $files_path/layer-25-BasicBlock/CONV1/layer_25_InputA.txt
$onni_path/bin/onni -f 1 --bins 14 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-25-BasicBlock/CONV1/ --layerid 25
cp $files_path/layer-25-BasicBlock/CONV1/layer_25_OutputA.txt $files_path/layer-25-BasicBlock/RELU1/layer_25_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-25-BasicBlock/RELU1/ --layerid 25
cp $files_path/layer-25-BasicBlock/RELU1/layer_25_OutputA.txt $files_path/layer-25-BasicBlock/CONV2/layer_25_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-25-BasicBlock/CONV2/ --layerid 25
cp $files_path/layer-25-BasicBlock/CONV2/layer_25_OutputA.txt $files_path/layer-25-BasicBlock/RELU2/layer_25_InputA.txt
cp $files_path/layer-25-BasicBlock/CONV1/layer_25_InputA.txt $files_path/layer-25-BasicBlock/RELU2/layer_25_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-25-BasicBlock/RELU2/ --layerid 25
cp $files_path/layer-25-BasicBlock/RELU2/layer_25_OutputA.txt $files_path/layer-26-BasicBlock/CONV1/layer_26_InputA.txt
$onni_path/bin/onni -f 1 --bins 10 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-26-BasicBlock/CONV1/ --layerid 26
cp $files_path/layer-26-BasicBlock/CONV1/layer_26_OutputA.txt $files_path/layer-26-BasicBlock/RELU1/layer_26_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-26-BasicBlock/RELU1/ --layerid 26
cp $files_path/layer-26-BasicBlock/RELU1/layer_26_OutputA.txt $files_path/layer-26-BasicBlock/CONV2/layer_26_InputA.txt
$onni_path/bin/onni -f 4 --bw 16 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-26-BasicBlock/CONV2/ --layerid 26
cp $files_path/layer-26-BasicBlock/CONV2/layer_26_OutputA.txt $files_path/layer-26-BasicBlock/RELU2/layer_26_InputA.txt
cp $files_path/layer-26-BasicBlock/CONV1/layer_26_InputA.txt $files_path/layer-26-BasicBlock/RELU2/layer_26_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-26-BasicBlock/RELU2/ --layerid 26
cp $files_path/layer-26-BasicBlock/RELU2/layer_26_OutputA.txt $files_path/layer-27-BasicBlock/CONV1/layer_27_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-27-BasicBlock/CONV1/ --layerid 27
cp $files_path/layer-27-BasicBlock/CONV1/layer_27_OutputA.txt $files_path/layer-27-BasicBlock/RELU1/layer_27_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 9 --br 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-27-BasicBlock/RELU1/ --layerid 27
cp $files_path/layer-27-BasicBlock/RELU1/layer_27_OutputA.txt $files_path/layer-27-BasicBlock/CONV2/layer_27_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-27-BasicBlock/CONV2/ --layerid 27
cp $files_path/layer-27-BasicBlock/CONV2/layer_27_OutputA.txt $files_path/layer-27-BasicBlock/RELU2/layer_27_InputA.txt
cp $files_path/layer-27-BasicBlock/CONV1/layer_27_InputA.txt $files_path/layer-27-BasicBlock/RELU2/layer_27_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-27-BasicBlock/RELU2/ --layerid 27
cp $files_path/layer-27-BasicBlock/RELU2/layer_27_OutputA.txt $files_path/layer-28-BasicBlock/CONV1/layer_28_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-28-BasicBlock/CONV1/ --layerid 28
cp $files_path/layer-28-BasicBlock/CONV1/layer_28_OutputA.txt $files_path/layer-28-BasicBlock/RELU1/layer_28_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-28-BasicBlock/RELU1/ --layerid 28
cp $files_path/layer-28-BasicBlock/RELU1/layer_28_OutputA.txt $files_path/layer-28-BasicBlock/CONV2/layer_28_InputA.txt
$onni_path/bin/onni -f 1 --bins 2 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-28-BasicBlock/CONV2/ --layerid 28
cp $files_path/layer-28-BasicBlock/CONV2/layer_28_OutputA.txt $files_path/layer-28-BasicBlock/RELU2/layer_28_InputA.txt
cp $files_path/layer-28-BasicBlock/CONV1/layer_28_InputA.txt $files_path/layer-28-BasicBlock/RELU2/layer_28_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-28-BasicBlock/RELU2/ --layerid 28
cp $files_path/layer-28-BasicBlock/RELU2/layer_28_OutputA.txt $files_path/layer-29-BasicBlock/CONV1/layer_29_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-29-BasicBlock/CONV1/ --layerid 29
cp $files_path/layer-29-BasicBlock/CONV1/layer_29_OutputA.txt $files_path/layer-29-BasicBlock/RELU1/layer_29_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-29-BasicBlock/RELU1/ --layerid 29
cp $files_path/layer-29-BasicBlock/RELU1/layer_29_OutputA.txt $files_path/layer-29-BasicBlock/CONV2/layer_29_InputA.txt
$onni_path/bin/onni -f 1 --bins 15 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-29-BasicBlock/CONV2/ --layerid 29
cp $files_path/layer-29-BasicBlock/CONV2/layer_29_OutputA.txt $files_path/layer-29-BasicBlock/RELU2/layer_29_InputA.txt
cp $files_path/layer-29-BasicBlock/CONV1/layer_29_InputA.txt $files_path/layer-29-BasicBlock/RELU2/layer_29_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-29-BasicBlock/RELU2/ --layerid 29
cp $files_path/layer-29-BasicBlock/RELU2/layer_29_OutputA.txt $files_path/layer-30-BasicBlock/CONV1/layer_30_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-30-BasicBlock/CONV1/ --layerid 30
cp $files_path/layer-30-BasicBlock/CONV1/layer_30_OutputA.txt $files_path/layer-30-BasicBlock/RELU1/layer_30_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-30-BasicBlock/RELU1/ --layerid 30
cp $files_path/layer-30-BasicBlock/RELU1/layer_30_OutputA.txt $files_path/layer-30-BasicBlock/CONV2/layer_30_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-30-BasicBlock/CONV2/ --layerid 30
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-30-BasicBlock/CONV1/layer_30_InputA.txt --y_path $files_path/layer-30-BasicBlock/CONV2/layer_30_OutputA.txt --out_path $files_path/layer-30-BasicBlock/RELU2/layer_30_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 9 --br 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-30-BasicBlock/RELU2/ --layerid 30
cp $files_path/layer-30-BasicBlock/RELU2/layer_30_OutputA.txt $files_path/layer-31-BasicBlock/CONV1/layer_31_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-31-BasicBlock/CONV1/ --layerid 31
cp $files_path/layer-31-BasicBlock/CONV1/layer_31_OutputA.txt $files_path/layer-31-BasicBlock/RELU1/layer_31_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-31-BasicBlock/RELU1/ --layerid 31
cp $files_path/layer-31-BasicBlock/RELU1/layer_31_OutputA.txt $files_path/layer-31-BasicBlock/CONV2/layer_31_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-31-BasicBlock/CONV2/ --layerid 31
cp $files_path/layer-31-BasicBlock/CONV2/layer_31_OutputA.txt $files_path/layer-31-BasicBlock/RELU2/layer_31_InputA.txt
cp $files_path/layer-31-BasicBlock/CONV1/layer_31_InputA.txt $files_path/layer-31-BasicBlock/RELU2/layer_31_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-31-BasicBlock/RELU2/ --layerid 31
cp $files_path/layer-31-BasicBlock/RELU2/layer_31_OutputA.txt $files_path/layer-32-BasicBlock/CONV1/layer_32_InputA.txt
$onni_path/bin/onni -f 1 --bins 10 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-32-BasicBlock/CONV1/ --layerid 32
cp $files_path/layer-32-BasicBlock/CONV1/layer_32_OutputA.txt $files_path/layer-32-BasicBlock/RELU1/layer_32_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-32-BasicBlock/RELU1/ --layerid 32
cp $files_path/layer-32-BasicBlock/RELU1/layer_32_OutputA.txt $files_path/layer-32-BasicBlock/CONV2/layer_32_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-32-BasicBlock/CONV2/ --layerid 32
cp $files_path/layer-32-BasicBlock/CONV2/layer_32_OutputA.txt $files_path/layer-32-BasicBlock/RELU2/layer_32_InputA.txt
cp $files_path/layer-32-BasicBlock/CONV1/layer_32_InputA.txt $files_path/layer-32-BasicBlock/RELU2/layer_32_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-32-BasicBlock/RELU2/ --layerid 32
cp $files_path/layer-32-BasicBlock/RELU2/layer_32_OutputA.txt $files_path/layer-33-BasicBlock/CONV1/layer_33_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-33-BasicBlock/CONV1/ --layerid 33
cp $files_path/layer-33-BasicBlock/CONV1/layer_33_OutputA.txt $files_path/layer-33-BasicBlock/RELU1/layer_33_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-33-BasicBlock/RELU1/ --layerid 33
cp $files_path/layer-33-BasicBlock/RELU1/layer_33_OutputA.txt $files_path/layer-33-BasicBlock/CONV2/layer_33_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-33-BasicBlock/CONV2/ --layerid 33
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-33-BasicBlock/CONV1/layer_33_InputA.txt --y_path $files_path/layer-33-BasicBlock/CONV2/layer_33_OutputA.txt --out_path $files_path/layer-33-BasicBlock/RELU2/layer_33_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-33-BasicBlock/RELU2/ --layerid 33
cp $files_path/layer-33-BasicBlock/RELU2/layer_33_OutputA.txt $files_path/layer-34-BasicBlock/CONV1/layer_34_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-34-BasicBlock/CONV1/ --layerid 34
cp $files_path/layer-34-BasicBlock/CONV1/layer_34_OutputA.txt $files_path/layer-34-BasicBlock/RELU1/layer_34_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-34-BasicBlock/RELU1/ --layerid 34
cp $files_path/layer-34-BasicBlock/RELU1/layer_34_OutputA.txt $files_path/layer-34-BasicBlock/CONV2/layer_34_InputA.txt
$onni_path/bin/onni -f 1 --bins 10 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-34-BasicBlock/CONV2/ --layerid 34
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-34-BasicBlock/CONV1/layer_34_InputA.txt --y_path $files_path/layer-34-BasicBlock/CONV2/layer_34_OutputA.txt --out_path $files_path/layer-34-BasicBlock/RELU2/layer_34_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-34-BasicBlock/RELU2/ --layerid 34
cp $files_path/layer-34-BasicBlock/RELU2/layer_34_OutputA.txt $files_path/layer-35-BasicBlock/CONV1/layer_35_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-35-BasicBlock/CONV1/ --layerid 35
cp $files_path/layer-35-BasicBlock/CONV1/layer_35_OutputA.txt $files_path/layer-35-BasicBlock/RELU1/layer_35_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-35-BasicBlock/RELU1/ --layerid 35
cp $files_path/layer-35-BasicBlock/RELU1/layer_35_OutputA.txt $files_path/layer-35-BasicBlock/CONV2/layer_35_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-35-BasicBlock/CONV2/ --layerid 35
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-35-BasicBlock/CONV1/layer_35_InputA.txt --y_path $files_path/layer-35-BasicBlock/CONV2/layer_35_OutputA.txt --out_path $files_path/layer-35-BasicBlock/RELU2/layer_35_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-35-BasicBlock/RELU2/ --layerid 35
cp $files_path/layer-35-BasicBlock/RELU2/layer_35_OutputA.txt $files_path/layer-36-BasicBlock/CONV1/layer_36_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-36-BasicBlock/CONV1/ --layerid 36
cp $files_path/layer-36-BasicBlock/CONV1/layer_36_OutputA.txt $files_path/layer-36-BasicBlock/RELU1/layer_36_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-36-BasicBlock/RELU1/ --layerid 36
cp $files_path/layer-36-BasicBlock/RELU1/layer_36_OutputA.txt $files_path/layer-36-BasicBlock/CONV2/layer_36_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-36-BasicBlock/CONV2/ --layerid 36
cp $files_path/layer-36-BasicBlock/CONV2/layer_36_OutputA.txt $files_path/layer-36-BasicBlock/RELU2/layer_36_InputA.txt
cp $files_path/layer-36-BasicBlock/CONV1/layer_36_InputA.txt $files_path/layer-36-BasicBlock/RELU2/layer_36_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-36-BasicBlock/RELU2/ --layerid 36
cp $files_path/layer-36-BasicBlock/RELU2/layer_36_OutputA.txt $files_path/layer-37-BasicBlock/CONV1/layer_37_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-37-BasicBlock/CONV1/ --layerid 37
cp $files_path/layer-37-BasicBlock/CONV1/layer_37_OutputA.txt $files_path/layer-37-BasicBlock/RELU1/layer_37_InputA.txt
$onni_path/bin/onni -f 2 -i 32 -w 16 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-37-BasicBlock/RELU1/ --layerid 37
cp $files_path/layer-37-BasicBlock/RELU1/layer_37_OutputA.txt $files_path/layer-37-BasicBlock/CONV2/layer_37_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 32 -o 32 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-37-BasicBlock/CONV2/ --layerid 37
cp $files_path/layer-37-BasicBlock/CONV2/layer_37_OutputA.txt $files_path/layer-37-BasicBlock/RELU2/layer_37_InputA.txt
cp $files_path/layer-37-BasicBlock/CONV1/layer_37_InputA.txt $files_path/layer-37-BasicBlock/RELU2/layer_37_InputRA.txt
$onni_path/bin/onni -f 6 -i 32 -w 16 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-37-BasicBlock/RELU2/ --layerid 37
cp $files_path/layer-37-BasicBlock/RELU2/layer_37_OutputA.txt $files_path/layer-38-BasicBlock/CONV1/layer_38_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 32 -o 64 -w 16 -g 3 --ba 16 -z 1 --stride 2 --sup --setup -k 1 -t 4 --dir $files_path/layer-38-BasicBlock/CONV1/ --layerid 38
cp $files_path/layer-38-BasicBlock/CONV1/layer_38_OutputA.txt $files_path/layer-38-BasicBlock/RELU1/layer_38_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-38-BasicBlock/RELU1/ --layerid 38
cp $files_path/layer-38-BasicBlock/RELU1/layer_38_OutputA.txt $files_path/layer-38-BasicBlock/CONV2/layer_38_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-38-BasicBlock/CONV2/ --layerid 38
cp $files_path/layer-38-BasicBlock/CONV1/layer_38_InputA.txt $files_path/layer-38-BasicBlock/CONV-Residual/layer_38_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 32 -o 64 -w 16 -g 1 --ba 16 -z 0 --stride 2 --sup --setup -k 1 -t 4 --dir $files_path/layer-38-BasicBlock/CONV-Residual/ --layerid 38
python3 run_residual.py --multiplier 8 --num_bits_act 16 --x_path $files_path/layer-38-BasicBlock/CONV-Residual/layer_38_OutputA.txt --y_path $files_path/layer-38-BasicBlock/CONV2/layer_38_OutputA.txt --out_path $files_path/layer-38-BasicBlock/RELU2/layer_38_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-38-BasicBlock/RELU2/ --layerid 38
cp $files_path/layer-38-BasicBlock/RELU2/layer_38_OutputA.txt $files_path/layer-39-BasicBlock/CONV1/layer_39_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-39-BasicBlock/CONV1/ --layerid 39
cp $files_path/layer-39-BasicBlock/CONV1/layer_39_OutputA.txt $files_path/layer-39-BasicBlock/RELU1/layer_39_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-39-BasicBlock/RELU1/ --layerid 39
cp $files_path/layer-39-BasicBlock/RELU1/layer_39_OutputA.txt $files_path/layer-39-BasicBlock/CONV2/layer_39_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-39-BasicBlock/CONV2/ --layerid 39
cp $files_path/layer-39-BasicBlock/CONV2/layer_39_OutputA.txt $files_path/layer-39-BasicBlock/RELU2/layer_39_InputA.txt
cp $files_path/layer-39-BasicBlock/CONV1/layer_39_InputA.txt $files_path/layer-39-BasicBlock/RELU2/layer_39_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-39-BasicBlock/RELU2/ --layerid 39
cp $files_path/layer-39-BasicBlock/RELU2/layer_39_OutputA.txt $files_path/layer-40-BasicBlock/CONV1/layer_40_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-40-BasicBlock/CONV1/ --layerid 40
cp $files_path/layer-40-BasicBlock/CONV1/layer_40_OutputA.txt $files_path/layer-40-BasicBlock/RELU1/layer_40_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-40-BasicBlock/RELU1/ --layerid 40
cp $files_path/layer-40-BasicBlock/RELU1/layer_40_OutputA.txt $files_path/layer-40-BasicBlock/CONV2/layer_40_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-40-BasicBlock/CONV2/ --layerid 40
cp $files_path/layer-40-BasicBlock/CONV2/layer_40_OutputA.txt $files_path/layer-40-BasicBlock/RELU2/layer_40_InputA.txt
cp $files_path/layer-40-BasicBlock/CONV1/layer_40_InputA.txt $files_path/layer-40-BasicBlock/RELU2/layer_40_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-40-BasicBlock/RELU2/ --layerid 40
cp $files_path/layer-40-BasicBlock/RELU2/layer_40_OutputA.txt $files_path/layer-41-BasicBlock/CONV1/layer_41_InputA.txt
$onni_path/bin/onni -f 1 --bins 13 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-41-BasicBlock/CONV1/ --layerid 41
cp $files_path/layer-41-BasicBlock/CONV1/layer_41_OutputA.txt $files_path/layer-41-BasicBlock/RELU1/layer_41_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-41-BasicBlock/RELU1/ --layerid 41
cp $files_path/layer-41-BasicBlock/RELU1/layer_41_OutputA.txt $files_path/layer-41-BasicBlock/CONV2/layer_41_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-41-BasicBlock/CONV2/ --layerid 41
cp $files_path/layer-41-BasicBlock/CONV2/layer_41_OutputA.txt $files_path/layer-41-BasicBlock/RELU2/layer_41_InputA.txt
cp $files_path/layer-41-BasicBlock/CONV1/layer_41_InputA.txt $files_path/layer-41-BasicBlock/RELU2/layer_41_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-41-BasicBlock/RELU2/ --layerid 41
cp $files_path/layer-41-BasicBlock/RELU2/layer_41_OutputA.txt $files_path/layer-42-BasicBlock/CONV1/layer_42_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-42-BasicBlock/CONV1/ --layerid 42
cp $files_path/layer-42-BasicBlock/CONV1/layer_42_OutputA.txt $files_path/layer-42-BasicBlock/RELU1/layer_42_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-42-BasicBlock/RELU1/ --layerid 42
cp $files_path/layer-42-BasicBlock/RELU1/layer_42_OutputA.txt $files_path/layer-42-BasicBlock/CONV2/layer_42_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-42-BasicBlock/CONV2/ --layerid 42
cp $files_path/layer-42-BasicBlock/CONV2/layer_42_OutputA.txt $files_path/layer-42-BasicBlock/RELU2/layer_42_InputA.txt
cp $files_path/layer-42-BasicBlock/CONV1/layer_42_InputA.txt $files_path/layer-42-BasicBlock/RELU2/layer_42_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-42-BasicBlock/RELU2/ --layerid 42
cp $files_path/layer-42-BasicBlock/RELU2/layer_42_OutputA.txt $files_path/layer-43-BasicBlock/CONV1/layer_43_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-43-BasicBlock/CONV1/ --layerid 43
cp $files_path/layer-43-BasicBlock/CONV1/layer_43_OutputA.txt $files_path/layer-43-BasicBlock/RELU1/layer_43_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-43-BasicBlock/RELU1/ --layerid 43
cp $files_path/layer-43-BasicBlock/RELU1/layer_43_OutputA.txt $files_path/layer-43-BasicBlock/CONV2/layer_43_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-43-BasicBlock/CONV2/ --layerid 43
cp $files_path/layer-43-BasicBlock/CONV2/layer_43_OutputA.txt $files_path/layer-43-BasicBlock/RELU2/layer_43_InputA.txt
cp $files_path/layer-43-BasicBlock/CONV1/layer_43_InputA.txt $files_path/layer-43-BasicBlock/RELU2/layer_43_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-43-BasicBlock/RELU2/ --layerid 43
cp $files_path/layer-43-BasicBlock/RELU2/layer_43_OutputA.txt $files_path/layer-44-BasicBlock/CONV1/layer_44_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-44-BasicBlock/CONV1/ --layerid 44
cp $files_path/layer-44-BasicBlock/CONV1/layer_44_OutputA.txt $files_path/layer-44-BasicBlock/RELU1/layer_44_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 9 --br 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-44-BasicBlock/RELU1/ --layerid 44
cp $files_path/layer-44-BasicBlock/RELU1/layer_44_OutputA.txt $files_path/layer-44-BasicBlock/CONV2/layer_44_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-44-BasicBlock/CONV2/ --layerid 44
cp $files_path/layer-44-BasicBlock/CONV2/layer_44_OutputA.txt $files_path/layer-44-BasicBlock/RELU2/layer_44_InputA.txt
cp $files_path/layer-44-BasicBlock/CONV1/layer_44_InputA.txt $files_path/layer-44-BasicBlock/RELU2/layer_44_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-44-BasicBlock/RELU2/ --layerid 44
cp $files_path/layer-44-BasicBlock/RELU2/layer_44_OutputA.txt $files_path/layer-45-BasicBlock/CONV1/layer_45_InputA.txt
$onni_path/bin/onni -f 1 --bins 13 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-45-BasicBlock/CONV1/ --layerid 45
cp $files_path/layer-45-BasicBlock/CONV1/layer_45_OutputA.txt $files_path/layer-45-BasicBlock/RELU1/layer_45_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 4 --sup --setup -k 1 -t 4 --dir $files_path/layer-45-BasicBlock/RELU1/ --layerid 45
cp $files_path/layer-45-BasicBlock/RELU1/layer_45_OutputA.txt $files_path/layer-45-BasicBlock/CONV2/layer_45_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-45-BasicBlock/CONV2/ --layerid 45
cp $files_path/layer-45-BasicBlock/CONV2/layer_45_OutputA.txt $files_path/layer-45-BasicBlock/RELU2/layer_45_InputA.txt
cp $files_path/layer-45-BasicBlock/CONV1/layer_45_InputA.txt $files_path/layer-45-BasicBlock/RELU2/layer_45_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 9 --br 7 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-45-BasicBlock/RELU2/ --layerid 45
cp $files_path/layer-45-BasicBlock/RELU2/layer_45_OutputA.txt $files_path/layer-46-BasicBlock/CONV1/layer_46_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-46-BasicBlock/CONV1/ --layerid 46
cp $files_path/layer-46-BasicBlock/CONV1/layer_46_OutputA.txt $files_path/layer-46-BasicBlock/RELU1/layer_46_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-46-BasicBlock/RELU1/ --layerid 46
cp $files_path/layer-46-BasicBlock/RELU1/layer_46_OutputA.txt $files_path/layer-46-BasicBlock/CONV2/layer_46_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-46-BasicBlock/CONV2/ --layerid 46
cp $files_path/layer-46-BasicBlock/CONV2/layer_46_OutputA.txt $files_path/layer-46-BasicBlock/RELU2/layer_46_InputA.txt
cp $files_path/layer-46-BasicBlock/CONV1/layer_46_InputA.txt $files_path/layer-46-BasicBlock/RELU2/layer_46_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-46-BasicBlock/RELU2/ --layerid 46
cp $files_path/layer-46-BasicBlock/RELU2/layer_46_OutputA.txt $files_path/layer-47-BasicBlock/CONV1/layer_47_InputA.txt
$onni_path/bin/onni -f 1 --bins 10 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-47-BasicBlock/CONV1/ --layerid 47
cp $files_path/layer-47-BasicBlock/CONV1/layer_47_OutputA.txt $files_path/layer-47-BasicBlock/RELU1/layer_47_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-47-BasicBlock/RELU1/ --layerid 47
cp $files_path/layer-47-BasicBlock/RELU1/layer_47_OutputA.txt $files_path/layer-47-BasicBlock/CONV2/layer_47_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-47-BasicBlock/CONV2/ --layerid 47
cp $files_path/layer-47-BasicBlock/CONV2/layer_47_OutputA.txt $files_path/layer-47-BasicBlock/RELU2/layer_47_InputA.txt
cp $files_path/layer-47-BasicBlock/CONV1/layer_47_InputA.txt $files_path/layer-47-BasicBlock/RELU2/layer_47_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-47-BasicBlock/RELU2/ --layerid 47
cp $files_path/layer-47-BasicBlock/RELU2/layer_47_OutputA.txt $files_path/layer-48-BasicBlock/CONV1/layer_48_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-48-BasicBlock/CONV1/ --layerid 48
cp $files_path/layer-48-BasicBlock/CONV1/layer_48_OutputA.txt $files_path/layer-48-BasicBlock/RELU1/layer_48_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-48-BasicBlock/RELU1/ --layerid 48
cp $files_path/layer-48-BasicBlock/RELU1/layer_48_OutputA.txt $files_path/layer-48-BasicBlock/CONV2/layer_48_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-48-BasicBlock/CONV2/ --layerid 48
cp $files_path/layer-48-BasicBlock/CONV2/layer_48_OutputA.txt $files_path/layer-48-BasicBlock/RELU2/layer_48_InputA.txt
cp $files_path/layer-48-BasicBlock/CONV1/layer_48_InputA.txt $files_path/layer-48-BasicBlock/RELU2/layer_48_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-48-BasicBlock/RELU2/ --layerid 48
cp $files_path/layer-48-BasicBlock/RELU2/layer_48_OutputA.txt $files_path/layer-49-BasicBlock/CONV1/layer_49_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-49-BasicBlock/CONV1/ --layerid 49
cp $files_path/layer-49-BasicBlock/CONV1/layer_49_OutputA.txt $files_path/layer-49-BasicBlock/RELU1/layer_49_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-49-BasicBlock/RELU1/ --layerid 49
cp $files_path/layer-49-BasicBlock/RELU1/layer_49_OutputA.txt $files_path/layer-49-BasicBlock/CONV2/layer_49_InputA.txt
$onni_path/bin/onni -f 1 --bins 4 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-49-BasicBlock/CONV2/ --layerid 49
cp $files_path/layer-49-BasicBlock/CONV2/layer_49_OutputA.txt $files_path/layer-49-BasicBlock/RELU2/layer_49_InputA.txt
cp $files_path/layer-49-BasicBlock/CONV1/layer_49_InputA.txt $files_path/layer-49-BasicBlock/RELU2/layer_49_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-49-BasicBlock/RELU2/ --layerid 49
cp $files_path/layer-49-BasicBlock/RELU2/layer_49_OutputA.txt $files_path/layer-50-BasicBlock/CONV1/layer_50_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-50-BasicBlock/CONV1/ --layerid 50
cp $files_path/layer-50-BasicBlock/CONV1/layer_50_OutputA.txt $files_path/layer-50-BasicBlock/RELU1/layer_50_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-50-BasicBlock/RELU1/ --layerid 50
cp $files_path/layer-50-BasicBlock/RELU1/layer_50_OutputA.txt $files_path/layer-50-BasicBlock/CONV2/layer_50_InputA.txt
$onni_path/bin/onni -f 1 --bins 6 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-50-BasicBlock/CONV2/ --layerid 50
cp $files_path/layer-50-BasicBlock/CONV2/layer_50_OutputA.txt $files_path/layer-50-BasicBlock/RELU2/layer_50_InputA.txt
cp $files_path/layer-50-BasicBlock/CONV1/layer_50_InputA.txt $files_path/layer-50-BasicBlock/RELU2/layer_50_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-50-BasicBlock/RELU2/ --layerid 50
cp $files_path/layer-50-BasicBlock/RELU2/layer_50_OutputA.txt $files_path/layer-51-BasicBlock/CONV1/layer_51_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-51-BasicBlock/CONV1/ --layerid 51
cp $files_path/layer-51-BasicBlock/CONV1/layer_51_OutputA.txt $files_path/layer-51-BasicBlock/RELU1/layer_51_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-51-BasicBlock/RELU1/ --layerid 51
cp $files_path/layer-51-BasicBlock/RELU1/layer_51_OutputA.txt $files_path/layer-51-BasicBlock/CONV2/layer_51_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-51-BasicBlock/CONV2/ --layerid 51
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-51-BasicBlock/CONV1/layer_51_InputA.txt --y_path $files_path/layer-51-BasicBlock/CONV2/layer_51_OutputA.txt --out_path $files_path/layer-51-BasicBlock/RELU2/layer_51_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-51-BasicBlock/RELU2/ --layerid 51
cp $files_path/layer-51-BasicBlock/RELU2/layer_51_OutputA.txt $files_path/layer-52-BasicBlock/CONV1/layer_52_InputA.txt
$onni_path/bin/onni -f 1 --bins 11 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-52-BasicBlock/CONV1/ --layerid 52
cp $files_path/layer-52-BasicBlock/CONV1/layer_52_OutputA.txt $files_path/layer-52-BasicBlock/RELU1/layer_52_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-52-BasicBlock/RELU1/ --layerid 52
cp $files_path/layer-52-BasicBlock/RELU1/layer_52_OutputA.txt $files_path/layer-52-BasicBlock/CONV2/layer_52_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-52-BasicBlock/CONV2/ --layerid 52
cp $files_path/layer-52-BasicBlock/CONV2/layer_52_OutputA.txt $files_path/layer-52-BasicBlock/RELU2/layer_52_InputA.txt
cp $files_path/layer-52-BasicBlock/CONV1/layer_52_InputA.txt $files_path/layer-52-BasicBlock/RELU2/layer_52_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 9 --br 7 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-52-BasicBlock/RELU2/ --layerid 52
cp $files_path/layer-52-BasicBlock/RELU2/layer_52_OutputA.txt $files_path/layer-53-BasicBlock/CONV1/layer_53_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-53-BasicBlock/CONV1/ --layerid 53
cp $files_path/layer-53-BasicBlock/CONV1/layer_53_OutputA.txt $files_path/layer-53-BasicBlock/RELU1/layer_53_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-53-BasicBlock/RELU1/ --layerid 53
cp $files_path/layer-53-BasicBlock/RELU1/layer_53_OutputA.txt $files_path/layer-53-BasicBlock/CONV2/layer_53_InputA.txt
$onni_path/bin/onni -f 1 --bins 10 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-53-BasicBlock/CONV2/ --layerid 53
cp $files_path/layer-53-BasicBlock/CONV2/layer_53_OutputA.txt $files_path/layer-53-BasicBlock/RELU2/layer_53_InputA.txt
cp $files_path/layer-53-BasicBlock/CONV1/layer_53_InputA.txt $files_path/layer-53-BasicBlock/RELU2/layer_53_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 10 --br 6 --bs 10 --bl 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-53-BasicBlock/RELU2/ --layerid 53
cp $files_path/layer-53-BasicBlock/RELU2/layer_53_OutputA.txt $files_path/layer-54-BasicBlock/CONV1/layer_54_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-54-BasicBlock/CONV1/ --layerid 54
cp $files_path/layer-54-BasicBlock/CONV1/layer_54_OutputA.txt $files_path/layer-54-BasicBlock/RELU1/layer_54_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 5 --sup --setup -k 1 -t 4 --dir $files_path/layer-54-BasicBlock/RELU1/ --layerid 54
cp $files_path/layer-54-BasicBlock/RELU1/layer_54_OutputA.txt $files_path/layer-54-BasicBlock/CONV2/layer_54_InputA.txt
$onni_path/bin/onni -f 1 --bins 14 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-54-BasicBlock/CONV2/ --layerid 54
python3 run_residual.py --multiplier 64 --num_bits_act 16 --x_path $files_path/layer-54-BasicBlock/CONV1/layer_54_InputA.txt --y_path $files_path/layer-54-BasicBlock/CONV2/layer_54_OutputA.txt --out_path $files_path/layer-54-BasicBlock/RELU2/layer_54_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-54-BasicBlock/RELU2/ --layerid 54
cp $files_path/layer-54-BasicBlock/RELU2/layer_54_OutputA.txt $files_path/layer-55-BasicBlock/CONV1/layer_55_InputA.txt
$onni_path/bin/onni -f 1 --bins 7 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-55-BasicBlock/CONV1/ --layerid 55
cp $files_path/layer-55-BasicBlock/CONV1/layer_55_OutputA.txt $files_path/layer-55-BasicBlock/RELU1/layer_55_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-55-BasicBlock/RELU1/ --layerid 55
cp $files_path/layer-55-BasicBlock/RELU1/layer_55_OutputA.txt $files_path/layer-55-BasicBlock/CONV2/layer_55_InputA.txt
$onni_path/bin/onni -f 1 --bins 15 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-55-BasicBlock/CONV2/ --layerid 55
cp $files_path/layer-55-BasicBlock/CONV2/layer_55_OutputA.txt $files_path/layer-55-BasicBlock/RELU2/layer_55_InputA.txt
cp $files_path/layer-55-BasicBlock/CONV1/layer_55_InputA.txt $files_path/layer-55-BasicBlock/RELU2/layer_55_InputRA.txt
$onni_path/bin/onni -f 6 -i 64 -w 8 -g 1 --ba 12 --br 3 --bs 10 --bl 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-55-BasicBlock/RELU2/ --layerid 55
cp $files_path/layer-55-BasicBlock/RELU2/layer_55_OutputA.txt $files_path/layer-56-SUMPOOL2D/layer_56_InputA.txt
python3 run_sum_pool.py --path $files_path/layer-56-SUMPOOL2D/layer_56_InputA.txt --num_bits 16 --channels 64 --width 8
$onni_path/bin/onni -f 2 -i 64 -w 1 -g 1 --ba 10 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-56-SUMPOOL2D/ --layerid 56
cp $files_path/layer-56-SUMPOOL2D/layer_56_OutputA.txt $files_path/layer-57-LINEAR/layer_57_InputA.txt
$onni_path/bin/onni -f 1 --bins 12 -i 64 -o 10 -w 1 -g 1 --ba 16 -z 0 --sup --setup -k 1 -t 2 --dir $files_path/layer-57-LINEAR/ --layerid 57
cp $files_path/layer-57-LINEAR/layer_57_OutputA.txt $files_path/layer-58-ARGMAX/layer_58_InputA.txt
$onni_path/bin/onni -f 7 -e 10 --sup --setup -k 1 -t 1 --dir $files_path/layer-58-ARGMAX/ --layerid 58
