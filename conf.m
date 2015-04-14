% Warining:
% Qi's numbers are not considering 3.2 in propagator

% all_traj = [1000:20:1080];
% place = '/home/daiqian/BGQ/NPR/NPR_checkJulien/'; 
% p1 = [2,2,0,0] * (2*3.1415926 / 16);
% p2 = [0,2,2,0] * (2*3.1415926 / 16);
% label = ['check_Julien'];

% all_traj = [1000:40:1960];
all_traj = [1000:40:1080];
place = '/home/daiqian/BGQ/NPR/Qi_16nt_2.15GeV/';
p1 = [1,1,2,4/2] * (2*3.1415926 / 16);
p2 = [2,1,2,-2/2] * (2*3.1415926 / 16);
Z_V = 1.0; Z_A = 1.0;
label = ['2.15GeV'];

% all_traj = [1000:40:1120];
% place = '/home/daiqian/BGQ/NPR/Qi_16nt_1.9GeV/'; 
% p1 = [0,2,2,0] * (2*3.1415926 / 16);
% p2 = [2,2,0,0] * (2*3.1415926 / 16);
% label = ['1.92GeV'];

% all_traj = [1004:32:1800];
% place = '/home/daiqian/BGQ/NPR/32nt_0440_4400_ml0.01/'; 
% p1 = [0,4,4,0] * (2*3.1415926 / 32);
% p2 = [4,4,0,0] * (2*3.1415926 / 32);
% Z_V = 0.6728; Z_A = 0.68778;
% label = ['1.52GeV'];

% all_traj = [1064:8:2000];
% place = '/home/daiqian/BGQ/NPR/32nt_0440_4400_ml0.01/'; 
% p1 = [0,4,4,0] * (2*3.1415926 / 32);
% p2 = [4,4,0,0] * (2*3.1415926 / 32);
% Z_V = 0.6728; Z_A = 0.68778;
% label = ['1.52GeV'];

bulk_file_name_even = ['k2pipiNPR_even_p0_p1.txt'];
bulk_file_name_odd = ['k2pipiNPR_odd_p0_p1.txt'];
sub_bulk_file_name_even = ['subtractionCoeff_even_p0_p1.txt'];
sub_bulk_file_name_odd = ['subtractionCoeff_odd_p0_p1.txt'];
bilinear_file_name = ['bilinear_p0_p1.txt'];
leg_p1_name = ['legs_p0.txt'];
leg_p2_name = ['legs_p1.txt'];
doSubtraction = 1; % 1:do subtraction; 0:don't do subtraction
