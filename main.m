
%% Generisanje matrice NxN i racunanje ogranicenja

%clc; clear all;

% Random n dimenzija matrice
%n=randi([2,10],1,1);  ZA SLUCAJ DA HOCEMO RANDOM N

n=3;
A=generisanje_matrice(n);      %generisanje matrice
maxogr=2*n+2;                  %Maksimalan broj ogranicenja
ogrA=provera_ogranicenja(A);   %Broj prekrsenih ogranicenja

disp(['Slucajno izabrano pocetno resenje je: ']);
A
disp(['Maksimalan broj ogranicenja pocetnog resenja je: ',num2str(maxogr)]);
disp(['Broj prekoracenih ogranicenja pocetnog resenja je: ',num2str(ogrA)]);

%% Nasumicna pretraga

[Nm,No,iter]=nasumicna_pretraga(A,n);   %nasumicna pretraga
disp(['Minimalni broj prekoracenih ogranicenja nasumicne pretrage je: ',num2str(No)]);
disp(['Broj iteracija je: ',num2str(iter)]);
disp(['Dobijeno resenje nasumicne pretrage je: ']);
Nm   %dobijena matrica

%% Monte Carlo nasumicne pretrage

%clc; clear all;

n=3;
iteracije=5000;   %broj iteracija
MCNn=zeros(100,2);
A=generisanje_matrice(n);   
maxogr=2*n+2;   %maksimalan broj ogranicenja

for i=1:100   %Monte Carlo simulacija
    [Nm,No,iter]=nasumicna_pretraga(A,n);
    MCNn(i,1)=iter;
    MCNn(i,2)=No;
end
figure(1);
plot(1:100,MCNn(:,1),'b');
title('Monte Carlo simulacija nasumicne pretrage-broj iteracija');
axis([1 100 -10 iteracije+5000]);
figure(2);
plot(1:100,MCNn(:,2),'r');
title('Monte Carlo simulacija nasumicne pretrage-broj prekrsenih ogranicenja');
axis([1 100 -1 maxogr+2]);

Sro=mean(MCNn(:,2)); %prosecan broj prekrsenih ogranicenja
Sri=mean(MCNn(:,1)); %prosecan broj iteracija
BrNula=sum(MCNn(:,2)==0);  %broj pronadjenih konacnih resenja

%% Pretraga po snopu

%clc; clear all;

n=3;
snop=4;    % moze i n*n
rod=5;     % moze i n*n

[Ppso,iter,pros,min]=pretraga_po_snopu(rod,snop,n);  %pretraga po snopu
disp(['Minimalni broj prekoracenih ogranicenja pretrage po snopu je: ',num2str(Ppso)]);
disp(['Broj iteracija je: ',num2str(iter)]);

min=min(min>0);    
min=[min 0];       % Minimalan broj prekrsenih sa krajnjim nultim
t1=1:length(min);  % Duzina niza
pros=pros(pros>0); %Prosecan broj prekrsenih ogranicenja
t2=1:length(pros); % Duzina niza

subplot(2,1,1);   %Prikaz u subplotu
plot(t1,min,'r');
title('Minimalan broj prekrsenih ogranicenja');
axis([1 length(min) 0 2*n+2]);
subplot(2,1,2);
plot(t2,pros,'b');
title('Prosecan broj prekrsenih ogranicenja');
axis([1 length(pros) 0 2*n+2]);
%% Monte Carlo pretrage po snopu

%clc; clear all;

iteracije=5000;
MCNpps=zeros(100,2);
n=3;
snop=4;   %n*n
rod=6;    %n*n

for i=1:100
    [Ppso,iter,pros,min]=pretraga_po_snopu(rod,snop,n);
    MCNpps(i,1)=iter;
    MCNpps(i,2)=Ppso;
end
figure(1);
plot(1:100,MCNpps(:,1),'b');
title('Monte Carlo simulacija pretrage po snopu-broj iteracija');
axis([1 100 -10 6000]);
figure(2);
plot(1:100,MCNpps(:,2),'r');
title('Monte Carlo simulacija pretrage po snopu-broj prekrsenih ogranicenja');
axis([1 100 -1 10]);

