clc;
close all;
clear all;

[x,fs]=audioread("SunshineSquare.wav");
figure(1);
plot(x,"r");
title("Señal Original");
%sound(x.*4,fs);

%Whitebg('w');

Fr=fft(x);

figure(2);
plot(abs(Fr),'g');
title('Magnitud de la Señal');

figure(3);
plot(angle(Fr),'b');
title('Fase de la señal');

n1=size(x,1);
vecFreq=(0:n1-1)*(fs/n1);
power=abs(Fr).^2;

figure(4);
plot(vecFreq,power,"k");
xlabel("Frecuencias");
ylabel("Magnitud");

%potencia y frecuencia de una señal
xshif=fftshift(Fr);
vecFreqshift=(-n1/2:n1/2-1)*(fs/n1);

figure(5);
plot(vecFreqshift,abs(xshif).^2,"c");
title("Señal a filtrar");
xlabel("Frecuencias (Hz)");
ylabel("Magnitud de la señal");

fc=650;
[b,a]=butter(10,fc/(fs/2),"low");

figure(6);
freqz(b,a);

r=filter(b,a,x);
figure(7);

X1=fft(r);
power1=abs(X1).^2;
plot(vecFreq,power1,"m");
title("Señal filtrada");
xlabel("Frecuencias (Hz)");
ylabel("Magnitud de la señal");
%sound(r.*3,fs);
audiowrite("SunshineSquareFiltrado.wav",r,fs);

fs=200;
t=0:1/fs:1;
l=sin(2*pi*10*t)+randn(size(t))/10;
q=sin(2*pi*20*t)+randn(size(t))/10;

y=modulate(l,70,fs,'qam',q);

pwelch([l;q;y]', hamming(100),80,1024,fs,'centered');
legend('señal en fase','señal en cuadratura',"señal modulada sin ruido");
title("Filtrado QAM");
xlabel("Frecuencias (Hz)");
ylabel("Potencia (Db)");

