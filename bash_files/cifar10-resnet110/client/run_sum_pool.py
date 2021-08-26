import numpy as np
import argparse
def overflow(integers, num_bits):
	mods = np.fmod(integers, 2**num_bits)
	signs = np.sign(integers)

	mask = (mods * signs) < 2**(num_bits-1)
	mask = mask.astype(np.int32)

	out = (mods*mask) + ((mods - signs*(2**num_bits))*(1.-mask))

	mask_ = (mods == -2**(num_bits-1)).astype(np.int32)

	out = (mask_*mods) + (1.-mask_)*out

	return out

parser = argparse.ArgumentParser(description='PyTorch ConvNet Training')
parser.add_argument('--path', type=str,help='path to saved input file')
parser.add_argument('--channels', type=int, help='number of channels')
parser.add_argument('--width', type=int, help='width and height of input')
parser.add_argument('--num_bits', type=int, help='number of bits')

args = parser.parse_args()
x = np.loadtxt(args.path)
x = x.reshape(args.width, args.width, args.channels)# this is the order at which the c++ code has written its output to the file

x = np.sum(x,axis=0)
x = np.sum(x,axis=0)
x = overflow(x,args.num_bits)
np.savetxt(args.path, x.ravel(),fmt='%d', delimiter='\n', newline='\n')