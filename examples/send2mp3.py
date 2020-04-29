import serial
import string
import math
import argparse
from argparse import RawTextHelpFormatter

# Setup the arguments parser and description
parser = argparse.ArgumentParser(
formatter_class=RawTextHelpFormatter,
prog="send2mp3",
description="The purpose of this program is to convert and then,\n\
send audio files to Nexys 4 board loaded with MP3_Project.",
epilog="Program wrote by Martin AUCHER and Kevin PEREZ\n\
for ENSEIRB-MATMECA Numerical conception courses.\n\
https://github.com/arkamor/PR209_MP3\n ", conflict_handler='resolve')


group = parser.add_mutually_exclusive_group()
group.add_argument("-v", "--verbosity", help="Increase output verbosity (max 2)", action="store_true")#, action="count")
group.add_argument("-q", "--quiet", help="No output", action="store_true")

parser.add_argument("file", help="Path to the file to convert", type=str)
parser.add_argument("-b", help="Change Baudrate,   default : 921600", type=int, default=921600)
parser.add_argument("-p", help="Change seial Port, default : /dev/ttyUSB1", type=str, default="/dev/ttyUSB1")

args = parser.parse_args()

if args.verbosity:
    print("verbosity turned on : " + str(args.verbosity))

print("Sending file : \"" + args.file + "\" at " + str(args.b) + " bauds on \"" + str(args.p) + "\"")

ser = serial.Serial(args.p, args.b, 8, 'N', 1, timeout=1)

""" fonctionne absolument bien """
f=open(args.file,"rb")
num=list(f.read())

listofzeros = [0]*2**18

f.close()

print("Clearing RAM")
ser.write(listofzeros) # ? clear ram

print("Writing RAM")
ser.write(num) # ! write data to ram

print("Done")