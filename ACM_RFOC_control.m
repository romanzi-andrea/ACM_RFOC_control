clear all
clc
close all
%% load the telemetry 
load('ac_brushless_data.mat');
%% AC brushless parameters   (isotropic) 
Pn = 180000;
eta = 0.95;
Pel = Pn/eta;
np = 2;
PF = 1;     % power factor = cos(phi) = 1 all the power is active
Rs = 0.1;    %ohm
Ls = 0.8e-3; %H
Ld = Ls;    %isotropic machine
Lq = Ls;
wn = 400;   %rad/s
Ypm = 0.5;  %Wb
M = 1500;   % car
m = 80;     %driver
m_tot = M+m;
a_max = 4;   %m/s
r = 0.30;         %wheel radius [m]
tau = 1/3;
B = 4*0.065*r*tau;  %friction coeff is on the wheels T = B*wm


J = m*tau^2*r^2;
wm_ref = speed_kmh/tau/r;
wm_ref = [wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref(1),wm_ref];

% V_bat = 400; %battery  is 400 const torque allocator 0.08 
V_bat = 400;  %const torque allocator 0.05 
T_braking(1) = 0;
T_braking = [0,T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking(1),T_braking]*tau;
t_sim = 110;
%%
s = tf('s');
Gcdq = 1/(Rs+Ls*s);
wcdq = 10000;
Rcdq = wcdq*(Rs+Ls*s)/s;
kpcdq = 0.08*100;
kicdq = 10*100;

Gw = 1/(J*s+B);
wcw = 1000;
Rw = wcw*(J*s+B)/s;
kpw = 8*100;
kiw = 2.6*100;