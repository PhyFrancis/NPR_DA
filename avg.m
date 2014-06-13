function avg_ed = avg(orig, N)
	% average over columns:
	% avg_ed = [orig(:,1:unit) + orig(:,unit+1:2*unit) + ... ] / n
	% where n * unit is the total column in orig
	
	if rem(size(orig,2),N) ~= 0
		fprintf('Error in avg_ed: total column is %d, while number of blocks is %d\n', size(orig,2), N);
	end

	blockCol = size(orig,2) / N;
	avg_ed = zeros(size(orig,1),blockCol);

	for i = 1:N
		avg_ed = avg_ed + orig(:,1+(i-1)*blockCol:i*blockCol);
	end

	avg_ed = avg_ed / N;

end
