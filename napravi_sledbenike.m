
function [SledOgr]=napravi_sledbenike(rod,A,n)

SledOgr=cell(1,rod);

for i=1:rod          %Generisamo zadati broj sledbenika tako sto u datoj matrici menjamo dva random broja
    m=randi(n^2,1,2);
    A1=A;
    temp=A1(m(1));
    A1(m(1))=A1(m(2));
    A1(m(2))=temp;
    SledOgr{i}{1}=A1;
    SledOgr{i}{2}=provera_ogranicenja(A1);
end
end