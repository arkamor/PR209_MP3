close all;
clear all;
clc;

l = 74000;

fileID = fopen('kaa.uart');
a = fread(fileID, l, 'int16');

fileID = fopen('out.uart');
b = fread(fileID, l, 'int16');


figure

subplot 211
plot(a)
xlim([0 l])
ylim([-1024 1023])

subplot 212
plot(b)
xlim([0 l])
ylim([-1024 1023])


%sound(a/1024,44100,16)
%sound(b/1024,44100,16)

c = a-b;

a(8000)
for i = 7990:8010
   disp(b(i))
end