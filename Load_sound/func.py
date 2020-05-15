############################################################
## Python send_audio for audio Project  	              ##
## by Martin AUCHER & Kevin PEREZ, 04/2020                ##
##                                                        ##
## Code used for audio Project courses at ENSEIRB-MATMECA ##
############################################################
 
from pydub import AudioSegment
import argparse
from argparse import RawTextHelpFormatter

def normalize(audio):
    # Normalizing
    mini = min(audio)
    maxi = max(audio)
    if(maxi > mini): #max plus grand
        return [int((x*1024)/maxi) for x in audio]  
    else: #%min plus grand
        return [int((x*1024)/mini) for x in audio]

def file2mono(file_wav):
    # récupération des caracteristiques du fichier
    samp_width = file_wav.getsampwidth()
    channels   = file_wav.getnchannels()
    Fs         = file_wav.getframerate()
    l          = file_wav.getnframes()
    y          = file_wav.readframes(l*samp_width*channels)
  
    if(channels-1):
           
        left  = []
        right = []

        for i in range(0, len(y), 4):
            left.append(int.from_bytes(y[i:i+2], byteorder='little', signed=True))
            right.append(int.from_bytes(y[i+2:i+4], byteorder='little', signed=True))
            
        return [int(left[i]+right[i])/2 for i in range(0,len(right))]

    return y

def audio2wav(in_file,out_file,SampleRate,max_len):

    song = AudioSegment.from_file(in_file, in_file.split(".")[-1]).set_frame_rate(SampleRate)

    song_len = song.duration_seconds

    if(song_len < max_len):
        song = song * int((max_len/song_len))
    else:
        song = song[:1000*max_len]

    song.export(out_file, format="wav")

def set_parser():
    # Setup the arguments parser and description
    parser = argparse.ArgumentParser(
    formatter_class=RawTextHelpFormatter,
    prog="send2mp3",
    description="The purpose of this program is to convert and then,\nsend audio files to Nexys 4 board loaded with MP3_Project.",
    epilog="Program wrote by Martin AUCHER and Kevin PEREZ\nfor ENSEIRB-MATMECA Numerical conception courses.\nhttps://github.com/arkamor/PR209_MP3\n ", conflict_handler='resolve')

    group = parser.add_mutually_exclusive_group()
    group.add_argument("-v", "--verbosity", help="Increase output verbosity (max 2)", action="count")
    group.add_argument("-q", "--quiet", help="No output", action="store_true")

    parser.add_argument("-b", help="Change Baudrate,   default : 921600", type=int, default=921600)
    parser.add_argument("-p", help="Change seial Port, default : /dev/ttyUSB1", type=str, default="/dev/ttyUSB1")

    args = parser.parse_args()

    if args.verbosity:
        print("verbosity turned on : " + str(args.verbosity))

    return args