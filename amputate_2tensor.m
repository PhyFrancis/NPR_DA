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

	if rem(size(tensor,2),12) ~= 0
		fprintf('amputate_2tensor::column number %d is not a multiple of 12!\n',size(tensor,2));
	end
	nBlock = size(tensor,2) / 12;

	tensor_amp = [];
	for i = 0:nBlock-1
		tensor_amp = [tensor_amp, M1 * tensor(:,i*12+[1:12]) * M2];
	end

	clear nBlock;
	clear M1;
	clear M2;

end
