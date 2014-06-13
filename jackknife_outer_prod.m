function tensors = jackknife_outer_prod(M1, M2) 
	nBlock = size(M1,2) / 12;
	tensors = [];
	for i = 0:nBlock-1
		tensors = [tensors, outer_prod(M1(:,12*i+[1:12]),M2(:,12*i+[1:12]))];
	end
	tensors = jackknife(tensors,nBlock);

	clearvars -except tensors;
end
