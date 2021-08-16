import numpy as np
import argparse 
parser = argparse.ArgumentParser(description='PyTorch ConvNet Training')
parser.add_argument('--path', type=str,help='path to saved input file')
parser.add_argument('--channels', type=int, help='number of channels')
parser.add_argument('--width', type=int, help='width and height of input')

args = parser.parse_args()
x = np.loadtxt(args.path)
x = x.reshape(args.width, args.width, args.channels)# this is the order at which the c++ code has written its output to the file
x = np.sum(x,axis=0)
x = np.sum(x,axis=0)
np.savetxt(args.path, x.ravel(),fmt='%d', delimiter='\n', newline='\n')