
function [Gao,iter,pros,min]=genetski_algoritam(n,snop)

Pop=cell(1,snop/2);
Pop1=cell(1,snop/2);
minimum=2*n+2;
Gao=minimum;
iter=0;

for v=1:snop/2   %Pravimo polovinu populacije tako sto izaberemo one najbolje od polovinex2
    Pop{v}=generisanje_matrice(n);   %tj. radimo selekciju
    if (provera_ogranicenja(Pop{v})<minimum)
        minimum=provera_ogranicenja(Pop{v});
    end
end

if (minimum==0)
    Gao=0;
    iter=0;
else
    for i=1:5000    %Generisemo drugu polovinu populacije random i ukrstamo celokupnu populaciju
        for v=1:snop/2
           niz1=[];
           niz2=[];
           n1(v)=randi([n 2*n],1,1);
           for k=1:n1(v)
               niz1(k)=Pop{v}(k);
           end
           ind=randperm(n1(v));   %Generisemo random broj na kome ce se zameniti matrice,odnosno indeksi
           niz1=niz1(ind);
           for k=(n1(v)+1):n^2
               z=k-n1(v);
               niz2(z)=Pop{v}(k);
           end
           ind=randperm(n^2-n1(v));
           niz2=niz2(ind);
           niz=[niz1 niz2];
           Pop1{v}=reshape(niz,[n n]);
        end
        for v=1:snop/2
            for w=1:n1(v)      %Vrsimo ukrstanje
                temp=Pop{v}(w);
                Pop{v}(w)=Pop1{v}(w);
                Pop1{v}(w)=temp;
            end
        end
        for v=1:snop/2
            ver1=rand(1,1);
            if (ver1<0.1)     %Ako je ver manja od 10%,desava se mutacija i menjamo dva elementa u matrici
              Cell=napravi_sledbenike(1,Pop{v},n);
              Pop{v}=Cell{1}{1};
            end
            ver2=rand(1,1);
            if (ver2<0.1)
              Cell=napravi_sledbenike(1,Pop1{v},n);
              Pop1{v}=Cell{1}{1};
            end
        end
        suma=0;
        minimum1=2*n+2;
        for v=1:snop/2  %Racunamo prosecan i minimalan broj prekrsenih ograncenja
            suma=suma+provera_ogranicenja(Pop{v});
            suma=suma+provera_ogranicenja(Pop1{v});
            if (provera_ogranicenja(Pop{v})<minimum1)
                minimum1=provera_ogranicenja(Pop{v});
            end
            if (provera_ogranicenja(Pop1{v})<minimum1)
                minimum1=provera_ogranicenja(Pop1{v});
            end
        end
        pros(i)=suma/snop;
        min(i)=minimum1;
        if (minimum1==0)  %Ako smo dosli do nula,prekidamo,inace nova iteracija
            Gao=0;
            iter=i;
            break
        else
            Gao=minimum1;
            iter=i;
        end
        Pop=vrati_pop(Pop,Pop1,n,snop); %Biramo polovinu najboljih,elitnu decu
    end   %od kojih u sledecoj iteraciji nastavljamo algoritam
       
end

end