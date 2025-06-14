clc;
clear;
%%
%Inicialización y convolución
[y1 fs1] = wavread('Violin, Mendelssohn Violin Concert.wav'); % Señal anecoica
y1=y1(1:48000).*0.05;
[y2 fs] = wavread('BRIR-SUM NORES-esw-p5.wav'); % Respuesta impulsiva medida
y2D = y2(1:220500 , 1);
y2I = y2(1:220500 , 2);
y3D=conv(y1,y2D);
y3I=conv(y1,y2I);
wavwrite(y3D, fs, 'señal de auralizacion BinD1.wav');
wavwrite(y3I, fs, 'señal de auralizacion BinI1.wav');
%%
% PSD de la señal CONVOLUCIONADA DERECHA
figure(1)
nfft1R = 2^nextpow2(length(y3D));
Pxx1R = abs(fft(y3D,nfft1R)).^2/length(y3D)/fs;
Hpsd1R = dspdata.psd(Pxx1R(1:length(Pxx1R)/2),'fs',fs);
plot(Hpsd1R)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA DERECHA')
ylim([-130 0]);
xlim([0.02 1]);
grid on
%%
% PSD de la señal CONVOLUCIONADA IZQUIERDA
figure(2)
nfft1L = 2^nextpow2(length(y3I));
Pxx1L = abs(fft(y3I,nfft1L)).^2/length(y3I)/fs;
Hpsd1L = dspdata.psd(Pxx1L(1:length(Pxx1L)/2),'fs',fs);
plot(Hpsd1L)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA IZQUIERDA')
ylim([-130 0]);
xlim([0.02 1]);
grid on
%%
% PSD de la señal ORIGINAL
figure(3)
nfft1 = 2^nextpow2(length(y1));
Pxx1 = abs(fft(y1,nfft1)).^2/length(y1)/fs;
Hpsd1 = dspdata.psd(Pxx1(1:length(Pxx1)/2),'fs',fs);
plot(Hpsd1)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('ORIGINAL')
ylim([-130 0]);
xlim([0.02 1]);
grid on
%%
% FFT de ambas señales ORIGINAL y DERECHA
figure(4)
L1=length(y1);
NFFT1 = 2^nextpow2(L1);
Y1 = fft(3*y1,NFFT1)/L1;
LIN1=linspace(0,1,NFFT1/2+1);
f1 = fs/2*LIN1;
L3R=length(y3D);
NFFT3R = 2^nextpow2(L3R);
Y3R = fft(0.2*y3D,NFFT3R)/L3R;
LIN3R=linspace(0,1,NFFT3R/2+1);
f3R = fs/2*LIN3R;
plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');
hold on
plot(f3R,2*abs(Y3R(1:NFFT3R/2+1)),'r');
hold off
axis([0 800 0 1.6E-3])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA DERECHA')
xlabel('Frequencia (Hz)')
ylabel('|Y(f)|')
grid on
%%
% FFT de ambas señales ORIGINAL e IZQUIERDA
figure(5)
L3L=length(y3I);
NFFT3L = 2^nextpow2(L3L);
Y3L = fft(0.2*y3I,NFFT3L)/L3L;
LIN3L=linspace(0,1,NFFT3L/2+1);
f3L = fs/2*LIN3L;
plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');
hold on
plot(f3L,2*abs(Y3L(1:NFFT3L/2+1)),'r');
hold off
axis([0 800 0 1.6E-3])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA IZQUIERDA')
xlabel('Frequencia (Hz)')
ylabel('|Y(f)|')
grid on