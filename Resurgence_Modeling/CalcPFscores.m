addpath('../IO/OUT/');
addpath('../CommonFunctions/');
addpath('../BaselineFitting');
load('../IO/IN/Baseline_IN.mat');

villageName = Sites;
p = zeros(4,1);
for i = 1:length(villageName)

    load(sprintf('ParamVectors%s_ABR1',char(villageName(i))));
    MfData0 = eval(sprintf('%sMf',char(villageName(i))));
    MidAge = [5 14.5 24.5 34.5 44.5 54.5 64.5];
    OverallMfPrev = MfData0(:,3)/MfData0(:,2);
    TotalMfSamples = MfData0(:,2);


    for icurve = 1:2 % loop over two types of age curves
        
        % calculate theoretical age profile data
        MfData = getMfAgeProfile_fromOnchoCurves(TotalMfSamples,icurve,OverallMfPrev,ageMthMax/12,demog,MidAge);
        v=genvarname(sprintf('MfData%s',int2str(icurve)));
        eval([v '= MfData;']);
    end
       
    aa = ConstructBinomialErrorBars(MfData1);
    Bounds1 = [aa(:,2)-aa(:,3) aa(:,2)+aa(:,4)]./100;
    aa = ConstructBinomialErrorBars(MfData2);
    Bounds2 = [aa(:,2)-aa(:,3) aa(:,2)+aa(:,4)]./100;
    ageGroup = MfData(:,4);
    
    
    mfPrev = 100*mfPrevArray;
    mfPrevGroup = mfPrevalence_ageStratified(ageGroup,mfPrev,demog);
    
    x1 = zeros(length(mfPrevGroup(1,:)),1);
    x2 = zeros(length(mfPrevGroup(1,:)),1);
    for k = 1:length(mfPrevGroup(1,:))
        for j = 1:length(ageGroup)
            if mfPrevGroup(j,k) > Bounds1(j,1) && mfPrevGroup(j,k) < Bounds1(j,2)
                x1(k) = x1(k)+1;
            end
            if mfPrevGroup(j,k) > Bounds2(j,1) && mfPrevGroup(j,k) < Bounds2(j,2)
                x2(k) = x2(k)+1;
            end
        end
    end
    
    p(i) = (length(find(x1>=(length(ageGroup)-2)))+length(find(x2>=(length(ageGroup)-2))))/(2*length(mfPrevGroup(1,:)));
end


function mfPrevGroup = mfPrevalence_ageStratified(ageGroup,mfPrev,demoX)

[m,n] = size(mfPrev);
% First find the prevalences for each age-group for the simulated data
mfPrevGroup = zeros(length(ageGroup),n);
da = 1;
ageMthMax = m-1;
for iSim = 1:n
    iGroup = 1;
    weightedMfPrev = 0;
    numPeopleInGroup = 0;
    iCheck =1;
    for iAge = 0:da:ageMthMax
        if iGroup <= length(ageGroup)
            if iAge/12.0 < ageGroup(iGroup)
                pia = pi_PeopleFun(iAge/12.0,demoX);
                weightedMfPrev = weightedMfPrev + pia*mfPrev(iCheck,iSim);
                numPeopleInGroup = numPeopleInGroup + pia;
            else
                mfPrevGroup(iGroup,iSim) = weightedMfPrev/(numPeopleInGroup*100);
                iGroup = iGroup + 1;
                weightedMfPrev = 0;
                numPeopleInGroup = 0;
            end
        end
        iCheck = iCheck + 1;
    end
    if iGroup == length(ageGroup)
        mfPrevGroup(iGroup,iSim) = weightedMfPrev/(numPeopleInGroup*100);
    end
    tol = 0.000001;
    for iGroup = 1:length(ageGroup)
        if abs(mfPrevGroup(iGroup,iSim)) < tol
            mfPrevGroup(iGroup,iSim) = 0.0000001;
        elseif abs(1-mfPrevGroup(iGroup,iSim)) < tol
            mfPrevGroup(iGroup,iSim) = 0.999999;
        end
    end
end
end
