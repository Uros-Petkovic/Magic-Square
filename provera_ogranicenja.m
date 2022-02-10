
function po=provera_ogranicenja(A)
po=0;
m=length(A);
suma=m*(m^2+1)/2;    %Za svaku matricu proveravamo koliko ima prekrsenih ogranicenja
%racunajuci po vrstama, kolonama i dijagonalama odgovaraju li zadatom
%zbiru
if (sum(diag(A))~= suma)
    po=po+1;
end
if (sum(diag(flip(A)))~= suma)
    po=po+1;
end

for i=1:m
    if (sum(A(:,i))~= suma)
        po=po+1;
    end
    if (sum(A(i,:))~= suma)
        po=po+1;
    end
end
