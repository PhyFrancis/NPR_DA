function tensor = outer_prod2(spinM1, spinM2) 
	% outer product of spin matrix spinM1 and spinM2:
	%
	% tensor^ijkl = spinM1^ij * spinM2^kl

	M1_tmp = reshape(spinM1.',[],1);
	M2_tmp = reshape(spinM2.',1,[]);
	tensor = M1_tmp * M2_tmp;

end
