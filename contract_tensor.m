function y = contract_tensor(spin_tensor,op)
	% when op == 'LL':
	% y = tensor^ijkl * [\gamma_\mu(1-\gamma_5)]^ji * [\gamma_\mu(1-\gamma_5)]^lk
	%
	% when op == 'LR':
	% y = tensor^ijkl * [\gamma_\mu(1-\gamma_5)]^ji * [\gamma_\mu(1+\gamma_5)]^lk
	
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('GammaMatrix loaded.\n');
	end

	y = 0;
	for dir = 1:4
		if op == 'LL'
			% tensor_tmp = outer_prod((gamma{dir,1} * (eye(4) - gamma{5,1})).', ...
			%                         (gamma{dir,1} * (eye(4) - gamma{5,1})).'); % TODO figure out which way is correct
			tensor_tmp = outer_prod(((eye(4) - gamma{5,1}) * gamma{dir,1}).', ...
			                        ((eye(4) - gamma{5,1}) * gamma{dir,1}).');
		elseif op == 'LR'
			% tensor_tmp = outer_prod((gamma{dir,1} * (eye(4) - gamma{5,1})).', ...
			%                         (gamma{dir,1} * (eye(4) + gamma{5,1})).');
			tensor_tmp = outer_prod(((eye(4) - gamma{5,1}) * gamma{dir,1}).', ...
			                        ((eye(4) + gamma{5,1}) * gamma{dir,1}).');
		else 
			fprintf('%s not supported in contarct_tensor\n',op);
		end
		y = y + sum(sum(spin_tensor.*tensor_tmp));
	end

end
