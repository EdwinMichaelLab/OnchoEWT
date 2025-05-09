function [PalaurePacunaciMf, MasaloaMf, OlimbuniArogaMf, NyimanjiMf, ...
    PalaurePacunaciMDAFreq, MasaloaMDAFreq, OlimbuniArogaMDAFreq, NyimanjiMDAFreq, ...
    PalaurePacunaciSwitchYr, MasaloaSwitchYr, OlimbuniArogaSwitchYr, NyimanjiSwitchYr, ...
    PalaurePacunaciMDACov, MasaloaMDACov, OlimbuniArogaMDACov, NyimanjiMDACov, ...
    PalaurePacunaciNumYears, MasaloaNumYears, OlimbuniArogaNumYears, NyimanjiNumYears, ...
    PalaurePacunaciVC, MasaloaVC, OlimbuniArogaVC, NyimanjiVC,...
     PalaurePacunaciEWTraps_t, MasaloaEWTraps_t, OlimbuniArogaEWTraps_t, NyimanjiEWTraps_t] = Intv_data

%% Post-intervention Mf Data
% enter overall community prevalence in a single line
% 1st column = time of survey; 2nd: Total number of samples; 3rd: Mf +ves;

PalaurePacunaciMf = NaN;
OlimbuniArogaMf = NaN;
NyimanjiMf = NaN;
MasaloaMf = NaN;

%% MDA Frequency
% in months
% if more than one treatment regimen, given frequency for each regimen
% (i.e. [12,6] for annual followed by biannial). For annual treatment the
% frequency is set eaul to 12 while for biannual it is set eual to 6

PalaurePacunaciMDAFreq = 6;
OlimbuniArogaMDAFreq = 6;
NyimanjiMDAFreq = 6;
MasaloaMDAFreq = 6;

PalaurePacunaciSwitchYr = NaN;
OlimbuniArogaSwitchYr = NaN;
NyimanjiSwitchYr = NaN;
MasaloaSwitchYr = NaN;

%% Annual MDA Coverage
% enter as proportion (i.e. 0.8)

PalaurePacunaciMDACov = ones(50,1)*0.8;
OlimbuniArogaMDACov = ones(50,1)*0.8;
NyimanjiMDACov = ones(50,1)*0.8;
MasaloaMDACov = ones(50,1)*0.8;

%% Total number of years of treatment

PalaurePacunaciNumYears = 50;
OlimbuniArogaNumYears = 50;
NyimanjiNumYears = 50;
MasaloaNumYears = 50;

%% Vector control - Trap
% 1: 0 for no VC, 1 for VC

PalaurePacunaciVC = 1;
OlimbuniArogaVC = 1;
NyimanjiVC = 1;
MasaloaVC = 1;

PalaurePacunaciEWTraps_t = [1:1:50*12];
OlimbuniArogaEWTraps_t = [1:1:50*12];
NyimanjiEWTraps_t = [1:1:50*12];
MasaloaEWTraps_t = [1:1:50*12];

end
