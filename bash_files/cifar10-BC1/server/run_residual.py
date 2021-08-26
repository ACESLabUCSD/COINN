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
parser.add_argument('--multiplier', type=int,help='multiplier (used for left shifting input 1)')
parser.add_argument('--num_bits_act', type=int,help='number of activation bits')
parser.add_argument('--x_path', type=str,help='path to input 1, to be shefted left')
parser.add_argument('--y_path', type=str,help='path to input 2')
parser.add_argument('--out_path', type=str,help='path to output of residual addition')
args = parser.parse_args()

x = np.loadtxt(args.x_path)
y = np.loadtxt(args.y_path)
x = x*args.multiplier
x = overflow(x, args.num_bits_act)
y = overflow(y+x, args.num_bits_act)
np.savetxt(args.out_path, y, fmt='%d', delimiter='\n', newline='\n')

