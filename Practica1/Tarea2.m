close all
clear 
clc

disp("Leer el audio");
[y,Fs] = audioread('Jingle Bells.wav');

Dur=48;
inicio=1;

t = 0:1/Fs:Dur;
cutY = y(inicio*Fs:Dur*Fs + inicio*Fs,1); %inicia desde el segundo 3
plot(t,cutY)

s=spectrogram(cutY);
spectrogram(cutY,"yaxis")