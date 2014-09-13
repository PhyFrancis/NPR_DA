function matrix = load_matrix_sub(sub_bulk_file,id)
	% load the 12 * 12 matrix form sub_bulk_file,
	% which is the 12 lines in sub_bulk_file, starting from line (id - 1) * 12
	% id can be 1~11
	
	if id < 1 || id > 11
		fprintf('load_matrix_sub::Invalid matrix ID %d, can only be 1~11\n', id);
	end
	line_start = (id - 1) * 12 + 1;
	nBlock = size(sub_bulk_file,2) / 24;
	col = [];
	for i = 0:nBlock-1
		col = [col, i * 24 + [1:24]];
	end
	matrix = sub_bulk_file(line_start:(line_start+11),col);
	matrix = toComplex(matrix);

	clearvars -except matrix;
end
