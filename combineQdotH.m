function M77 = combineQdotH(M72)
	nBlock = size(M72{1,1}{1,1},2) / 144;

	M77 = cell(nBlock,2);

	for i = 1:nBlock
		for eo = 1:2 % 1:even 2:odd
			M77{i,eo} = zeros(7,7);
			for Q = 1:7
				M77{i,eo}(Q,1) = contract_tensor(contract_color    (M72{eo,1}{Q,1}(:,(i-1)*144+[1:144])),'LL', eo);
				M77{i,eo}(Q,2) = contract_tensor(contract_color_mix(M72{eo,1}{Q,1}(:,(i-1)*144+[1:144])),'LL', eo);
				M77{i,eo}(Q,3) = contract_tensor(contract_color    (M72{eo,1}{Q,2}(:,(i-1)*144+[1:144])),'LL', eo);
				M77{i,eo}(Q,4) = contract_tensor(contract_color    (M72{eo,1}{Q,1}(:,(i-1)*144+[1:144])),'LR', eo);
				M77{i,eo}(Q,5) = contract_tensor(contract_color_mix(M72{eo,1}{Q,1}(:,(i-1)*144+[1:144])),'LR', eo);
				M77{i,eo}(Q,6) = contract_tensor(contract_color    (M72{eo,1}{Q,2}(:,(i-1)*144+[1:144])),'LR', eo);
				M77{i,eo}(Q,7) = contract_tensor(contract_color_mix(M72{eo,1}{Q,2}(:,(i-1)*144+[1:144])),'LR', eo);
			end
		end
	end

	clearvars -except M77;
end
