
function [Go,iter,niz]=gramziva_pretraga(rod,n)

niz=zeros(1,5000);
A=generisanje_matrice(n);
ogr=provera_ogranicenja(A);

if (ogr==0)
    Go=0;
    iter=0;
else
    for i=1:5000        %Za svaku matricu pravimo zadati broj sledbenika i od njega biramo najboljeg
        Sledb=napravi_sledbenike(rod,A,n); %po tome koji ima najmanji broj prekrsenih ogranicenja
        minimum=2*n+2;
        for k=1:rod
            if (Sledb{k}{2}<minimum)
                minimum=Sledb{k}{2};
                j=k;  %pamtim ovaj jer mi je to sledeci
            end
        end
        niz(i)=minimum;  %minimum usvakoj iteraciji
        if (minimum==0)
            Go=0;
            iter=i;  %Ako smo dosli do nula,prekidamo
            break
        elseif (minimum==2*n+2)  %ako su bas svi maksimalni,uzmi prvog
            j=1;
            A=Sledb{j}{1};
            Go=minimum;
            iter=i;
        else
            A=Sledb{j}{1};
            Go=minimum;
            iter=i;            
        end
    end
end













end