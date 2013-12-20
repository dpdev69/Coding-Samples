L=16;
t = 0:L-1;
t_shifted = 0:L-1;
s = cos((t*10.5*2*pi/L));
N = 160;
s_pad = [s zeros(1,N-length(s))];
figure, 
subplot(2,2,1),plot(t,s,'o--'), title('Original Signal')
axis([0 L-1 -1.1 1.1])

subplot(2,2,2),stem(t_shifted,abs((fft(s))))
axis([0 L-1 0 10])
title('DFT of Original Signal')

subplot(2,2,3), plot(0:N-1, s_pad, 'o--'), title('Zero-Padded Signal')
axis([0 N-1 -1.1 1.1])

subplot(2,2,4),stem(0:N-1,abs((fft(s_pad))))
axis([0 N-1 0 10])
title('DFT of Zero-Padded Signal')