Sro=mean(MCNpps(:,2));   %Prosecan broj prekrsenih ogranicenja 
Sri=mean(MCNpps(:,1));   %Prosecan broj iteracija
BrNula=sum(MCNpps(:,2)==0); %Broj prnadjenih konacnih resenja

%% Gramziva pretraga

%clc; clear all;

n=3;
rod=6;
maxogr=2*n+2;
% Heuristika sto manji broj prekrsenih ogranicenja

[Go,iter,niz]=gramziva_pretraga(rod,n);

niz=niz(niz>0);
niz=[niz 0];
t=1:1:length(niz);
figure();
axis([0 length(niz) 0 maxogr]);  %Prikaz promene ogranicenja u zavisnosti od iteracija
plot(t,niz);
title('Promena ogranicenja usled porasta iteracija');
axis([0 length(niz) 0 maxogr]);
%% Monte Carlo gramzive pretrage

%clc; clear all;

iteracije=5000;
MCNg=zeros(100,2);
n=3;
rod=10;    %n*n

for i=1:100
    [Go,iter,niz]=gramziva_pretraga(rod,n);
    MCNg(i,1)=iter;
    MCNg(i,2)=Go;
end
figure(1);
plot(1:100,MCNg(:,1),'b');
title('Monte Carlo simulacija gramzive pretrage-broj iteracija');
axis([1 100 -10 iteracije+500]);
figure(2);
plot(1:100,MCNg(:,2),'r');
title('Monte Carlo simulacija gramzive pretrage-broj prekrsenih ogranicenja');
axis([1 100 -1 10]);

Sro=mean(MCNg(:,2));   %   Prosecan broj prekrsenih ogranicenja
Sri=mean(MCNg(:,1));   %   Prosecan broj iteracija
BrNula=sum(MCNg(:,2)==0); % Broj pronadjenih konacnih resenja

%% Simulirano kaljenje

%clc; clear all;

n=3;
A=generisanje_matrice(n);
[SKo,iter,nizogr,niztemp,nizver]=simulirano_kaljenje(A,n);

t1=1:length(nizogr);
t2=1:length(niztemp);
t3=1:length(nizver);

subplot(3,1,1);   %Prikaz u subplotu promene temperature,verovatnoce prihvatanja i ogranicenja
plot(t1,nizogr,'b');  %u zavisnosti od iteracija
title('Promena ogranicenja u zavisnosti od vremena/iteracija');
axis([0 length(nizogr) 0 9]);
subplot(3,1,2);
plot(t2,niztemp,'r');
title('Promena temperature u zavisnosti od vremena/iteracija');
axis([0 length(niztemp) 0 1]);
subplot(3,1,3);
plot(t3,nizver,'c');
title('Promena verovatnoce prihvatanja u zavisnosti od vremena/iteracija');
axis([0 length(nizver) 0 1]);

%% Monte Carlo simuliranog kaljenja

%clc; clear all;

iteracije=5000;
MCNsk=zeros(100,2);
n=3;
maxogr=2*n+2;
A=generisanje_matrice(n);
%Pokretanje Monte Carlo simulacije 100 puta
for i=1:100
    [SKo,iter,nizogr,niztemp,nizver]=simulirano_kaljenje(A,n);
    MCNsk(i,1)=iter;
    MCNsk(i,2)=SKo;
end
figure(1);
plot(1:100,MCNsk(:,1),'b');
title('Monte Carlo simulacija simuliranog kaljenja-broj iteracija');
axis([1 100 -10 iteracije+500]);
figure(2);
plot(1:100,MCNsk(:,2),'r');
title('Monte Carlo simulacija simuliranog kaljenja-broj prekrsenih ogranicenja');
axis([1 100 -1 maxogr+1]);

Sro=mean(MCNsk(:,2));   %   Prosecan broj prekrsenih ogranicenja
Sri=mean(MCNsk(:,1));   %   Prosecan broj iteracija
BrNula=sum(MCNsk(:,2)==0); % Broj pronadjenih nula


%% Genetski algoritam

%clc; clear all;

