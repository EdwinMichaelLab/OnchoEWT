function mfEP = writing_Three_EliminProb_thresholdValues(Str1,EliminProb,mfBpt)

if strcmp(Str1,'ABR')
%     data=mfBpt(mfBpt(:,2)<=5,2);
    data=mfBpt(mfBpt(:,2)>0,2);
else
%     data=mfBpt(mfBpt(:,1)<=10,1);
    data=mfBpt(mfBpt(:,1)>0,1);
end

CumulProb=zeros(length(unique(data)),2);
mf_atBpt=unique(data);
for i=length((unique(data))):-1:1
    CumulProb(i,1)=mf_atBpt(i);
    if i==length((unique(data)))
        CumulProb(i,2)=CumulProb(i,2)+1;
    else
        CumulProb(i,2)=CumulProb(i+1,2)+1;
    end
end
CumulProb(:,2)=CumulProb(:,2)/CumulProb(1,2);
mfEP=zeros(length(EliminProb),1);
for jj=1:length(EliminProb)
    id=find(CumulProb(:,2)<=EliminProb(jj));
    mfEP(jj)=CumulProb(id(1),1);
end

% plot(CumulProb(:,1),CumulProb(:,2),'-','LineWidth',3);
% hold('on');
% for jj=1:length(mfEP)
%     if jj==1
%         h1 = line([mfEP(jj),mfEP(jj)],[0, 1],'LineStyle','--');
%     elseif jj==2
%         h2 = line([mfEP(jj),mfEP(jj)],[0, 1],'LineStyle','-');
%     else
%         h3 = line([mfEP(jj),mfEP(jj)],[0, 1],'LineStyle','-.');
%     end
% end
% hold('off');
% 
% legend([h1(1),h2(1),h3(1)],{'50% EP','75% EP','95% EP'},'Location','northeast');
% set(gca,'XLim',[0 max(mf_atBpt)]);

end
