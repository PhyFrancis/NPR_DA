function jackknifed_Q_sub = combine_sub(jackknifed_C_sub); 
	% combine C3~C6 to form Q1"~Q10"
	% minus 2 in jackknifed_C_sub index is because jackknifed_C_sub doesn't contain C1 and C2
	
	tmp = cell(10,2); % {even, odd} Q1
	                  % {even, odd} Q2
	                  %  ... ... ...
	                  % {even, odd} Q10
																 
	% Q1
	q = 1;
	tmp{q,1} = (-1) * jackknifed_C_sub{cIdxMap('VV'),3-2} +...
				     (-1) * jackknifed_C_sub{cIdxMap('AA'),3-2} ;

  tmp{q,2} = (+1) * jackknifed_C_sub{cIdxMap('AV'),3-2} +...
						 (+1) * jackknifed_C_sub{cIdxMap('VA'),3-2} ;
  % Q2
	q = 2;
  tmp{q,1} = (-1) * jackknifed_C_sub{cIdxMap('VV'),4-2} +...
				     (-1) * jackknifed_C_sub{cIdxMap('AA'),4-2} ;

  tmp{q,2} = (+1) * jackknifed_C_sub{cIdxMap('AV'),4-2} +...
						 (+1) * jackknifed_C_sub{cIdxMap('VA'),4-2} ;

  % Q3
	q = 3;
  tmp{q,1} = (-3) * jackknifed_C_sub{cIdxMap('VV'),3-2} +...
						 (-3) * jackknifed_C_sub{cIdxMap('AA'),3-2} +...
             (+2) * jackknifed_C_sub{cIdxMap('VV'),5-2} +...
						 (+2) * jackknifed_C_sub{cIdxMap('AA'),5-2} ;

  tmp{q,2} = (+3) * jackknifed_C_sub{cIdxMap('AV'),3-2} +...
						 (+3) * jackknifed_C_sub{cIdxMap('VA'),3-2} +...
             (-2) * jackknifed_C_sub{cIdxMap('AV'),5-2} +...
						 (-2) * jackknifed_C_sub{cIdxMap('VA'),5-2} ;
	
  % Q5
	q = 5;
  tmp{q,1} = (-3) * jackknifed_C_sub{cIdxMap('VV'),3-2} +...
						 (+3) * jackknifed_C_sub{cIdxMap('AA'),3-2} +...
             (+2) * jackknifed_C_sub{cIdxMap('VV'),5-2} +...
						 (-2) * jackknifed_C_sub{cIdxMap('AA'),5-2} ;

  tmp{q,2} = (+3) * jackknifed_C_sub{cIdxMap('AV'),3-2} +...
						 (-3) * jackknifed_C_sub{cIdxMap('VA'),3-2} ;

  % Q6
	q = 6;
  tmp{q,1} = (-3) * jackknifed_C_sub{cIdxMap('VV'),4-2} +...
					   (+3) * jackknifed_C_sub{cIdxMap('AA'),4-2} +...
             (+2) * jackknifed_C_sub{cIdxMap('VV'),6-2} +...
						 (-2) * jackknifed_C_sub{cIdxMap('AA'),6-2} ;

  tmp{q,2} = (+3) * jackknifed_C_sub{cIdxMap('AV'),4-2} +...
						 (-3) * jackknifed_C_sub{cIdxMap('VA'),4-2} ;

  % Q7
	q = 7;
  tmp{q,1} = (-1) * jackknifed_C_sub{cIdxMap('VV'),5-2} +...
						 (+1) * jackknifed_C_sub{cIdxMap('AA'),5-2} ;

  tmp{q,2} = zeros(size(tmp{q,1}));

  % Q8
	q = 8;
  tmp{q,1} = (-1) * jackknifed_C_sub{cIdxMap('VV'),6-2} +...
						 (+1) * jackknifed_C_sub{cIdxMap('AA'),6-2} ;

  tmp{q,2} = zeros(size(tmp{q,1}));

	% summary
	jackknifed_Q_sub = cell(7,2);
	for eo = 1:2
		jackknifed_Q_sub{1,eo} =                 3 * tmp{1,eo} + 2 * tmp{2,eo} - tmp{3,eo};
		jackknifed_Q_sub{2,eo} = (1.0 / 5.0) * ( 2 * tmp{1,eo} - 2 * tmp{2,eo} + tmp{3,eo});
		jackknifed_Q_sub{3,eo} = (1.0 / 5.0) * (-3 * tmp{1,eo} + 3 * tmp{2,eo} + tmp{3,eo});
		jackknifed_Q_sub{4,eo} = tmp{5,eo};
		jackknifed_Q_sub{5,eo} = tmp{6,eo};
		jackknifed_Q_sub{6,eo} = tmp{7,eo};
		jackknifed_Q_sub{7,eo} = tmp{8,eo};
	end

	clearvars -except jackknifed_Q_sub;
end
