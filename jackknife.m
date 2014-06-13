function jackknife_ed = jackknife(orig, N)
	% jackknife over columns:
	% jackknife_ed = [avg of orig(:,all except 1:unit), avg of orig(:,all except unit+1:2*unit), ... ]
	% where n * unit is the total column in orig
	
	if rem(size(orig,2),N) ~= 0
		fprintf('Error in jackknife: total column is %d, while number of blocks is %d\n', size(orig,2), N);
	end
	if N <= 1
		fprintf('Error in jackknife: Number of blocks is too small (%d)\n', N);
	end

	blockCol = size(orig,2) / N;
	jackknife_ed = zeros(size(orig));
	sum_ed = zeros(size(orig,1),blockCol);

	for i = 1:N
		sum_ed = sum_ed + orig(:,1+(i-1)*blockCol:i*blockCol);
	end

	for i = 1:N
		% avg_ed = avg_ed + orig(:,1+(i-1)*blockCol:i*blockCol);
		jackknife_ed(:,1+(i-1)*blockCol:i*blockCol) = (sum_ed - orig(:,1+(i-1)*blockCol:i*blockCol)) / (N-1);
	end

	clearvars -except jackknife_ed;
end
