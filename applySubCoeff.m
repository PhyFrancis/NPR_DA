function S = applySubCoeff(C, subtractionCoeff)

	S = cell(4,6);

	nBlock = size(C{1,1},2) / 144;

	for q = 1:2
		for va = 1:4
			S{va,q} = C{va,q};
		end
	end

	for q = 3:6
		for va = 1:4
			S{va,q} = zeros(size(S{1,1}));
			for conf = 0:(nBlock-1)
				S{va,q}(:,conf*144+[1:144]) = C{va,q}(:,conf*144+[1:144]) + ...
					subtractionCoeff{va,q-2}(1,conf+1) * C{(va>2)+1,7}(:,conf*144+[1:144]) + ...
					subtractionCoeff{va,q-2}(2,conf+1) * (C{(va>2)+1,8}(:,conf*144+[1:144]) - C{(va>2)+1,9}(:,conf*144+[1:144])) + ...
					subtractionCoeff{va,q-2}(3,conf+1) * (C{(va>2)+1,8}(:,conf*144+[1:144]) + C{(va>2)+1,9}(:,conf*144+[1:144]));
			end
		end
	end

	clearvars -except S;
end
