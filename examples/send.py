import serial
import string

ser = serial.Serial('/dev/ttyUSB1', 921600, 8, 'N', 1, timeout=1)



""" fonctionne absolument bien """
f=open("selfie.uart","rb")
num=list(f.read())
print(num)
f.close()

ser.write(num)