function idx = cIdxMap(AV)
	if AV == 'VV'
		idx = 1;
	elseif AV == 'AA'
		idx = 2;
	elseif AV == 'AV'
		idx = 3;
	elseif AV == 'VA'
		idx = 4;
	else 
		fprintf('%s not supported, should be VV, AA, AV, or VA\n', AV);
	end

end

% C is organised as cell(4,6): 
% [VV,AA,AV,VA] for C1 
%  ... ... ...  for C2 
%  ... ... ...  for C3 
%  ... ... ...  for C4 
%  ... ... ...  for C5 
%  ... ... ...  for C6 
