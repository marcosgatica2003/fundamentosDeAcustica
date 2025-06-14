%%  falta iniciar las señales
% PSD de la señal CONVOLUCIONADA
figure(1)
nfft1r = 2^nextpow2(length(hr));
Pxx1r = abs(fft(hr,nfft1r)).^2/length(hr)/fs;
Hpsd1r = dspdata.psd(Pxx1r(1:length(Pxx1r)/2),'fs',fs);
plot(Hpsd1r)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA canal derecho')
ylim([-200 0]);
xlim([0.02 22.25])
grid on
figure(2)
nfft1l = 2^nextpow2(length(hl));
Pxx1l = abs(fft(hl,nfft1l)).^2/length(hl)/fs;
Hpsd1l = dspdata.psd(Pxx1l(1:length(Pxx1l)/2),'fs',fs);
plot(Hpsd1l)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA canal izquierdo')
ylim([-200 0]);
xlim([0.02 22.25])
grid on
%%
% PSD de la señal ORIGINAL
figure(3)
nfft2 = 2^nextpow2(length(x));
Pxx2 = abs(fft(x,nfft2)).^2/length(x)/fs;
Hpsd2 = dspdata.psd(Pxx2(1:length(Pxx2)/2),'fs',fs);
plot(Hpsd2)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('ORIGINAL')
ylim([-200 0]);
xlim([0.02 22.25])
grid on
%%
% FFT de ambas señales
figure(4)
L1=length(x); %
NFFT1 = 2^nextpow2(L1); % fft señal original
Y1 = fft(x,NFFT1)/L1; % (anecoica)
f1 = fs/2*linspace(0,1,NFFT1/2+1); %

Lr=length(hr); %
NFFT3r = 2^nextpow2(Lr); % fft señal convolucionada
YR = fft(0.1.*hr,NFFT3r)/Lr; % (auralizada)
f3r = fs/2*linspace(0,1,NFFT3r/2+1); %

Ll=length(hl); %
NFFT3l = 2^nextpow2(Ll); % fft señal convolucionada
YL = fft(0.1.*hl,NFFT3l)/Ll; % (auralizada)
f3l = fs/2*linspace(0,1,NFFT3l/2+1); %

plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');%
hold on %
plot(f3r,2*abs(YR(1:NFFT3r/2+1)),'r');% gráficos
hold off %
axis([0 30000 0 0.2e-3]) %
legend('Original','Convolucionada') %
title('Espectro de ORIGINAL vs CONVOLUCIONADA canal derecho')
xlabel('Frequencia (Hz)') %
ylabel('|Y(f)|') %
grid on %

figure(5)
plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');%
hold on %
plot(f3l,2*abs(YL(1:NFFT3l/2+1)),'r');% gráficos
hold off %
axis([0 30000 0 0.2e-3]) %
legend('Original','Convolucionada') %
title('Espectro de ORIGINAL vs CONVOLUCIONADA canal izquierdo')
xlabel('Frequencia (Hz)') %
ylabel('|Y(f)|') %
grid on %