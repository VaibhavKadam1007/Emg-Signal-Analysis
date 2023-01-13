close all
clear all
warning('off','all');
%% Load data
load('GRP 1 - EMG.mat');%Load file in. 
load('signalEMG');%Load file in. 
data=shoulder_OP';
%% Locate data on channel 4 
 data4.raw=[];
for i=1:1:length(datastart) % select data from channel 4 which contain the data. 
        data4.raw=[data4.raw,(data(datastart(4,i):dataend(4,i)))];
        data4.divided{i}=butter_filter((data(datastart(4,i):dataend(4,i)))');
        laengde(1,i)=length(data4.raw); % length of each data sections, used for plotting the comments
end
data4.raw=data4.raw';
%% See the data in frequency domain
fs=samplerate(1,1);                           %samplerate is a vector(look to the right) = 1000
data4.rawfft=fft(data4.raw);
n = length(data4.raw);                        % number of samples
f = (0:n-1)*(fs/n);                           % frequency range
data4.rawpower = abs(data4.rawfft).^2/n;      % power of the DFT
figure('Name','Data prior and after filtering data');
subplot(2,1,1); plot(f,data4.raw); hold on
subplot(2,1,2); plot(f,data4.rawpower); xlim([0 fs/2]);hold on

% Filtering of data with Butterlterfft=fft(data4.filter);
data4.filterpower = abs(data4.filte-worth filter
  data4.filter=butter_filter(data4.raw);
  
% See the data in frequency domain
data4.firfft).^2/n;     

subplot(2,1,1); plot(f,data4.filter); 
xlabel('seconds'); 
ylabel('V');MVE_calculation(data4.maxfilter);
plot_comments(com, comtext, laengde, 0.01); hold off
subplot(2,1,2); plot(f,data4.filterpower);
xlabel('Frequency'); 
ylabel('Power');
legend('Raw signal', 'filtered data'); hold off 
   
%% Calculate Maximal Voluntary Electrical
data4.maxfilter=butter_filter(data4.divided{1,6});
[MVE, rmsmax] = );

%% Calculated Normalized muscle activity
[Normalized, rms]= amplitude(data4, MVE); % normalize the contraction according to max muscle contraction  
figure('Name','Normalized EMG signal');
plot(f,data4.filter); xlabel('second'); ylabel('V');hold on;
yyaxis right
fn=(0:length(Normalized.total)-1)*(fs/length(Normalized.total)); 
plot(fn,Normalized.total); xlabel('seconds'); ylabel('% of Max contraction');
plot_comments(com, comtext, laengde, 140);
%% Fatigue estimation, find the mean amplitude and frequency 
figure('Name','Fatique development in fatiqued test');
[mean_freq, mean_amplitude]=fatigue(data4.divided, rms.divided, comtext);
