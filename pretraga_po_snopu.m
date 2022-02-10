
function [Ppso,iter,pros,min]=pretraga_po_snopu(rod,snop,n)

pros=zeros(1,5000);
min=zeros(1,5000);
MatriceOgr=cell(1,snop);
minimum=2*n+2;
for i=1:snop   %Generisem pocetni snop
    MatriceOgr{i}{1}=generisanje_matrice(n);
    MatriceOgr{i}{2}=provera_ogranicenja(MatriceOgr{i}{1});
    if (MatriceOgr{i}{2}<minimum)
        minimum=MatriceOgr{i}{2};
    end
end
Ppso=2*n+2;
i=0;
iter=i;

if (minimum==0)  %Ako se slucajno u njemu nalazi resenje,prekini algoritam
    Ppso=0;
else
    SledOgr=cell(1,snop*rod);
    for i=1:5000     %Za svaki clan snopa pravim sledbenike i od njih ponovo biram snop najboljih
        for k=1:snop
            Cel=napravi_sledbenike(rod,MatriceOgr{k}{1},n);
            for z=(rod*(k-1)+1):(rod*k)
                o=z-rod*(k-1);
                SledOgr{z}=Cel{o};
            end
        end
    BestSled=nadji_min(SledOgr,snop,rod,n);
    MatriceOgr=BestSled;
    minimum=2*n+2;
    suma=0;
    for t=1:snop
        suma=suma+BestSled{t}{2};  %prosecan broj
        if (BestSled{t}{2}<minimum)
            minimum=BestSled{t}{2};  %minimum
        end
    end
    suma=suma/snop;
    min(i)=minimum;
    pros(i)=suma;   %Ako postoji resenje,zavrsavamo,ako ne,od najboljih snop resenja pravimo ponovo sledbenike
    if (minimum==0) %u sledecoj iteraciji
        Ppso=0;
        iter=i;
        break
    else
        Ppso=minimum;
        iter=i;
    end
    end
end    
end