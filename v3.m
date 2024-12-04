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

A=[-q*S*Cya/(m*v), 1;
    q*S*L*mza/Jz, q*S*L*mzoz*L/(2*Jz*v)];
b=[-q*S*Cydz/(m*v); q*S*L*mzdz/Jz];
c=[1,0];
d=0;