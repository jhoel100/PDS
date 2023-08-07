close all
clear 
clc

disp("Leer el audio");
[y,Fs] = audioread('Jingle Bells0.wav');
figure(1)
plot(y(1:1000,1))


disp("Recorte Inicial");
Dur = 5;   %duracion del recorte
t = 0:1/Fs:Dur;
inicio=5;

cutY = y(inicio*Fs:Dur*Fs + inicio*Fs,1); %inicia desde el segundo 3
spectrogram(cutY,"yaxis");
figure(2)
plot(t,cutY)

disp("Calculo de Coeficientes");
for i = 2:200
    %- Propuesta de periodo
    f0 = 1/0.02;   %0.02 es el periodo asumido, aumenta o baja la resolucion

    %- Recortes
    yT1 = cutY(i*(Fs/f0)/2:i*(Fs/f0)/2 + Fs/f0)';
    %t0 = t(1:Fs/f0+1);

    %- Ventana de Hann
    H = sigwin.hann(length(yT1));
    wind = generate(H);
    WyT0 = yT1.*wind';

    %- Zero Padding
    yT3 = [WyT0 zeros(1,3*length(yT1)-3)];

    f0 = 1/0.08;   %la nueva armonico
    t1 = t(1:Fs/f0+1);
    figure(3)
    plot(t1,yT3)

    maxC = 100;   %los primeros 300 coeficientes 300 armonicos
    for k = 1:maxC
        auxA = sin(2*pi*k*f0*t1);
        auxB = cos(2*pi*k*f0*t1);
        Ak(k) = trapz(t1,yT3.*auxA);
        Bk(k) = trapz(t1,yT3.*auxB);
        C(k) = 2*f0*sqrt(Ak(k)^2+Bk(k)^2);
    end
    figure(4)
    FF = f0:f0:maxC*f0;
    plot(FF,C)
    
    [M,I]=max(C);
    armonico(i)=M;
    CoefA(i)=Ak(I);
    CoefB(i)=Bk(I);
end