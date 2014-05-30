function matrix = load_matrix(bulk_file,id)
	% load the 12 * 12 matrix form bulk_file,
	% which is the 12 lines in bulk_file, starting from line (id - 1) * 12 + 577
	% id can be 1~12
	
	if id < 1 || id > 12
		fprintf('Invalid matrix ID %d, can only be 1~12\n', id);
	end
	line_start = (id - 1) * 12 + 577;
	matrix = bulk_file(line_start:(line_start+11),1:24);
	matrix = toComplex(matrix);
end
