function tensor = outer_prod(M1, M2) 
	% outer product of two matrix M1 and M2:
	% tensor^ijkl = M1^ij * M2^kl

	M1_tmp = reshape(M1.',[],1);
	M2_tmp = reshape(M2.',1,[]);
	tensor = M1_tmp * M2_tmp;

end
