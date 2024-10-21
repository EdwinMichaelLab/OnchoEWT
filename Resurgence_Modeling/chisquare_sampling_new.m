function kId=chisquare_sampling_new(MfData,mfPrevIntv)


chiid=[];

for j=1:length(mfPrevIntv)
    p=(MfData(3)+2)./(MfData(2)+4); % proportion testing positive (adjusted wald method)
    %     delta=1.96*sqrt(((p.*(1-p))./(MfData(2)+4)));
    sigma=p.*(1-p).*(MfData(2));
    %     chivalue(j)=(((mfPrevIntv(j)/100))-p)^2/((delta));
    %     chivalue(j)=(((MfData(2).*mfPrevIntv(j))-MfData(3)).^2/(sigma))+(((MfData(2).*(1-mfPrevIntv(j)))-(MfData(2)-MfData(3))).^2/(sigma)); % two "categories", df = k-1 = 1
    chivalue(j)=(((MfData(2).*mfPrevIntv(j))-MfData(3)).^2/(sigma)); % one "category", df=1
end
id=find(chivalue<3.84);
if ~isempty(id)
    chiid=[chiid;id];
end

kId=chiid;
end