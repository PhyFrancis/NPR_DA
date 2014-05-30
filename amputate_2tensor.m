function tensor_amp = amputate_2tensor(tensor, leg_p1, leg_p2)
	% amputate 2-index tensor
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('GammaMatrix loaded.\n');
	end

	g5 = toSCMatrix(gamma{5,1});
	M1 = inv(g5 * leg_p1' * g5);
	M2 = inv(     leg_p2      );

	tensor_amp = M1 * tensor * M2;

end
