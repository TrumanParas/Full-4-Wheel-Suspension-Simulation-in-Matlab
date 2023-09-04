clear; clc; close all;

% this function must be ran before running the simulation
timestep = .01;

% define the road surface
climb = [.05,.1,.15,.2,.25,.3,.35,.4,.45,.5,.55,.6,.65,.7,.75,.8,.85,.9,.95,1];
% road_height_right = [zeros(1,1000), climb, ones(1,1000), fliplr(climb)]./4;
% road_height_left = [zeros(1,1000), climb, ones(1,1000), fliplr(climb)]./4;

road_height_right = [zeros(1,10000)];
road_height_left = [zeros(1,10000)];


dist = zeros(1, length(road_height_right));
for i = 2:length(road_height_right)
    dist(i) = dist(i-1)+.1;
end

% define longitudinal acceleration
long_a(1) = 1;
for i = 2:500
    long_a(i) = long_a(i-1)-1/500;
end
long_a(501:1540) = 0;
for i = 1:500
    long_a(1540+i) = long_a(1539+i)+1/500;
end

% vehicle parameters (length unit = foot, weight unit = lbf)
total_weight = 650;
weight_distribution = .5;
f_unsprung = 48.24;
r_unsprung = 47.56;
total_unsprung = f_unsprung + r_unsprung;
f_sprung = total_weight*weight_distribution-f_unsprung; 
r_sprung = total_weight*weight_distribution-r_unsprung;
tire_k = 989*12;
tire_c = .1*(2*sqrt(tire_k*f_unsprung/(2*32.17)));
cg = 13/12; 
f_unsprung_cg = 6/12;
r_unsprung_cg = 6/12;
track = 48/12;
f_MR_spring= .99;                
f_MR_arb = .4;                      
f_rc = 1/12;                                                       
r_MR_spring = .96;
r_MR_arb = .25;          
r_rc = 2/12;                     
wheelbase = 60.5/12;
f_anti = .2;
r_anti = .2;
f_spring = 250*12;
f_arb = 202.9*12;
r_spring = 150*12;
r_arb = 108.66*12;
f_damp_ratio = .7;
r_damp_ratio = .7;
f_c = f_damp_ratio*(2*sqrt(f_sprung*f_spring/(32.17*2)));
r_c = r_damp_ratio*(2*sqrt(r_sprung*r_spring/(32.17*2)));
chassis_k = 1000; % lbf-ft/deg
Izz = 500; % lbf-ft-s^2

% initial conditions
vy_o = 0;
vx_o = 51.3333; % ft/s, 35 mph

% define tire model
fy_slip_angle_lookup = [-146.8, -150.9, -152.1, -152.0, -152.0, -153.2, -155.9, -155.8, -157.1, -158.4, -158.3, -149.9, -138.8, -113.9, -69.7, -10.4, 44.9, 82.2, 105.7, 114.0, 118.3, 121.1, 121.2, 122.2, 122.3, 121.0, 121.1, 121.9, 119.1, 117.0, 115.7;
    -274.3, -275.0, -275.7, -276.4, -282.7, -283.5, -286.6, -288.1,-288.8, -289.5, -288.6, -278.9, -253.0, -205.6, -120.9, -8.7, 102.5, 177.7, 216.9, 239.2, 247.8, 253.2, 254.3, 253.2, 252.2, 250.2, 248.3, 247.3, 247.4, 244.4, 242.4;
    -392.4, -395.6, -400.9, -405.1, -407.2, -410.3, -414.5, -416.6, -417.6, -417.5, -414.2, -396.8, -358.9, -286.5, -156.9, 14.5, 163.1, 264.1, 322.7, 353.4, 369.7, 374.3, 377.1, 376.3, 374.6, 373.8, 372.1, 367.6, 365.0, 362.9, 362.2;
    -627.6, -633.6, -638.3, -639.4, -644.2, -647.7, -650.0, -653.6, -653.5, -648.5, -630.3, -590.2, -521.1, -386.5, -201.8, 11.1, 242.0, 398.3, 494.1, 547.4, 579.1, 591.3, 598.9, 601.8, 600.0, 600.1, 598.3, 591.9, 587.3, 583.7, 580.5;
    -849.7, -852.4, -855.1, -863.4, -863.3, -866.0, -860.3, -857.4, -846.1, -818.0, -778.7, -706.6, -592.3, -421.0, -209.0, 39.0, 272.0, 458.5, 592.5, 678.3, 732.2, 764.3, 785.0, 792.0, 796.6, 796.7, 796.8, 791.2, 790.1, 784.5, 782.3];

fy_slip_angle_lookup = [fy_slip_angle_lookup(1,1:16)+10.4;fy_slip_angle_lookup(2,1:16)+8.7;fy_slip_angle_lookup(3,1:16)-14.5;fy_slip_angle_lookup(4,1:16)-11.1;fy_slip_angle_lookup(5,1:16)-39];
fy_slip_angle_lookup = [fy_slip_angle_lookup, -flip(fy_slip_angle_lookup(:,1:15),2)];












