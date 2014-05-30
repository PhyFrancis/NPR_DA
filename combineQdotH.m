function M77 = combineQdotH(M72)
	M77 = cell(2,1);

	for eo = 1:2 % 1:even 2:odd
		M77{eo,1} = zeros(7,7);
		for Q = 1:7
			M77{eo,1}(Q,1) = contract_tensor(contract_color    (M72{eo,1}{Q,1}),'LL');
			M77{eo,1}(Q,2) = contract_tensor(contract_color_mix(M72{eo,1}{Q,1}),'LL');
			M77{eo,1}(Q,3) = contract_tensor(contract_color    (M72{eo,1}{Q,2}),'LL');
			M77{eo,1}(Q,4) = contract_tensor(contract_color    (M72{eo,1}{Q,1}),'LR');
			M77{eo,1}(Q,5) = contract_tensor(contract_color_mix(M72{eo,1}{Q,1}),'LR');
			M77{eo,1}(Q,6) = contract_tensor(contract_color    (M72{eo,1}{Q,2}),'LR');
			M77{eo,1}(Q,7) = contract_tensor(contract_color_mix(M72{eo,1}{Q,2}),'LR');
		end
	end

end
