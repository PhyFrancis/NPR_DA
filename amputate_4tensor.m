function tensor_amp = amputate_4tensor(tensor, leg_p1, leg_p2)
	%amputate a 4-index tensor
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('amputate_4tensor:: GammaMatrix loaded.\n');
	end

	g5 = toSCMatrix(gamma{5,1});
	M1 = inv(g5 * leg_p1' * g5);
	M2 = inv(     leg_p2      );

	tensor_amp = kron(M1, M2.') * tensor * kron(M1.', M2);

	clearvars -except tensor_amp gamma;
end
