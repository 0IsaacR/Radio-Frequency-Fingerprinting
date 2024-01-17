%% Extracting Time Signals from IQ Data
%UAV1

%
%       This code assumes that the IQ Dataset was saved to your local
%       computer using IQ Dataset Creator.
%

%
%       The approach this code takes, is to compute all the signals for 1
%       UAV then save them to local storage. Then erase the data from
%       MATLAB  and compute another UAV's RF signals.
%


close all
clear all

load('UAV_IQ_Data.mat');

% sampling rate from SDR
fs = 10000000;      % sampling rate
Ts = 1/fs;      % sampling period

%
%   I find my first time base signal data point and use it to initialize my
%   array of signals.
%

Signal_mag = abs(IQdata(1).Signal);  % magnitude of complex number
N = length(Signal_mag) - 1;     % length of signal (97000) - 1
t = 0:Ts:Ts*N;      % time vector
w = 2*pi*IQdata(1).Fcenter;     % angular frequency
S = Signal_mag.*cos(w.*t + IQdata(1).Phase);    % IQ to RF signal with phase offset

%
%   loading function in order to anticipate when the code will finish
%   running,
%

L = 100/1820;       % uav1 data only since UAV1 has 1820 data points
disp('Loading UAV1');
for i = 2:1820                          % displays numbers from 0 to 100 as program runs
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L))
    end

    %
    % Computes the rest of the time based signals for UAV1 
    %

    Signal_mag = abs(IQdata(i).Signal);     % signal magnitude
    N = length(Signal_mag) - 1;         % signal length (97,000) - 1
    t = 0:Ts:Ts*N;          % time vector
    w = 2*pi*IQdata(i).Fcenter;     % angular frequency
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);     % IQ to RF signal with phase offset

    S = [S; temp_S];    % concatenates signals

end

%
%   After all UAV1 time based signals are computed, I transpose them
%   becuase the feature extraction function used later requires it.
%

S = transpose(S);
disp('Finished');

% variables are deleted

vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L'}; 
clear(vars{:}) 
clear vars

% saves and clears the data. Since the amount of data is large its best to
% work with it in batches.

disp('Saving Please Wait');
save uav1_waveform.mat S -v7.3
clear S
disp('Finished Saving');

%%
% UAV2

start = 1821;       % UAV2 data begins at 1821 and ends 3926 in IQdata dataset
stop = 3926;

%
%
% %%           The rest is the same as the code above
%
%

Signal_mag = abs(IQdata(start).Signal);
N = length(Signal_mag) - 1;
t = 0:Ts:Ts*N;
w = 2*pi*IQdata(start).Fcenter;
S = Signal_mag.*cos(w.*t + IQdata(start).Phase);

L = 100/(stop - start);       
disp('Loading UAV2');
for i = start + 1:stop
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L)-85)
    end
    Signal_mag = abs(IQdata(i).Signal);
    N = length(Signal_mag) - 1;
    t = 0:Ts:Ts*N;
    w = 2*pi*IQdata(i).Fcenter;
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);

    S = [S; temp_S];
    
end
S = transpose(S);
disp('Finished');
vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L'}; 
clear(vars{:}) 
clear vars
disp('Saving Please Wait');
clesave uav2_waveform.mat S -v7.3
clear S
disp('Finished Saving');
%%
% UAV3

start = 3927;   % initial value
stop = 5430;

Signal_mag = abs(IQdata(start).Signal);
N = length(Signal_mag) - 1;
t = 0:Ts:Ts*N;
w = 2*pi*IQdata(start).Fcenter;
S = Signal_mag.*cos(w.*t + IQdata(start).Phase);

L = 100/(stop - start);
disp('Loading UAV3');
for i = start + 1:stop
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L)-261)
    end
    Signal_mag = abs(IQdata(i).Signal);
    N = length(Signal_mag) - 1;
    t = 0:Ts:Ts*N;
    w = 2*pi*IQdata(i).Fcenter;
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);

    S = [S; temp_S];
    
end
S = transpose(S);
disp('Finished');
vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L'}; 
clear(vars{:})
clear vars
disp('Saving Please Wait');
save uav3_waveform.mat S -v7.3
clear S
disp('Finished Saving');

