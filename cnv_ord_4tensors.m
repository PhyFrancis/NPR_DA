function cnv_tensors = cnv_ord_4tensors(tensors, origOrd)
	% convert the indices' order from origOrd to '1234'

	nBlock = size(tensors,2) / 144;

	cnv_tensors = [];
	for i = 0:nBlock-1
		cnv_tensors = [cnv_tensors, cnv_ord_4tensor(tensors(:,i*144+[1:144]),origOrd)];
	end

	clearvars -except cnv_tensors;
end
