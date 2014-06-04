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
		fprintf('GammaMatrix loaded.\n');
	end

	y = 0;
	for dir = 1:4
		if op == 'LL'
			if eo == 1
				tensor_tmp = outer_prod(gamma{dir,1}.', gamma{dir,1}.') +...
					           outer_prod((gamma{5,1} * gamma{dir,1}).', (gamma{5,1} * gamma{dir,1}).');
			elseif eo == 2
				tensor_tmp = (-1) * outer_prod((gamma{5,1} * gamma{dir,1}).', gamma{dir,1}.') +...
					           (-1) * outer_prod(gamma{dir,1}.', (gamma{5,1} * gamma{dir,1}).');
			else 
				fprintf('contract_tensor::%d is neither even nor odd.\n',eo);
			end
		elseif op == 'LR'
			% tensor_tmp = outer_prod(((eye(4) - gamma{5,1}) * gamma{dir,1}).', ...
			%                         ((eye(4) + gamma{5,1}) * gamma{dir,1}).');
			if eo == 1
				tensor_tmp = (+1) * outer_prod(gamma{dir,1}.', gamma{dir,1}.') +...
					           (-1) * outer_prod((gamma{5,1} * gamma{dir,1}).', (gamma{5,1} * gamma{dir,1}).');
			elseif eo == 2
				tensor_tmp = (-1) * outer_prod((gamma{5,1} * gamma{dir,1}).', gamma{dir,1}.') +...
					           (+1) * outer_prod(gamma{dir,1}.', (gamma{5,1} * gamma{dir,1}).');
			else fprintf('contract_tensor::%d is neither even nor odd.\n',eo);
			end
		else 
			fprintf('%s not supported in contarct_tensor\n',op);
		end
		y = y + sum(sum(spin_tensor.*tensor_tmp));
	end

end
