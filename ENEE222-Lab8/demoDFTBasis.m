N = 256;
kn = fft(diag(ones(1,N)));


for i=1:N/2

    if abs(i-128)<96
        continue
    end
    
    subplot(2,1,1), plot(0:N-1, real(kn(i,:))), axis([0 N-1 -1.1 1.1]), ylabel('Real Basis')
    subplot(2,1,2), plot(0:N-1, imag(kn(i,:))), axis([0 N-1 -1.1 1.1]), ylabel('Complex Basis')
    pause(0.1)

end
