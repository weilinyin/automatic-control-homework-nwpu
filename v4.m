clear

A=[0 1 0 0;
   0 0 0 0;
   0 0 0 1;
   0 0 48.3 0];
B=[0;1;0;4.9];
C=[1 0 0 0;
   0 0 1 0];
D=[0;0];
x_0=[0;0;pi;0];
p_t=[-4 -4 -5+5i -5-5i];
p=sym('p');
f=(p-p_t(1))*(p-p_t(2))*(p-p_t(3))*(p-p_t(4));
f=expand(f);
K=sym('k',[1 4]);
target=sym2poly(f);
eqn=charpoly(A-B*K)-target;
k=solve(eqn);
K=double([k.k1,k.k2,k.k3,k.k4]);%状态反馈

L=sym('L',[4 2]);
target=[1 9 31 49 30];
eqn=[charpoly(A-L*C)-target,L(1,1),L(1,2),L(2,1)];
l=solve(eqn);
L=double([l.L1_1,l.L1_2; ...
          l.L2_1,l.L2_2; ...
          l.L3_1,l.L3_2; ...
          l.L4_1,l.L4_2]);%状态观测器


