#!/bin/bash
onni_path="../../../onni"
files_path="."
$onni_path/bin/onni -f 1 --bins 14 -i 3 -o 64 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-0-CONV/ --layerid 0
cp $files_path/layer-0-CONV/layer_0_OutputA.txt $files_path/layer-1-RELU/layer_1_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 32 -g 1 --ba 12 --br 2 --sup --setup -k 1 -t 4 --dir $files_path/layer-1-RELU/ --layerid 1
cp $files_path/layer-1-RELU/layer_1_OutputA.txt $files_path/layer-2-CONV/layer_2_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 32 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-2-CONV/ --layerid 2
cp $files_path/layer-2-CONV/layer_2_OutputA.txt $files_path/layer-3-MP-RELU/layer_3_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 32 -g 2 --ba 9 --br 7 --stride 2 --padding 0 --sup --setup -k 1 -t 4 --dir $files_path/layer-3-MP-RELU/ --layerid 3
cp $files_path/layer-3-MP-RELU/layer_3_OutputA.txt $files_path/layer-4-CONV/layer_4_InputA.txt
$onni_path/bin/onni -f 1 --bins 8 -i 64 -o 64 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-4-CONV/ --layerid 4
cp $files_path/layer-4-CONV/layer_4_OutputA.txt $files_path/layer-5-RELU/layer_5_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 16 -g 1 --ba 7 --br 9 --sup --setup -k 1 -t 4 --dir $files_path/layer-5-RELU/ --layerid 5
cp $files_path/layer-5-RELU/layer_5_OutputA.txt $files_path/layer-6-CONV/layer_6_InputA.txt
$onni_path/bin/onni -f 1 --bins 5 -i 64 -o 64 -w 16 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-6-CONV/ --layerid 6
cp $files_path/layer-6-CONV/layer_6_OutputA.txt $files_path/layer-7-MP-RELU/layer_7_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 16 -g 2 --ba 9 --br 5 --stride 2 --padding 0 --sup --setup -k 1 -t 4 --dir $files_path/layer-7-MP-RELU/ --layerid 7
cp $files_path/layer-7-MP-RELU/layer_7_OutputA.txt $files_path/layer-8-CONV/layer_8_InputA.txt
$onni_path/bin/onni -f 1 --bins 9 -i 64 -o 64 -w 8 -g 3 --ba 16 -z 1 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-8-CONV/ --layerid 8
cp $files_path/layer-8-CONV/layer_8_OutputA.txt $files_path/layer-9-RELU/layer_9_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 9 --br 7 --sup --setup -k 1 -t 4 --dir $files_path/layer-9-RELU/ --layerid 9
cp $files_path/layer-9-RELU/layer_9_OutputA.txt $files_path/layer-10-CONV/layer_10_InputA.txt
$onni_path/bin/onni -f 4 --bw 16 -i 64 -o 64 -w 8 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-10-CONV/ --layerid 10
cp $files_path/layer-10-CONV/layer_10_OutputA.txt $files_path/layer-11-RELU/layer_11_InputA.txt
$onni_path/bin/onni -f 2 -i 64 -w 8 -g 1 --ba 8 --br 6 --sup --setup -k 1 -t 4 --dir $files_path/layer-11-RELU/ --layerid 11
cp $files_path/layer-11-RELU/layer_11_OutputA.txt $files_path/layer-12-CONV/layer_12_InputA.txt
$onni_path/bin/onni -f 4 --bw 16 -i 64 -o 16 -w 8 -g 1 --ba 16 -z 0 --stride 1 --sup --setup -k 1 -t 4 --dir $files_path/layer-12-CONV/ --layerid 12
cp $files_path/layer-12-CONV/layer_12_OutputA.txt $files_path/layer-13-RELU/layer_13_InputA.txt
$onni_path/bin/onni -f 2 -i 16 -w 8 -g 1 --ba 7 --br 8 --sup --setup -k 1 -t 4 --dir $files_path/layer-13-RELU/ --layerid 13
cp $files_path/layer-13-RELU/layer_13_OutputA.txt $files_path/layer-14-LINEAR/layer_14_InputA.txt
python3 run_flatten.py --path $files_path/layer-14-LINEAR/layer_14_InputA.txt --channels 16 --width 8
$onni_path/bin/onni -f 1 --bins 9 -i 1024 -o 10 -w 1 -g 1 --ba 16 -z 0 --sup --setup -k 1 -t 2 --dir $files_path/layer-14-LINEAR/ --layerid 14
