function idx = cIdxMap(AV,aabb)
	off = 0;
	if AV == 'VV'
		off = 1;
	elseif AV == 'AA'
		off = 2;
	elseif AV == 'AV'
		off = 3;
	elseif AV == 'VA'
		off = 4;
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
