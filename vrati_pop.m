
function Pop2=vrati_pop(Pop,Pop1,n,snop)
% Od date populacije vraca tacno polovinu onih najboljih proveravajuci
%boj prekrsenig ogranicenja
Pop2=cell(1,snop/2);
PopV=cell(1,snop);
for i=1:snop/2
    PopV{i}{1}=Pop{i};
    PopV{i}{2}=provera_ogranicenja(Pop{i});
end

for i=(snop/2+1):snop
    PopV{i}{1}=Pop1{i-snop/2};
    PopV{i}{2}=provera_ogranicenja(Pop1{i-snop/2});
end

for l=1:snop/2
    minimum=2*n+2;
    for k=1:snop
        if (PopV{k}{2}<minimum)
            minimum=PopV{k}{2};
            c=k;
        end
    end
    if (minimum==2*n+2)    %Uzimamo minimalno resenje i nakon biranja ga 
        c=1;     %postavljamo na maks kako se ne bi ponovo izabralo
    end
    Pop2{l}=PopV{c}{1};
    PopV{c}{2}=2*n+3;
end

end