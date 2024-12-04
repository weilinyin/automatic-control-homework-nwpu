%导入初始条件
Cya=0.2667*57.3;
Cydz=0.05*57.3;
mza=-0.0082*57.3;
mzoz=-0.022*57.3;
mzdz=-0.0191*57.3;
L=1;
S=0.0065;
m=5.2144;
Jz=0.1879;
Jy=0.1897;
Jx=0.0073;
v=100;
q=6125;

x3_0=9.8/v;

A=[-q*S*Cya/(m*v), 1 ,1;
    q*S*L*mza/Jz, q*S*L*mzoz*L/(2*Jz*v), 0;
    0, 0, 0];
b=[-q*S*Cydz/(m*v); q*S*L*mzdz/Jz;0];
c=[1,0,0];
d=0;

sys=ss(A,b,c,d);
[num,den]=ss2tf(A,b,c,d);
sys1=tf(num,den);
sys2=-0.3-30*tf(1,[1 0])-0.3*tf([100 0],[1 100]);
CLTF=feedback(sys1*sys2,1);
[A,b,c,d]=tf2ss(CLTF.Numerator{1},CLTF.Denominator{1});
sys=ss(A,b,c,d);
t=[0:0.001:1]';
u=zeros(1001,1)+0.3;
[y,t,x]=lsim(sys,u,t,[0;0;0;0;x3_0]);
plot(t,y);
title('$\alpha$','Interpreter','latex');
