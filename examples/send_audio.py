from pydub import AudioSegment
import time
import wave
import struct
import tkinter as tk
from tkinter import filedialog
import os
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

parser.add_argument("-b", help="Change Baudrate,   default : 921600", type=int, default=921600)
parser.add_argument("-p", help="Change seial Port, default : /dev/ttyUSB1", type=str, default="/dev/ttyUSB1")

args = parser.parse_args()

if args.verbosity:
    print("verbosity turned on : " + str(args.verbosity))

ser = serial.Serial(args.p, args.b, 8, 'N', 1, timeout=1)

root = tk.Tk()
root.withdraw()

#? variables definition ?#

# Target sample rate
SampleRate = 44100 #! sample/seconds !#

# Target max len
max_len = 6 #! seconds !#

# Arguments de lancement
loop = 0

# Temp 
tmp_file = "/tmp/aud2mp3.wav"

in_file = filedialog.askopenfilename()

print("Sending file : \"" + in_file + "\" at " + str(args.b) + " bauds on \"" + str(args.p) + "\"")

# chemin du fichier converti
out_file = '/tmp/aud2mp3.uart'

start_time = time.time()

song = AudioSegment.from_file(in_file, in_file.split(".")[-1])

song_len = song.duration_seconds

if(song_len < max_len):
    if(loop):
        song = song * int((max_len/song_len))
    else:
        song = song + AudioSegment.silent(duration=1000*(max_len-song_len))
else:
    song = song[:1000*max_len]


song.export(tmp_file, format="wav")

# objet Wave_read du fichier
file_wav = wave.open(tmp_file, mode='rb')
os.remove(tmp_file)

file_uart = open(out_file, 'wb')

# debug
print(file_wav.getparams())

# récupération des caracteristiques du fichier
samp_width = file_wav.getsampwidth()
channels   = file_wav.getnchannels()
Fs         = file_wav.getframerate()
l          = file_wav.getnframes()
y          = file_wav.readframes(l*samp_width*channels)

left  = []
right = []

for i in range(0, l*samp_width*channels, 4):
  left.append(int.from_bytes(y[i:i+2], byteorder='little', signed=True))
  right.append(int.from_bytes(y[i+2:i+4], byteorder='little', signed=True))

# Stereo to mono
audio = [int(left[i]+right[i])/2 for i in range(0,l)]

# Normalizing
mini = min(audio)
maxi = max(audio)
if(maxi > mini): #max plus grand
    audio = [int((x*1024)/maxi) for x in audio]  
else: #%min plus grand
    audio = [int((x*1024)/mini) for x in audio]

for i in range(0, l):
    file_uart.write(audio[i].to_bytes(2, 'little', signed=True))



""" fonctionne absolument bien """
f=open(out_file,"rb")
num=list(f.read())

listofzeros = [0]*2**18

f.close()

print("Clearing RAM")
ser.write(listofzeros) # ? clear ram

print("Writing RAM")
ser.write(num) # ! write data to ram

print("Done")

spent = time.time()-start_time
print("Time spent : ", end="")
print(f'{spent:.1f}')

file_uart.close()
file_wav.close()