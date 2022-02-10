
function A=generisanje_matrice(n)

A=zeros(n,n);     %Generisanje brojeva od 1 do n^2 i njihovo pakovanje u matricu
niz=randperm(n^2);

for i=1:n^2        %popunjavanje matrice random brojevima
    A(i)=niz(i);
end
end