function subtractionCoeff = determineSubCoeff(C_sub, jackknifed_leg_p1, jackknifed_leg_p2, p1, p2)
	% calculate the subtraction coefficients before B1, B2, and B3 operators
	
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('determineSubCoeff::GammaMatrix loaded.\n');
	end
	
	nConf = size(jackknifed_leg_p1,2) / 12;
	
	jackknifed_C_sub = cell(4,4); % [VV,AA,AV,VA] for C3 
								  							%  ... ... ...  for C4 
								  							%  ... ... ...  for C5 
								  							%  ... ... ...  for C6 
																
	jackknifed_B_sub = cell(3,2); % [1, \gamma_5] for B1 
																% [1, \gamma_5] for B2 
																% [1, \gamma_5] for B3 
																
	for i = 1:4
		j = i*2-1+(i>2)*4;
		jackknifed_C_sub{i,1} = amputate_2tensors(jackknife(C_sub{j,1}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for C3
		j = i*2+(i>2)*4;
		jackknifed_C_sub{i,2} = amputate_2tensors(jackknife(C_sub{j,1}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for C4
		j = i*2+3+(i>2)*4;
		jackknifed_C_sub{i,3} = amputate_2tensors(jackknife(C_sub{j,1}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for C5
		j = i*2+4+(i>2)*4;
		jackknifed_C_sub{i,4} = amputate_2tensors(jackknife(C_sub{j,1}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for C6
	end

	for eo = 1:2
		off = (eo-1)*3;
		jackknifed_B_sub{1,eo} = amputate_2tensors(jackknife(C_sub{17+off,1}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for B1
		jackknifed_B_sub{2,eo} = amputate_2tensors(jackknife(C_sub{18+off,1}-C_sub{19+off}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for B2
		jackknifed_B_sub{3,eo} = amputate_2tensors(jackknife(C_sub{18+off,1}+C_sub{19+off}, nConf),jackknifed_leg_p1,jackknifed_leg_p2); % for B3
	end

	% use jackknifed_Q_sub and jackknifed_B_sub to compute subtractionCoeff
	subtractionCoeff = cell(4,4); % [VV,AA,AV,VA] for C3
								  							%  ... ... ...  for C4 
								  							%  ... ... ...  for C5 
								  							%  ... ... ...  for C6 
	
	p1pp2 = toSCMatrix(pSlash(p1+p2));
	p1mp2 = toSCMatrix(pSlash(p1-p2));

	for va = 1:4
		for q = 1:4
			subtractionCoeff{va,q} = [];
			for block = 1:nConf
				obj = zeros(3,1);
				mat = zeros(3,3);

				if va <= 2
					obj(1) = -trace(        jackknifed_C_sub{va,q}(:,(block-1)*12+[1:12]));
					obj(2) = -trace(p1pp2 * jackknifed_C_sub{va,q}(:,(block-1)*12+[1:12]));
					obj(3) = -trace(p1mp2 * jackknifed_C_sub{va,q}(:,(block-1)*12+[1:12]));
				else 
					obj(1) = -trace(toSCMatrix(gamma{5,1}) *         jackknifed_C_sub{va,q}(:,(block-1)*12+[1:12]));
					obj(2) = -trace(toSCMatrix(gamma{5,1}) * p1pp2 * jackknifed_C_sub{va,q}(:,(block-1)*12+[1:12]));
					obj(3) = -trace(toSCMatrix(gamma{5,1}) * p1mp2 * jackknifed_C_sub{va,q}(:,(block-1)*12+[1:12]));
				end

				for i = 1:3

					if va <= 2
						eo = 1; % even
						mat(1,i) = trace(        jackknifed_B_sub{i,eo}(:,(block-1)*12+[1:12]));
						mat(2,i) = trace(p1pp2 * jackknifed_B_sub{i,eo}(:,(block-1)*12+[1:12]));
						mat(3,i) = trace(p1mp2 * jackknifed_B_sub{i,eo}(:,(block-1)*12+[1:12]));
					else
						eo = 2; % odd
						mat(1,i) = trace(toSCMatrix(gamma{5,1}) *         jackknifed_B_sub{i,eo}(:,(block-1)*12+[1:12]));
						mat(2,i) = trace(toSCMatrix(gamma{5,1}) * p1pp2 * jackknifed_B_sub{i,eo}(:,(block-1)*12+[1:12]));
						mat(3,i) = trace(toSCMatrix(gamma{5,1}) * p1mp2 * jackknifed_B_sub{i,eo}(:,(block-1)*12+[1:12]));
					end

				end
				subtractionCoeff{va,q} = [subtractionCoeff{va,q}, inv(mat) * obj];
			end
		end
	end

	clearvars -except subtractionCoeff gamma;
end
