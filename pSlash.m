function y = pSlash(p)
	y = zeros(4,4);
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('pSlash::GammaMatrix loaded.\n');
	end

	for dir = 1:4
		y = y + p(dir) * gamma{dir,1};
	end

	clearvars -except y;
end