%%
% UAV4

start = 5431;   % initial value
stop = 6984;

Signal_mag = abs(IQdata(start).Signal);
N = length(Signal_mag) - 1;
t = 0:Ts:Ts*N;
w = 2*pi*IQdata(start).Fcenter;
S = Signal_mag.*cos(w.*t + IQdata(start).Phase);

L = 100/(stop - start);
disp('Loading UAV4');
for i = start + 1:stop
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L)-349)
    end
    Signal_mag = abs(IQdata(i).Signal);
    N = length(Signal_mag) - 1;
    t = 0:Ts:Ts*N;
    w = 2*pi*IQdata(i).Fcenter;
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);

    S = [S; temp_S];
    
end
S = transpose(S);
disp('Finished');
vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L'}; 
clear(vars{:}) 
clear vars
disp('Saving Please Wait');
save uav4_waveform.mat S -v7.3
clear S
disp('Finished Saving');

%%
% UAV5

start = 6985;   % initial start values in data struct
stop = 9255;

Signal_mag = abs(IQdata(start).Signal);
N = length(Signal_mag) - 1;
t = 0:Ts:Ts*N;
w = 2*pi*IQdata(start).Fcenter;
S = Signal_mag.*cos(w.*t + IQdata(start).Phase);

L = 100/(stop - start);
disp('Loading UAV5');
for i = start + 1:stop
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L)-307)
    end
    Signal_mag = abs(IQdata(i).Signal);
    N = length(Signal_mag) - 1;
    t = 0:Ts:Ts*N;
    w = 2*pi*IQdata(i).Fcenter;
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);

    S = [S; temp_S];
    
end
S = transpose(S);
disp('Finished');
vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L'}; 
clear(vars{:}) 
clear vars
disp('Saving Please Wait');
save uav5_waveform.mat S -v7.3
clear S
disp('Finished Saving');
%%
% UAV6

start = 9256;   % initial start values in data struct
stop = 11291;

Signal_mag = abs(IQdata(start).Signal);
N = length(Signal_mag) - 1;
t = 0:Ts:Ts*N;
w = 2*pi*IQdata(start).Fcenter;
S = Signal_mag.*cos(w.*t + IQdata(start).Phase);

L = 100/(stop - start);
disp('Loading UAV6');
for i = start + 1:stop
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L)-455)
    end
    Signal_mag = abs(IQdata(i).Signal);
    N = length(Signal_mag) - 1;
    t = 0:Ts:Ts*N;
    w = 2*pi*IQdata(i).Fcenter;
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);

    S = [S; temp_S];
    
end
S = transpose(S);
disp('Finished');
vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L'}; 
clear(vars{:}) 
clear vars
disp('Saving Please Wait');
save uav6_waveform.mat S -v7.3
clear S
disp('Finished Saving');

%%
% UAV7

start = 11292;   % initial start values in data struct
stop = 12678;

Signal_mag = abs(IQdata(start).Signal);
N = length(Signal_mag) - 1;
t = 0:Ts:Ts*N;
w = 2*pi*IQdata(start).Fcenter;
S = Signal_mag.*cos(w.*t + IQdata(start).Phase);

L = 100/(stop - start);
disp('Loading UAV7');
for i = start + 1:stop
    if mod(round(i),30) == 0
        fprintf('%d  \n',round(i*L)-814)
    end
    Signal_mag = abs(IQdata(i).Signal);
    N = length(Signal_mag) - 1;
    t = 0:Ts:Ts*N;
    w = 2*pi*IQdata(i).Fcenter;
    temp_S = Signal_mag.*cos(w.*t + IQdata(i).Phase);

    S = [S; temp_S];
    
end
S = transpose(S);
disp('Finished');
vars = {'ans', 'dis', 'N', 'Signal_mag', 'ts', 'w', 'fs', 'i', 't1', 't2', 't3','signal', 't', 'temp_S', 'bad_signal','L','Ts','start','stop'}; 
clear(vars{:}) 
clear vars
disp('Saving Please Wait');
save uav7_waveform.mat S -v7.3
clear S
disp('Finished Saving');


