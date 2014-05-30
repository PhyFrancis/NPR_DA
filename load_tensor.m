function tensor = load_tensor(bulk_file,id)
	% load the 144 * 144 tensor form bulk_file,
	% which is the 144 lines in bulk_file, starting from line (id - 1) * 144 + 1
	% id can be 1,2,3,4
	
	if id < 1 || id > 4
		fprintf('Invalid tensor ID %d, can only be 1~4\n', id);
	end
	line_start = (id - 1) * 144 + 1;
	tensor = bulk_file(line_start:(line_start+143),:);
	tensor = toComplex(tensor);
end
