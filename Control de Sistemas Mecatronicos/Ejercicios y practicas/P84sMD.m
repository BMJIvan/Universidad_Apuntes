clc
clear all
close all

syms s Ll

polos=[-4+2i,-4-2i,-5+i,-5-i,-5,-3];
A=[0,1,0,0,0,0;16,0,-8,0,0,0;0,0,0,1,0,0;-16,0,16,0,0,0;0,0,0,0,0,1;0,0,0,0,0,0];
B=[0;-1;0;0;0;1];
C=[1,0,1,0,1,0];

L=size(B,1);
I=eye(L);


LL=sym(zeros(L,1));
for i=1:L
    LL(i)=Ll^(i+1);
end

pol=s-polos(1);
for i=2:L
   pol=pol*(s-polos(i)); 
end
pol=expand(pol);

a=sym(zeros(1,L));
a(L)=subs(pol,s,0);
npol=pol-a(L);

for k=1:L-1
nnpol=npol;
cont=L-k;
for i=L:-1:1
    if i==cont
        nnpol=subs(nnpol,s^i,1);
    else
        nnpol=subs(nnpol,s^i,0);
    end
end
a(k)=nnpol;
end

pol=expand(det(s*I-(A-LL*C)));

an=sym(zeros(1,L));
an(L)=subs(pol,s,0);
npol=pol-an(L);

for k=1:L-1
nnpol=npol;
cont=L-k;
for i=L:-1:1
    if i==cont
        nnpol=subs(nnpol,s^i,1);
    else
        nnpol=subs(nnpol,s^i,0);
    end
end
an(k)=nnpol;
end

ecu=zeros(L,L+1);
for i=1:L
    ann=an(i);
    for j=1:L
        ann=(subs(ann(1),Ll^(1+j),0));
    end
    ecu(i,L+1)=ann;
end

an=an-(ecu(:,L+1)');

cont=1;
for i=1:L
    for k=1:L
    ann=an(i);
        for j=1:L
            if(cont==k)
                ann=subs(ann,Ll^(1+j),1);
            else
                ann=subs(ann,Ll^(1+j),0);
            end
        cont=cont+1;
        end
    cont=1;
    ecu(i,k)=ann;
    end
end
disp(ecu)
ecu(:,L+1)=-ecu(:,L+1)+a';

ecup=ecu(:,1:(L));
detg=det(ecup);
Lln=zeros(1,L);
for i=1:L
   ecupp=ecup;
   ecupp(:,i)=ecu(:,L+1);
   detp=det(ecupp);
   Lln(i)=detp/detg;
end

disp(Lln)
eig(A-Lln'*C)
