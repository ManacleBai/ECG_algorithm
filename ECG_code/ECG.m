clear all
close all
load('ECGdata.mat')
%% preprocessing
L = length(val);
fs= L/10;
T = 1/fs;
t = (0:L-1)*T;
NFFT = 2^nextpow2(L);%FFT use
f = fs/2*linspace(0,1,NFFT/2);
filterOrder=5;
stopBand=[58,63]; %58-63 hz 帶距
[bb, aa]=butter(filterOrder, stopBand/(fs/2), 'stop');
val1=filtfilt(bb,aa,val(1,:)); %濾完的資料
%val2=filtfilt(bb,aa,val(2,:));
Y=fft(val1,NFFT);
%% ECG data
subplot(2,2,1)
plot(t,val1);
title('ECG data') 
%% 1st-diff
subplot(2,2,2);
dval1=diff(val1);
plot(t(2:end),dval1);
title('1st-diff ECG data') 
%% lower frequence[abs(diff)]
subplot(2,2,3);
absdval1=abs(dval1);
%plot(t(2:end),absdval1);
[b, a]=butter(filterOrder,5/(fs/2),'low'); %% remove high frequence
Lowpass=filtfilt(b,a,absdval1);
plot(t(2:end),abs(Lowpass));
title('lower frequence[abs(diff)] data') 
%% Dynamic threshold
ampty = zeros(1,L-1);
ampty(:)=0.7*max(Lowpass);
[THR,SORH,KEEPAPP,CRIT] = ddencmp('cmp','wp',val1);
for i=1:(L)
    if(val1(i)<THR*100)
        val1(i)=0;
    end
end
Rsign=find(diff(sign(diff(val1)))<0)+1;
subplot(2,2,4)
z=val(1,:);
%plot(t,val,t(Rsign),val1(Rsign),'r*')
rawdata = val(1,:);
plot(t,rawdata,t(Rsign),rawdata(Rsign),'r*')
title('Sign R wave') 
%% ECG parameter
RR_interval=(max(t(Rsign))-min(t(Rsign)))/16  