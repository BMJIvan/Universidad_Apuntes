clc
clear all
close all


syms s k1 k2 k3 k4 k5 k6
%ejercicio 4 por metodo directo
A=[0,1,0,0,0,0
   16,0,-8,0,0,0
   0,0,0,1,0,0
   -16,0,16,0,0,0
   0,0,0,0,0,1
   0,0,0,0,0,0];
B=[0;-1;0;0;0;1];
K=[k1,k2,k3,k4,k5,k6];
L=size(B,1);
I=eye(L);

MD1=expand(det(s*I-(A-B*K)));
MD2=expand((s-(-10+2j))*(s-(-10-2j))*(s-(-10+4j))*(s-(-10-4j))*(s+5)*(s+20));

pol=MD1;
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
Ma1=a;

pol=MD2;
a=zeros(1,L);
a(L)=subs(pol,s,0);
npol=pol-a(L);
b=sym(zeros(L,1));
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
Ma2=a;

ec=[0,-1,0,0,0,1
    -1,0,0,0,1,0
    0,16,0,16,0,-32
    16,0,16,0,-32,0
    0,0,0,0,0,128
    0,0,0,0,128,0];
cons=subs(Ma1,{k1,k2,k3,k4,k5,k6},{0,0,0,0,0,0});
Ma2=Ma2-cons;

detp=det(ec);
MeDir=zeros(1,L);
ecpn=zeros(6,6);
for n=1:L
    ecpn=ec;
    ecpn(:,n)=Ma2;
   MeDir(n)=det(ecpn)/detp; 
end
disp(MeDir)
eig(A-B*MeDir)
 
