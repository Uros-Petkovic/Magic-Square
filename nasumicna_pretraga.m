
function [bestA,minogr,iter]=nasumicna_pretraga(A,n)

minogr=provera_ogranicenja(A);
bestA=A;
iter=0;
if (minogr==0)
    minogr=0;
    iter=0;
    bestA=A;
else             %U svakoj iteraciji generisemo novu random matricu i pitamo je li bolja od trenutnog
    for i=1:5000 %resenja,ako jeste, ona je nase novo najbolje resenje
        A1=generisanje_matrice(n);
    
        if (provera_ogranicenja(A1)<minogr)
            minogr=provera_ogranicenja(A1);
            bestA=A1;
        end 
        if (minogr==0)    %Nema prekrsenih
            iter=i;
            break
        end
    end
    iter=i;
end
end