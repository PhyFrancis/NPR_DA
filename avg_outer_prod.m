function tensor = avg_outer_prod(M1, M2) 
	nBlock = size(M1,2) / 12;
	tensor = zeros(144,144);
	for i = 0:nBlock-1
		tensor = tensor + outer_prod(M1(:,12*i+[1:12]),M2(:,12*i+[1:12]));
	end

	tensor = tensor / nBlock;

	clear nBlock;
end