n=3;
snop=200;
[Gao,iter,pros,min]=genetski_algoritam(n,snop);

t1=1:length(pros);  %Duzina niza prosecnih ogranicenja
t2=1:length(min);   %Duzina niza minimalnih ogranicenja

subplot(2,1,1);    %Prikaz rezultata u subplotu
plot(t1,pros,'r');
title('Prosecan broj prekrsenih ogranicenja');
axis([1 length(pros) 0 2*n+2]);
subplot(2,1,2);
plot(t2,min,'r');
title('Minimalan broj prekrsenih ogranicenja');
axis([1 length(min) 0 2*n+2]);

%% Monte Carlo genetski algoritam

%clc; clear all;

iteracije=5000;
MCNga=zeros(100,2);
n=3;
snop=200;
maxogr=2*n+2;
%Prikazivanje Monte Carlo simulacije
for i=1:100
    [Gao,iter,pros,min]=genetski_algoritam(n,snop);
    MCNga(i,1)=iter;
    MCNga(i,2)=Gao;
end
figure(1);
plot(1:100,MCNga(:,1),'b');
title('Monte Carlo simulacija genetskog algoritma-broj iteracija');
axis([1 100 -10 iteracije+500]);
figure(2);
plot(1:100,MCNga(:,2),'r');
title('Monte Carlo simulacija genetskog algoritma-broj prekrsenih ogranicenja');
axis([1 100 -1 maxogr+1]);

Sro=mean(MCNga(:,2));   %  Prosecan broj prekrsenih ogranicenja
Sri=mean(MCNga(:,1));   %  Prosecan broj iteracija 
BrNula=sum(MCNga(:,2)==0); % Broj pronadjenih nula 


%%  Plotovanje svih Monte Carlo resenja ogranicenja

figure(10)

plot(1:100,MCNga(:,2),'c');
axis([1 100 -1 maxogr+1]);
hold on;
plot(1:100,MCNn(:,2),'b');
hold on;
plot(1:100,MCNpps(:,2),'y');
hold on
plot(1:100,MCNsk(:,2),'g');
hold on
plot(1:100,MCNg(:,2),'r');
hold off
legend('Genetski algoritam','Nasumicna pretraga','Pretraga po snopu','Simulirano kaljenje','Gramziva pretraga');

%% Plotovanje svih Monte Carlo resenja broja iteracija
figure(11)

plot(1:100,MCNga(:,1),'c');
axis([1 100 -1 iteracije+500]);
hold on;
plot(1:100,MCNn(:,1),'b');
hold on;
plot(1:100,MCNpps(:,1),'y');
hold on
plot(1:100,MCNsk(:,1),'g');
hold on
plot(1:100,MCNg(:,1),'r');
hold off
legend('Genetski algoritam','Nasumicna pretraga','Pretraga po snopu','Simulirano kaljenje','Gramziva pretraga');


%% Pronalazenje standardne devijacije prekrsenih ogranicenja

stdg=std(MCNg(:,2));     %0
stdsk=std(MCNsk(:,2));   %0.6385
stdpps=std(MCNpps(:,2));   %0
stdn=std(MCNn(:,2));         %0.6963
stdga=std(MCNga(:,2));       %0

stdgIter=std(MCNg(:,1));   %319.4832
stdskIter=std(MCNsk(:,1));    %1938.5
stdppsIter=std(MCNpps(:,1));    %456.0714
stdnIter=std(MCNn(:,1));         %997.6930
stdgaIter=std(MCNga(:,1));  %28.6728

%%  Pronalazenje standardne devijacije broja iteracija
Sroga=mean(MCNga(:,2));     %0
Sriga=mean(MCNga(:,1));     %34.47

Srog=mean(MCNg(:,2));       %0
Srig=mean(MCNg(:,1));       %362.49

Sropps=mean(MCNpps(:,2));   %0
Sripps=mean(MCNpps(:,1));   %363.83

Srosk=mean(MCNsk(:,2));     %0.42
Srisk=mean(MCNsk(:,1));     %2518.1

Sron=mean(MCNn(:,2));    % 1.6
Srin=mean(MCNn(:,1));    %4697.9












