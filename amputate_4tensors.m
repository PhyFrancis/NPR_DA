function tensors_amp = amputate_4tensors(tensors, legs_p1, legs_p2)
	%amputate array of 4-index tensors

	if rem(size(tensors,2),144) ~= 0
		fprintf('amputate_4tensors::Total column is %d, not a multiple of 144!\n', size(tensors,2));
	end

	nBlock = size(tensors,2) / 144;
	tensors_amp = zeros(size(tensors));
	for i = 0:nBlock-1
		tensors_amp(:,i*144+[1:144]) = amputate_4tensor(tensors(:,i*144+[1:144]),legs_p1(:,i*12+[1:12]),legs_p2(:,i*12+[1:12]));
	end

	clear nBlock;
	clear i;
end
