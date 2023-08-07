Fs1 = 44100; 
Fr = Fs1; 
Fs = 0.5*Fs1; 

T = 1/Fs; 
N = 0.2*Fs1 
L = 1; 
n = @(L) 1:L*N; 

note = @(m, L, fN) sin(2*pi*oct(m)*fN*T*n(L));

fA = 440.00; 
fGS = fA*2^(-1/12);
fG = fGS*2^(-1/12);
fFS = fG*2^(-1/12);
fF = fFS*2^(-1/12);
fE = fF*2^(-1/12);
fDS = fE*2^(-1/12);
fD = fDS*2^(-1/12);
fCS = fD*2^(-1/12);
fC = fCS*2^(-1/12);
fAS = fA*2^(1/12);
fB = fAS*2^(1/12);
m = 0;
namp = 1; 
hamp = 0.8; 

C = @(m, L) namp*note(m, L, fC) + hamp*note(m, L, 0.5*fC) + hamp*note(m, L, 2*fC);
CS = @(m, L) namp*note(m, L, fCS) + hamp*note(m, L, 0.5*fCS) + hamp*note(m, L, 2*fCS);
D = @(m, L) namp*note(m, L, fD) + hamp*note(m, L, 0.5*fD) + hamp*note(m, L, 2*fD);
DS = @(m, L) namp*note(m, L, fDS) + hamp*note(m, L, 0.5*fDS) + hamp*note(m, L, 2*fDS);
E = @(m, L) namp*note(m, L, fE) + hamp*note(m, L, 0.5*fE) + hamp*note(m, L, 2*fE);
F = @(m, L) namp*note(m, L, fF) + hamp*note(m, L, 0.5*fF) + hamp*note(m, L, 2*fF);
FS = @(m, L) namp*note(m, L, fFS) + hamp*note(m, L, 0.5*fFS) + hamp*note(m, L, 2*fFS);
G = @(m, L) namp*note(m, L, fG) + hamp*note(m, L, 0.5*fG) + hamp*note(m, L, 2*fG);
GS = @(m, L) namp*note(m, L, fGS) + hamp*note(m, L, 0.5*fGS) + hamp*note(m, L, 2*fGS);
A = @(m, L) namp*note(m, L, fA) + hamp*note(m, L, 0.5*fA)+ hamp*note(m, L, 2*fA);
AS = @(m, L) namp*note(m, L, fAS) + hamp*note(m, L, 0.5*fAS) + hamp*note(m, L, 2*fAS);
B = @(m, L) namp*note(m, L, fB) + hamp*note(m, L, 0.5*fB) + hamp*note(m, L, 2*fB);

er = zeros(1, round(.125*N));
qr = zeros(1, round(.25*N)); 
hr = zeros(1, round(.5*N)); 
tr = zeros(1, round(.75*N)); 
wr = zeros(1, N); 

jbseq1 = [A(0,1) qr A(0,1) qr A(0,2) qr];
jbseq2 = [A(0,1) qr C(1,1) qr F(0,1) qr G(0,1) qr A(0,4) qr];
jbseq3 = [AS(0,1) qr AS(0,1) qr AS(0,1) qr AS(0,0.5) qr AS(0,1) qr A(0,1) qr A(0,1) qr A(0,0.5) er A(0,0.5) qr A(0,1) qr G(0,1) qr G(0,1) qr A(0,1) qr G(0,2) qr C(1,2) qr];
jbseq4 = [AS(0,1) qr AS(0,1) qr AS(0,1) qr AS(0,1) qr AS(0,1) qr A(0,1) qr A(0,1) qr A(0,0.5) er A(0,0.5) qr C(1,1) qr C(1,1) qr AS(0,1) qr G(0,1) qr F(0,4)];
jbseq5 = [C(0,1) qr A(0,1) qr G(0,1) qr F(0,1) qr C(0,3) qr C(0,0.5) er C(0,0.5) qr C(0,1) qr A(0,1) qr G(0,1) qr F(0,1) qr D(0,4) qr];
jbseq6 = [D(0,1) qr AS(0,1) qr A(0,1) qr G(0,1) qr E(0,4) qr C(1,1) qr C(1,1) qr AS(0,1) qr G(0,1) qr A(0,4) qr];
jbseq7 = [C(0,1) qr A(0,1) qr G(0,1) qr F(0,1) qr C(0,4) qr C(0,1) qr A(0,1) qr G(0,1) qr F(0,1) qr D(0,4) qr];
jbseq8 = [D(0,1) qr AS(0,1) qr A(0,1) qr G(0,1) qr C(1,1) qr C(1,1) qr C(1,1) qr C(1,0.5) er C(1,0.5) qr D(1,1) qr C(1,1) qr AS(0,1) qr G(0,1) qr F(0,1) wr C(1,2) qr];
jbseq9 = [AS(0,1) qr AS(0,1) qr AS(0,1) qr AS(0,1) qr AS(0,1) qr A(0,1) qr A(0,1) qr A(0,0.5) er A(0,0.5) qr C(1,1) qr C(1,1) qr AS(0,1) qr G(0,1) qr F(0,4) qr ];

jbells = [jbseq1 jbseq1 jbseq2 jbseq3 jbseq1 jbseq1 jbseq2 jbseq4 jbseq5 jbseq6 jbseq7 jbseq8 jbseq1 jbseq1 jbseq2 jbseq3 jbseq1 jbseq1 jbseq2 jbseq3 jbseq9];

s=spectrogram(0.25*jbells);
spectrogram(0.25*jbells,"yaxis")

audiowrite("salida.wav",0.25*jbells,Fr);
