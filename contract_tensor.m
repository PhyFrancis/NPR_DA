function y = contract_tensor(spin_tensor,op,eo)
	% when op == 'LL':
	% y = tensor^ijkl * [\gamma_\mu(1-\gamma_5)]^ji * [\gamma_\mu(1-\gamma_5)]^lk
	%
	% when op == 'LR':
	% y = tensor^ijkl * [\gamma_\mu(1-\gamma_5)]^ji * [\gamma_\mu(1+\gamma_5)]^lk
	%
	% eo = 0: only consider VV and AA contribution
	% eo = 1: only consider AV and VA contribution
	
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('contract_tensor:: GammaMatrix loaded.\n');
	end

	y = 0;
	for dir = 1:4
		if     op == 'LL' & eo == 1
			tensor_tmp = outer_prod(gamma{dir,1}.', gamma{dir,1}.') +...
				outer_prod((gamma{5,1} * gamma{dir,1}).', (gamma{5,1} * gamma{dir,1}).');
		elseif op == 'LL' & eo == 2
			tensor_tmp = (-1) * outer_prod((gamma{5,1} * gamma{dir,1}).', gamma{dir,1}.') +...
				(-1) * outer_prod(gamma{dir,1}.', (gamma{5,1} * gamma{dir,1}).');
		elseif op == 'LR' & eo == 1
			tensor_tmp = (+1) * outer_prod(gamma{dir,1}.', gamma{dir,1}.') +...
				(-1) * outer_prod((gamma{5,1} * gamma{dir,1}).', (gamma{5,1} * gamma{dir,1}).');
		elseif op == 'LR' & eo == 2
			tensor_tmp = (-1) * outer_prod((gamma{5,1} * gamma{dir,1}).', gamma{dir,1}.') +...
				(+1) * outer_prod(gamma{dir,1}.', (gamma{5,1} * gamma{dir,1}).');
		else 
			fprintf('contract_tensor::either operation %s or even-odd %d not supported.\n',op,eo);
		end
		y = y + sum(sum(spin_tensor.*tensor_tmp));
	end

	clearvars -except y;
end
