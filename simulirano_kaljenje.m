
function [SKo,iter,nizogr,niztemp,nizver]=simulirano_kaljenje(A,n)

ogr=provera_ogranicenja(A);
SKo=ogr;
iter=0;
p=1;
if (ogr==0)
    SKo=0;
    iter=0;
else
    for i=1:5000
        T=1-i/5000;   %Temperaturu smanjujemo u svakoj iteraciji
        Sledb=napravi_sledbenike(1,A,n);
        ogr=provera_ogranicenja(A);
        if (Sledb{1}{2}<=ogr)
            A=Sledb{1}{1};
            SKo=Sledb{1}{2};
        else
            ver=rand(1,1);  %Racunamo verovatnocu prihvatanja losijeg resenja
            delta=ogr-Sledb{1}{2};
            nizver(p)=exp(delta/T);
            p=p+1;
            if (ver < exp(delta/T)) %Poredimo je sa generisanom verovatnocom
                A=Sledb{1}{1};
                SKo=Sledb{1}{2};
            end
        end
        nizogr(i)=SKo;
        niztemp(i)=T;
        if (SKo==0)    %Ako je nula, izlazimo iz algoritma
            iter=i;
            break
        else
            iter=i;
        end
    end
            
end
end

