% This file does K->PiPi(I=0) NPR analysis

clear all;

% initialize fitting parameters:
run('conf.m');

% load data: 
[bulk_even n1] = load_bulk_file(place,bulk_file_name_even,all_traj);
[bulk_odd  n2] = load_bulk_file(place,bulk_file_name_odd,all_traj);
[bulk_leg_p1 n3] = load_bulk_file(place,leg_p1_name,all_traj); % S(p1)
[bulk_leg_p2 n4] = load_bulk_file(place,leg_p2_name,all_traj); % S(p2)
[sub_bulk_even n5] = load_bulk_file(place,sub_bulk_file_name_even,all_traj);
[sub_bulk_odd  n6] = load_bulk_file(place,sub_bulk_file_name_odd,all_traj);

if ~isequaln(n1,n2,n3,n4,n5,n6)
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
 
C_left = cell(22,1); % 1  ~ 16 : left part of diagrams, without spectator quark.
                     % 17 ~ 22 : B1, B2, and B3 to be subtracted.
C_sub = cell(22,1); % similar to C_left, but only used to determine subtraction coefficients
										 
for i = 1:8
	C_left{i  ,1} = load_matrix(bulk_even,i+1); % vvd, vvdm, aad, aadm, vv2d, vv2dm, aa2d, aa2dm
	C_left{i+8,1} = load_matrix(bulk_odd ,i+1); % avd, avdm, vad, vadm, av2d, av2dm, va2d, va2dm
	C_sub{i  ,1} = load_matrix_sub(sub_bulk_even,i); % same as bulk_even
	C_sub{i+8,1} = load_matrix_sub(sub_bulk_odd ,i); % same as bulk_odd
end
for i = 1:3
	C_left{i+16,1} = load_matrix(bulk_even,i+9); % sbd, bd, bs
	C_left{i+19,1} = load_matrix(bulk_odd ,i+9); % sb5d, b5d, b5s
	C_sub{i+16,1} = load_matrix_sub(sub_bulk_even,i+8); % same as bulk_even
	C_sub{i+19,1} = load_matrix_sub(sub_bulk_odd ,i+8); % same as bulk_odd
end

% calculate jackknifed C1~C6:
C = cell(4,9); % [VV,AA,AV,VA] for C1 
               %  ... ... ...  for C2 
               %  ... ... ...  for C3 
               %  ... ... ...  for C4 
               %  ... ... ...  for C5 
               %  ... ... ...  for C6 
               %  [1,\gamma_5] for C7
               %  [1,\gamma_5] for C8
               %  [1,\gamma_5] for C9
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
for eo = 1:2
	off = (eo-1)*3;
	C{eo,7} = amputate_4tensors(jackknife_outer_prod(C_left{17+off,1},spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C7
	C{eo,8} = amputate_4tensors(jackknife_outer_prod(C_left{18+off,1}-C_left{19+off,1},spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C8
	C{eo,9} = amputate_4tensors(jackknife_outer_prod(C_left{18+off,1}+C_left{19+off,1},spec),jackknifed_leg_p1,jackknifed_leg_p2); % for C9
end

% calculate subtraction coefficients before B1, B2, and B3 operators
subtractionCoeff = determineSubCoeff(C_sub, jackknifed_leg_p1, jackknifed_leg_p2, p1, p2);

% calculate the 7-by-2 M_ij = Q_i E_j (each M_ij is a 4-spin-color-tensor)
if doSubtraction == 1
	S = applySubCoeff(C, subtractionCoeff); % TODO implement it
	M72 = combineQdotE(S); 
else 
	M72 = combineQdotE(C); 
end


% calculate the 7-by-7 M_ij = Q_i H_j 
M77 = combineQdotH(M72);
  
% calculate the 7-by-7 Z = F * M^-1
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

Z77 = cell(1,2);
Z77{1,1} = inv(Z77inv_mean{1,1});
Z77{1,2} = inv(Z77inv_mean{1,2});
save(['result/Z77Matrix',label,'.mat'],'Z77');

% calculate Zq
Zq1 = compute_Zq(jackknifed_leg_p1,p1);
Zq2 = compute_Zq(jackknifed_leg_p2,p2);
Zq_avg = real(mean((Zq1 + Zq2) / 2.0));
save(['result/Zq',label,'.mat'],'Zq_avg');
