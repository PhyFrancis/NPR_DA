% This file does K->PiPi(I=0) NPR analysis

% clear all;

% initialize fitting parameters:
place = '/home/daiqian/BGQ/NPR/16nt/';
% place = '/home/daiqian/BGQ/NPR/Qi_16nt/';
all_traj = [1000:40:1000];
bulk_file_name_even = ['k2pipiNPR_even_p0_p1.txt'];
bulk_file_name_odd = ['k2pipiNPR_odd_p0_p1.txt'];
leg_p1_name = ['legs_p0.txt'];
leg_p2_name = ['legs_p1.txt'];

% load data: % TODO include jackknife
bulk_even = load_bulk_file(place,bulk_file_name_even,all_traj);
bulk_odd = load_bulk_file(place,bulk_file_name_odd,all_traj);
leg_p1 = toComplex(load_bulk_file(place,leg_p1_name,all_traj)); % S(p1)
leg_p2 = toComplex(load_bulk_file(place,leg_p2_name,all_traj)); % S(p2)

scsc_tensor = cell(8,1);
for i = 1:4
	scsc_tensor{i  ,1} = amputate_4tensor(load_tensor(bulk_even,i),leg_p1,leg_p2); % VV, VVm, AA, AAm
	scsc_tensor{i+4,1} = amputate_4tensor(load_tensor(bulk_odd ,i),leg_p1,leg_p2); % AV, AVm, VA, VAm
end

% TODO make sure spec: row-p1 col-p2
spec = amputate_2tensor(load_matrix(bulk_even,1),leg_p1,leg_p2); % could also use bulk_odd.

C_left = cell(16,1); % left part of diagrams, without spectator quark.
for i = 1:8
	C_left{i  ,1} = amputate_2tensor(load_matrix(bulk_even,i+1),leg_p1,leg_p2); % vvd, vvdm, aad, aadm, vv2d, vv2dm, aa2d, aa2dm
	C_left{i+8,1} = amputate_2tensor(load_matrix(bulk_odd ,i+1),leg_p1,leg_p2); % avd, avdm, vad, vadm, av2d, av2dm, va2d, va2dm
end

% calculate C1~C6:
C = cell(4,6); % [VV,AA,AV,VA] for C1 
               %  ... ... ...  for C2 
               %  ... ... ...  for C3 
               %  ... ... ...  for C4 
               %  ... ... ...  for C5 
               %  ... ... ...  for C6 

for i = 1:4 
	C{i,1} = scsc_tensor{2*i-1,1}; % for C1
	C{i,2} = scsc_tensor{2*i  ,1}; % for C2
end
for i = 1:4
	j = i*2-1+(i>2)*4;
	C{i,3} = outer_prod(C_left{j,1}, spec); % for C3
	j = i*2+(i>2)*4;
	C{i,4} = outer_prod(C_left{j,1}, spec); % for C4
	j = i*2+3+(i>2)*4;
	C{i,5} = outer_prod(C_left{j,1}, spec); % for C5
	j = i*2+4+(i>2)*4;
	C{i,6} = outer_prod(C_left{j,1}, spec); % for C6
end

% calculate the 7-by-2 M_ij = Q_i E_j (each M_ij is a 4-spin-color-tensor)
M72 = combineQdotE(C);

% calculate the 7-by-7 M_ij = Q_i H_j 
M77 = combineQdotH(M72);
 
% calculate the 7-by-7 Z = F * M^-1 * Z_q^2
% TODO include Z_q

load F77Matrix;
Z77inv = cell(2,1);
for eo = 1:2
	Z77inv{eo,1} = M77{eo,1} * inv(F77);
end
Z77inv{1,1}
Z77inv{2,1}
