function S72 = combineQdotE_sub(C, subtractionCoeff)
	S72 = cell(2,1); % (1,1):even part (2,1):odd part

	nBlock = size(C{1,1},2) / 144;

	for eo = 1:2
		tmp = cell(3,2); % (:,1) are using E1 projection, (:,2) are using E3 projection

		% B1
		tmp{1,1} = (+1) * C{eo,7};

		tmp{1,2} = (+3) * C{eo,7} +...
				 			 (-1) * cnv_ord_4tensors(C{eo,7},'1432') +...
				 			 (-1) * cnv_ord_4tensors(C{eo,7},'3214'); 

		% B2
		tmp{2,1} = (+1) * C{eo,8};

		tmp{2,2} = (+3) * C{eo,8} +...
			  			 (-1) * cnv_ord_4tensors(C{eo,8},'1432') +...
			  			 (-1) * cnv_ord_4tensors(C{eo,8},'3214');

		% B3
		tmp{3,1} = (+1) * C{eo,9};

		tmp{3,2} = (+3) * C{eo,9} +...
							 (-1) * cnv_ord_4tensors(C{eo,9},'1432') +...
							 (-1) * cnv_ord_4tensors(C{eo,9},'3214');

		% summary
		S72{eo,1} = cell(7,2);
		for Q = 1:7
			for E = 1:2
				S72{eo,1}{Q,E} = zeros(144,144*nBlock);
				for conf = 1:nBlock
					S72{eo,1}{Q,E}(:,(conf-1)*144+[1:144]) = tmp{1,E}(:,(conf-1)*144+[1:144]) * subtractionCoeff{Q,eo}(1,conf) +...
						tmp{2,E}(:,(conf-1)*144+[1:144]) * subtractionCoeff{Q,eo}(2,conf) +...
						tmp{3,E}(:,(conf-1)*144+[1:144]) * subtractionCoeff{Q,eo}(3,conf);
				end
			end
		end
	end

	clearvars -except S72;
end
