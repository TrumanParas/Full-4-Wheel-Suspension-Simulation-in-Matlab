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
vx_o = 51.33; % ft/s, 35 mph

% define tire model
FY_coeffs = [2.861990 2.252206 0.172982 1.419576];












