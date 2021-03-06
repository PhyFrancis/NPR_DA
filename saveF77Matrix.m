% This file generates the 7-by-7 tree level F matrix and save to the file fn

fn = 'F77Matrix';
F77 = zeros(7,7);

% F 7-by-7
F77 = [ 3072, 3072, 0, 0, 0, 0, 0 ;
        537.6, -230.4, 1152, 0, 0, 0, 0;
				-230.4, 537.6, 384, 0, 0, 0, 0;
				0, 0, 0, 1152, 384, 3456, 1152;
				0, 0, 0, 384, 1152, 1152, 3456;
				0, 0, 0, 1152, 384, 0, 0;
				0, 0, 0, 384, 1152, 0, 0; ]
							 
save(fn,'F77');
