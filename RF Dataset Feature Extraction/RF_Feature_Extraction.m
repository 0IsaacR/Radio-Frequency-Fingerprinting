%% Extracting Features



%
%       This code assumes that the RF waveforms are saved to your local
%       computer using IQ to RF Dataset folder.
%



% Method 1 
% 13 Key Features
% Define Signal Features Details



fs = 10000000;      % sampling rate

FrameS = 97000;     % frame size

%
%   Initialize time based features to be extracted 
%
Time_Features = signalTimeFeatureExtractor(FrameSize=FrameS, ...
                                                                        SampleRate=fs, ...
                                                                        Mean=true, ...
                                                                        PeakValue=true, ...
                                                                        StandardDeviation=true, ...
                                                                        ShapeFactor=true, ...
                                                                        SNR=true, ...
                                                                        CrestFactor=true, ...
                                                                        ClearanceFactor=true, ...
                                                                        ImpulseFactor=true);
%
%   Initialize frequency based features to be extracted 
%
Frequency_Features = signalFrequencyFeatureExtractor(FrameSize = FrameS, ...
                                                                                            SampleRate=fs, ...
                                                                                            MeanFrequency=true, ...
                                                                                            MedianFrequency=true, ...
                                                                                            BandPower=true, ...
                                                                                            OccupiedBandwidth=true, ...
                                                                                            PowerBandwidth=true);



%%
% 13 Signal Features Extraction
%
load('uav1_waveform.mat');  % load RF UAV1 waveform
% extract features
    for i = 1:length(S(1,:))
        Temp_Time_Domain_Features(i,:) = extract(Time_Features,S(:,i));
        Temp_Frequency_Domain_Features(i,:) = extract(Frequency_Features, S(:,i));
        Temp_UAV_name(i,:)  = 1;
    end

%
%   initialize dataset of features using UAV1 data
%
Time_Domain_Features = Temp_Time_Domain_Features;
Frequency_Domain_Features = Temp_Frequency_Domain_Features;
Name = Temp_UAV_name;

% clear variables
clear S Temp_Time_Domain_Features Temp_Frequency_Domain_Features Temp_UAV_name
display(('UAV 1 is done processing'))
disp('Please wait')

% Set up feature extraction for the rest of the UAV's
for k = 2:7

    file_name = ('uav')+string(k)+('_waveform.mat');    %   loads UAV2 - UAV7 
    load(file_name);

    %   extracts features
    for i = 1:length(S(1,:))
        Temp_Time_Domain_Features(i,:) = extract(Time_Features,S(:,i));
        Temp_Frequency_Domain_Features(i,:) = extract(Frequency_Features, S(:,i));
        Temp_UAV_name(i,:)  = k;
    end

% Concatenates data
Time_Domain_Features = [Time_Domain_Features;  Temp_Time_Domain_Features];
Frequency_Domain_Features = [Frequency_Domain_Features;  Temp_Frequency_Domain_Features];
Name = [Name; Temp_UAV_name];

% Clear variables
clear S Temp_Time_Domain_Features Temp_Frequency_Domain_Features Temp_UAV_name
display(('UAV ')+string(k)+(' is done processing'))
end

% Assemble Dataset
Dataset_13_keyfeatures = [Name Time_Domain_Features Frequency_Domain_Features];
clear Name Time_Domain_Features Frequency_Domain_Features Time_Features Frequency_Features
clear file_name FrameS fs i k
disp('Finished')






%% Method 2 Linear Frequency Cepstral Coefficients
%

fs = 10000000;  % sampling rate

%
% Initialize feature extractor
%

aFE = audioFeatureExtractor(SampleRate=fs, ...      % linear filter banks
                                               SpectralDescriptorInput="linearSpectrum", ...
                                               mfcc=true); % Mel frequency cepstum coefficients

Coeffs = 10;        % 10 coeffs per signal 
setExtractorParameters(aFE,"mfcc", NumCoeffs = Coeffs )

%% Extract 10 coefficients per signal

load('uav1_waveform.mat');  % load UAV1 RF signals

% extract coefficients
for i = 1:length(S(1,:))        % first features extracted to initialize array of coeffs
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);

%
%       Adds and Subtracts coefficients in alternating order to
%       consolidate into 1 coefficient
%

    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav1_coef(:,i) = temp_coef;     % saves UAV1 coefficients
end
disp('UAV1 is done processing');
clear S        %       clear variable


load('uav2_waveform.mat');  % load UAV2 RF signals
% extract coefficients
for i = 1:length(S(1,:))     % first features extracted to initialize array of coeffs
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);
%
%       Adds and Subtracts coefficients in alternating order to
%       consolidate into 1 coefficient
%
    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav2_coef(:,i) = temp_coef;     % saves UAV2 coefficients
end
disp('UAV2 is done processing');
clear S        % clear variable

%
%
% The rest of the code follows the above comments
%
%

load('uav3_waveform.mat');
for i = 1:length(S(1,:))
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);

    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav3_coef(:,i) = temp_coef;
end
disp('UAV3 is done processing');
clear S


load('uav4_waveform.mat');
for i = 1:length(S(1,:))
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);

    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav4_coef(:,i) = temp_coef;
end
disp('UAV4 is done processing');
clear S


load('uav5_waveform.mat');
for i = 1:length(S(1,:))
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);

    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav5_coef(:,i) = temp_coef;
end
disp('UAV5 is done processing');
clear S


load('uav6_waveform.mat');
for i = 1:length(S(1,:))
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);

    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav6_coef(:,i) = temp_coef;
end
disp('UAV6 is done processing');
clear S


load('uav7_waveform.mat');
for i = 1:length(S(1,:))
    coefs =  extract(aFE, S(:,i));
    temp_coef = coefs(:,1);

    for k = 2:Coeffs 
        temp_coef = temp_coef - coefs(:,k)*(-1)^(k) ;
    end
    uav7_coef(:,i) = temp_coef;
end
disp('UAV7 is done processing');
clear aFE Coeffs coefs i k S temp_coef

%%
% add UAV naming labels

L = ones(1,length(uav1_coef(1,:)));     % creates a integer 1 vector
uav1_coef = [ L; uav1_coef ];       % adds a 1 to the beginning of the dataset 

L = ones(1,length(uav2_coef(1,:)));      %  creates a integer 1 vector
uav2_coef = [ 2.*L; uav2_coef ];         % adds a 2 to the beginning of the dataset 

L = ones(1,length(uav3_coef(1,:)));      %creates a integer 1 vector
uav3_coef = [3.* L; uav3_coef ];        % adds a 3 to the beginning of the dataset 

L = ones(1,length(uav4_coef(1,:)));     %creates a integer 1 vector
uav4_coef = [ 4.*L; uav4_coef ];        % adds a 4 to the beginning of the dataset 

L = ones(1,length(uav5_coef(1,:)));     %creates a integer 1 vector
uav5_coef = [ 5.*L; uav5_coef ];        % adds a 5 to the beginning of the dataset 

L = ones(1,length(uav6_coef(1,:)));     %creates a integer 1 vector
uav6_coef = [6.* L; uav6_coef ];        % adds a 6 to the beginning of the dataset 

L = ones(1,length(uav7_coef(1,:)));     %creates a integer 1 vector
uav7_coef = [ 7.*L; uav7_coef ];        % adds a 7 to the beginning of the dataset 

% Combine into dataset

LFCC_dataset = [uav1_coef uav2_coef  uav3_coef  uav4_coef uav5_coef  uav6_coef uav7_coef ];
clear fs L uav1_coef uav2_coef  uav3_coef  uav4_coef uav5_coef  uav6_coef uav7_coef