all_traj = [1000:40:1120];

% Warinig:
% Qi's numbers are not considering 3.2 in propagator

% place = '/home/daiqian/BGQ/NPR/Qi_16nt_2.15GeV/';
% p1 = [1,1,2,4/2] * (2*3.1415926 / 16);
% p2 = [2,1,2,-2/2] * (2*3.1415926 / 16);
% label = ['2.15GeV'];

place = '/home/daiqian/BGQ/NPR/Qi_16nt_1.9GeV/'; 
p1 = [0,2,2,0] * (2*3.1415926 / 16);
p2 = [2,2,0,0] * (2*3.1415926 / 16);
label = ['1.92GeV'];

bulk_file_name_even = ['k2pipiNPR_even_p0_p1.txt'];
bulk_file_name_odd = ['k2pipiNPR_odd_p0_p1.txt'];
leg_p1_name = ['legs_p0.txt'];
leg_p2_name = ['legs_p1.txt'];

