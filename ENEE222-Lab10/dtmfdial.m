function x = dtmfdial(keys,Fs,T,Tpause)
% DTMFDIAL DTMF dialer
% DTMF(KEYS,FS,T,TPAUSE), where KEYS is a string array consisting of
% characters 1,2,3,4,5,6,7,8,9,*,0 and #, produces samples of a DTMF
% (touch-tone) dial signal for a sampling rate of Fs samples/sec. T is the
% duration of each key and Tpause is the pause between keys, both in
% seconds. The analog sound is also played back.

keypad = ['123';'456';'789';'*0#'] ;

Frow = [622 715 823 946];

Fcol = [1183 1360 1565];

t = (0:fix(T*Fs)).'/Fs  ;

rowtones = cos(2*pi*t*Frow) ;

coltones = cos(2*pi*t*Fcol) ;

zp = zeros(fix(Tpause*Fs/2),1) ;

x = [];

for r = 1:length(keys(:))
    [i j] = find(keypad==keys(r)) ;
    x = [x ; zp ; rowtones(:,i)+coltones(:,j) ; zp] ;
end

soundsc(x,Fs)
