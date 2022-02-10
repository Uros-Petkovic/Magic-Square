
function [BestSled]=nadji_min(SledOgr,snop,rod,n)

BestSled=cell(1,snop);
j=0;
for k=1:snop          %Za napravljene sledbenike vrati snop najboljih resenja
    minimum=2*n+2;
    for i=1:snop*rod
         if (SledOgr{i}{2}<minimum)
             minimum=SledOgr{i}{2};
             j=i;
         end
    end
    BestSled{k}=SledOgr{j};
    SledOgr{j}{2}=2*n+3;
end
end