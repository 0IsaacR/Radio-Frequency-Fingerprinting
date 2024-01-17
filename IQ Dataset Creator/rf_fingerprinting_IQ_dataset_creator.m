%% UAV_RF_Fingerprinting_exploring_features
%  Dataset comes from https://genesys-lab.org/hovering-uavs

%% Set up folder retrieve data
%

close all
clear all

%  Specify the folder where the files live.
myFolder = '/mypath/UAV_matlab_files';

% % Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         return;
    end
end

%% Create List of different file names
% Used to take data in an orderly fashion from storage

%
% sets up the file pattern naming system used by original dataset creators
% ex. uav1_6ft_burst1_1 ..... all the way to ....  uav7_15ft_burst2_1
%

UAV_num = ["uav1" "uav2" "uav3" "uav4" "uav5" "uav6" "uav7"];
distance_list = ["6ft" "9ft" "12ft" "15ft"];
burst_list = ["burst1" "burst2" "burst3" "burst4"];

% center frequency
uav1_fc = [2406500000 2406500000 2406500000 2406500000];
uav2_fc = [2406500000 2406500000 2406500000 2406500000];
uav3_fc = [2476500000 2476500000 2476500000 2476500000];
uav4_fc = [2476500000 2406500000 2406500000 2406500000];
uav5_fc = [2426500000 2426500000 2426500000 2436500000];
uav6_fc = [2406500000 2406500000 2406500000 2416500000];
uav7_fc = [2416500000 2416500000 2416500000 2416500000];
temp_fc = [uav1_fc; uav2_fc; uav3_fc; uav4_fc; uav5_fc; uav6_fc; uav7_fc];

z = 0;
for k = 1:length(UAV_num)
    for i = 1:length(distance_list)
        for m = 1:length(burst_list)
            z = z + 1;
            uav_list(z) = UAV_num(k) + "_" + distance_list(i) + "_" + burst_list(m);
            UAV(z) = k;
            distance(z) = i*3 +3;
            burst(z) = m;
            fc(z) = temp_fc(k, i);
        end
    end
end

%% Load and Structure IQ Data
% 

% Get a list of all files in the folder with the desired file name pattern.
z = 1;
Signal_too_short = 0;
L = 100/length(burst);

% displays loading screen to keep track of progress
disp('Loading');
for i = 1:length(uav_list)
    if mod(round(i),5) == 0
        fprintf('%d  \n',round(i*L))
    end
%
% adds an astrisk to the end of file name in order to capture all files
% with same starting files names
% Ex. 
%       uav1_6ft_burst1_1, uav1_6ft_burst1_2, uav1_6ft_burst1_3
%           all the way to .... uav1_6ft_burst1_143

    filePattern = fullfile(myFolder, uav_list(i)+"*");
    theFiles = dir(filePattern);
%
%  Takes the amount of files that have same starting name
%  Ex. uav1_6ft_burst1 has 143 recordings
%
%  Then assembles the entire file name in order to load data. 1 recording
%  at a time.
%
    for k = 1 : length(theFiles)
        baseFileName = theFiles(k).name;
        fullFileName = fullfile(theFiles(k).folder, baseFileName);

        temp  = load(fullFileName);
%
%       Once data is loaded, checks to see if signal recording is longer
%       than 97,000 data points. Any data point that is shorter is not used
%       and identified as Signal_too_short
%
%       If data is longer than 97,000, using the previous code block i
%       create my dataset 
%
        if length(temp.f_sig) > 97000
            IQdata(z,1).Name = UAV(i);
            IQdata(z,1).Distance = distance(i);
            IQdata(z,1).Burst = burst(i);
            IQdata(z,1).Fcenter= fc(i);
            IQdata(z,1).Phase = atan2(imag(temp.f_sig(1:97000)), real(temp.f_sig(1:97000)));
            IQdata(z,1).Signal = temp.f_sig(1:97000);

            clear temp;

            z = z + 1;
        else
            Signal_too_short = 1 + Signal_too_short;
        end

    end
end
clear temp;
disp('Finished');
disp('Number of Signals removed');
display(Signal_too_short);

% delete variables no longer needed
vars = {'baseFileName','burst','burst_list','distance','distance_list'};
clear(vars{:}) 
vars = {'filePattern','fullFileName','i','k','L','m','myFolder','rand_num'};
clear(vars{:}) 
vars = {'T','theFiles','UAV','uav_list','UAV_num','z', 'vars', 'ans', 'fc', 'temp_fc','uav1_fc'}; 
clear(vars{:}) 
vars = {'uav2_fc', 'uav3_fc', 'uav4_fc', 'uav5_fc', 'uav6_fc', 'uav7_fc', 'Signal_too_short'}; 
clear(vars{:}) 
clear vars

%% Save IQ dataset

%
%   Since this file is large, i recommend saving the IQ data in order to
%   avoid running this process again and just load it using the code below.
%

% save UAV_IQ_Data.mat IQdata -v7.3

% load('UAV_IQ_Data.mat');