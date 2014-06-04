% This file does K->PiPi(I=0) NPR analysis

clear all;

% initialize fitting parameters:
% place = '/home/daiqian/BGQ/NPR/16nt/';
place = '/home/daiqian/BGQ/NPR/Qi_16nt/';
all_traj = [1000:40:1960];
bulk_file_name_even = ['k2pipiNPR_even_p0_p1.txt'];
bulk_file_name_odd = ['k2pipiNPR_odd_p0_p1.txt'];
leg_p1_name = ['legs_p0.txt'];
leg_p2_name = ['legs_p1.txt'];

% load data: 
[bulk_even n1] = load_bulk_file(place,bulk_file_name_even,all_traj);
[bulk_odd  n2] = load_bulk_file(place,bulk_file_name_odd,all_traj);
[bulk_leg_p1 n3] = load_bulk_file(place,leg_p1_name,all_traj); % S(p1)
[bulk_leg_p2 n4] = load_bulk_file(place,leg_p2_name,all_traj); % S(p2)

if ~isequaln(n1,n2,n3,n4)
	fprintf('Files numbers dont match\n')
end

jackknifed_leg_p1 = cplx_jackknife(bulk_leg_p1,n3);
jackknifed_leg_p2 = cplx_jackknife(bulk_leg_p2,n4);

jackknifed_4tensors = cell(8,1);
for i = 1:4
	jackknifed_4tensor{i  ,1} = amputate_4tensors(jackknife(load_tensor(bulk_even,i),n1),jackknifed_leg_p1,jackknifed_leg_p2); % VV, VVm, AA, AAm
	jackknifed_4tensor{i+4,1} = amputate_4tensors(jackknife(load_tensor(bulk_odd ,i),n2),jackknifed_leg_p1,jackknifed_leg_p2); % AV, AVm, VA, VAm
end

spec = load_matrix(bulk_even,1); % could also use bulk_odd.
 
C_left = cell(16,1); % left part of diagrams, without spectator quark.
for i = 1:8
	C_left{i  ,1} = load_matrix(bulk_even,i+1); % vvd, vvdm, aad, aadm, vv2d, vv2dm, aa2d, aa2dm
	C_left{i+8,1} = load_matrix(bulk_odd ,i+1); % avd, avdm, vad, vadm, av2d, av2dm, va2d, va2dm
end

% calculate jackknifed C1~C6:
C = cell(4,6); % [VV,AA,AV,VA] for C1 
               %  ... ... ...  for C2 
               %  ... ... ...  for C3 
               %  ... ... ...  for C4 
               %  ... ... ...  for C5 
               %  ... ... ...  for C6 

for i = 1:4 
	C{i,1} = jackknifed_4tensor{2*i-1,1}; % for C1
	C{i,2} = jackknifed_4tensor{2*i  ,1}; % for C2
end
for i = 1:4
	j = i*2-1+(i>2)*4;
	C{i,3} = amputate_4tensors(jackknife_outer_prod(C_left{j,1}, spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C3
	j = i*2+(i>2)*4;
	C{i,4} = amputate_4tensors(jackknife_outer_prod(C_left{j,1}, spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C4
	j = i*2+3+(i>2)*4;
	C{i,5} = amputate_4tensors(jackknife_outer_prod(C_left{j,1}, spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C5
	j = i*2+4+(i>2)*4;
	C{i,6} = amputate_4tensors(jackknife_outer_prod(C_left{j,1}, spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C6
end

% calculate the 7-by-2 M_ij = Q_i E_j (each M_ij is a 4-spin-color-tensor)
M72 = combineQdotE(C);

% calculate the 7-by-7 M_ij = Q_i H_j 
M77 = combineQdotH(M72);
  
% calculate the 7-by-7 Z = F * M^-1 * Z_q^2
% TODO include Z_q

load F77Matrix;
Z77inv = cell(n1,2);
Z77inv_mean = cell(1,2);
Z77inv_std  = cell(1,2);
for eo = 1:2
	Z77inv_mean{1,eo} = zeros(7,7);
	Z77inv_std{1,eo}  = zeros(7,7);
	for i = 1:n1
		Z77inv{i,eo} = real(M77{i,eo} * inv(F77));
	end
	for i = 1:7
		for j = 1:7
			elem_array = [];
			for conf = 1:n1
				elem_array = [elem_array, Z77inv{conf,eo}(i,j)];
			end
			Z77inv_mean{1,eo}(i,j) = mean(elem_array);
			Z77inv_std{1,eo}(i,j) = std(elem_array,1) * sqrt(n1-1);
		end
	end
	Z77inv_mean{1,eo}
	Z77inv_std{1,eo}
end
