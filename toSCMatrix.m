function scMatrix = toSCMatrix(spinMatrix)
	% promote a ss-matrix to a scsc-matrix
	scMatrix = zeros(12,12);
	for s1 = 1:4
		for s2 = 1:4
			for c = 1:3
				scMatrix(scMap(s1,c),scMap(s2,c)) = spinMatrix(s1,s2);
			end
		end
	end
end
