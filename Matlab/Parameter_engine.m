%% final using formulas no assumptions

clear; clc;

% specs
kn=230e-6; kp=97.3e-6;
GBW=30e6; SR=20e6;
icmrp=1.6; icmrn=0.8;
vdd=1.8; L=500e-9; CL=2e-12;
vtpmax=-0.3906012; vtnmax=0.3662473; vtnmin=0.3662473;

% compensation and bias
Cc=0.28*CL;
I5=SR*Cc;

% gm requirement
gm1=2*pi*GBW*Cc;

% differential pair
WL1=(gm1^2)/(I5*kn);
WL2=WL1;

% PMOS load
WL3=I5/(kp*(vdd-icmrp-abs(vtpmax)+vtnmin)^2);
WL4=WL3;

gm3=sqrt(I5*kp*WL3);

% second stage
gm6=10*gm1;
WL6=WL3*gm6/gm3;

% bias transistor
vdsat=icmrn-sqrt(I5/(kn*WL1))-vtnmax;
WL5=2*I5/(kn*vdsat^2);

% currents
I6=(I5/2)*WL6/WL4;

% mirror devices
WL7=WL5*I6/I5;
WL8=WL5;

% widths
W1=WL1*L; 
W2=WL2*L;
W3=WL3*L; 
W4=WL4*L;
W5=WL5*L; 
W6=WL6*L;
W7=WL7*L; 
W8=WL8*L;

% write LTspice parameter file
fid=fopen('para.inc','w');
fprintf(fid,'.param L=%g\n',L);
fprintf(fid,'.param W1=%g\n',W1);
fprintf(fid,'.param W2=%g\n',W2);
fprintf(fid,'.param W3=%g\n',W3);
fprintf(fid,'.param W4=%g\n',W4);
fprintf(fid,'.param W5=%g\n',W5);
fprintf(fid,'.param W6=%g\n',W6);
fprintf(fid,'.param W7=%g\n',W7);
fprintf(fid,'.param W8=%g\n',W8);
fprintf(fid,'.param cc=%g\n',Cc);
fprintf(fid,'.param cl=%g\n',CL);
fclose(fid);

disp('parameters updated');
