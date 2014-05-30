function M72 = combineQdotE(C)
	M72 = cell(2,1); % (1,1):even part (2,1):odd part

	% 1. even part:
	tmp = cell(10,2); % (:,1) are using E1 projection, (:,2) are using E3 projection
	for Q = 1:10
		for E = 1:2
			tmp{Q,E} = zeros(144,144);
		end
	end

% 	% 1.1 even Q1
% 	tmp{1,1} = (+1) * C{cIdxMap('VV'),1} +...
% 		         (+1) * C{cIdxMap('AA'),1} +...
% 		         (-1) * C{cIdxMap('VV'),3} +...
% 		         (-1) * C{cIdxMap('AA'),3} ;
% 
% 	tmp{1,2} = (+1) * C{cIdxMap('VV'),1} +...
% 		         (+1) * C{cIdxMap('AA'),1} +...
% 		         (-3) * C{cIdxMap('VV'),3} +...
% 		         (-3) * C{cIdxMap('AA'),3} +...
% 		         (-2) * C{cIdxMap('VV'),3} +...
% 		         (-2) * C{cIdxMap('AA'),3} ;

% 	% 1.2 even Q2
% 	tmp_10_4{2,1} = (+1) * C{cIdxMap('VV','aabb'),2} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),2} +...
% 		              (-1) * C{cIdxMap('VV','aabb'),4} +...
% 		              (-1) * C{cIdxMap('AA','aabb'),4} ;
% 
% 	tmp_10_4{2,2} = (+1) * C{cIdxMap('VV','abba'),2} +...
% 		              (+1) * C{cIdxMap('AA','abba'),2} +...
% 		              (-1) * C{cIdxMap('VV','abba'),4} +...
% 		              (-1) * C{cIdxMap('AA','abba'),4} ;
% 
% 	tmp_10_4{2,3} = (+1) * C{cIdxMap('VV','aabb'),2} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),2} +...
% 		              (-3) * C{cIdxMap('VV','aabb'),4} +...
% 		              (-3) * C{cIdxMap('AA','aabb'),4} +...
% 		              (-2) * C{cIdxMap('VV','abba'),4} +...
% 		              (-2) * C{cIdxMap('AA','abba'),4} ;
% 
% 	tmp_10_4{2,4} = (+1) * C{cIdxMap('VV','abba'),2} +...
% 		              (+1) * C{cIdxMap('AA','abba'),2} +...
% 		              (-3) * C{cIdxMap('VV','abba'),4} +...
% 		              (-3) * C{cIdxMap('AA','abba'),4} +...
% 		              (-2) * C{cIdxMap('VV','aabb'),4} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),4} ;
% 
% 	% 1.3 even Q3
% 	tmp_10_4{3,1} = (+1) * C{cIdxMap('VV','aabb'),1} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-3) * C{cIdxMap('VV','aabb'),3} +...
% 		              (-3) * C{cIdxMap('AA','aabb'),3} +...
% 		              (+2) * C{cIdxMap('VV','aabb'),5} +...
% 		              (+2) * C{cIdxMap('AA','aabb'),5} ;
% 
% 	tmp_10_4{3,2} = (+1) * C{cIdxMap('VV','abba'),1} +...
% 		              (+1) * C{cIdxMap('AA','abba'),1} +...
% 		              (-3) * C{cIdxMap('VV','abba'),3} +...
% 		              (-3) * C{cIdxMap('AA','abba'),3} +...
% 		              (+2) * C{cIdxMap('VV','abba'),5} +...
% 		              (+2) * C{cIdxMap('AA','abba'),5} ;
% 
% 	tmp_10_4{3,3} = (+3) * C{cIdxMap('VV','aabb'),1} +...
% 		              (+3) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-9) * C{cIdxMap('VV','aabb'),3} +...
% 		              (-9) * C{cIdxMap('AA','aabb'),3} +...
% 		              (+6) * C{cIdxMap('VV','aabb'),5} +...
% 		              (+6) * C{cIdxMap('AA','aabb'),5} +...
% 	                (+2) * C{cIdxMap('VV','abba'),1} +...
% 		              (+2) * C{cIdxMap('AA','abba'),1} +...
% 		              (-6) * C{cIdxMap('VV','abba'),3} +...
% 		              (-6) * C{cIdxMap('AA','abba'),3} +...
% 		              (+6) * C{cIdxMap('VV','abba'),5} +...
% 		              (+6) * C{cIdxMap('AA','abba'),5} ;
% 
% 	tmp_10_4{3,4} = (+3) * C{cIdxMap('VV','abba'),1} +...
% 		              (+3) * C{cIdxMap('AA','abba'),1} +...
% 		              (-9) * C{cIdxMap('VV','abba'),3} +...
% 		              (-9) * C{cIdxMap('AA','abba'),3} +...
% 		              (+6) * C{cIdxMap('VV','abba'),5} +...
% 		              (+6) * C{cIdxMap('AA','abba'),5} +...
% 	                (+2) * C{cIdxMap('VV','aabb'),1} +...
% 		              (+2) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-6) * C{cIdxMap('VV','aabb'),3} +...
% 		              (-6) * C{cIdxMap('AA','aabb'),3} +...
% 		              (+6) * C{cIdxMap('VV','aabb'),5} +...
% 		              (+6) * C{cIdxMap('AA','aabb'),5} ;
% 
% 	% 1.4 even Q5
% 	tmp_10_4{5,1} = (+1) * C{cIdxMap('VV','aabb'),1} +...
% 		              (-1) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-3) * C{cIdxMap('VV','aabb'),3} +...
% 		              (+3) * C{cIdxMap('AA','aabb'),3} +...
% 		              (+2) * C{cIdxMap('VV','aabb'),5} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),5} ;
% 
% 	tmp_10_4{5,2} = (+1) * C{cIdxMap('VV','abba'),1} +...
% 		              (-1) * C{cIdxMap('AA','abba'),1} +...
% 		              (-3) * C{cIdxMap('VV','abba'),3} +...
% 		              (+3) * C{cIdxMap('AA','abba'),3} +...
% 		              (+2) * C{cIdxMap('VV','abba'),5} +...
% 		              (-2) * C{cIdxMap('AA','abba'),5} ;
% 
% 	tmp_10_4{5,3} = (+3) * C{cIdxMap('VV','aabb'),1} +...
% 		              (-3) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-9) * C{cIdxMap('VV','aabb'),3} +...
% 		              (+9) * C{cIdxMap('AA','aabb'),3} +...
% 		              (+6) * C{cIdxMap('VV','aabb'),5} +...
% 		              (-6) * C{cIdxMap('AA','aabb'),5} +...
% 	                (+2) * C{cIdxMap('VV','abba'),1} +...
% 		              (-2) * C{cIdxMap('AA','abba'),1} +...
% 		              (-6) * C{cIdxMap('VV','abba'),3} +...
% 		              (+6) * C{cIdxMap('AA','abba'),3} +...
% 		              (+2) * C{cIdxMap('VV','abba'),5} +...
% 		              (-2) * C{cIdxMap('AA','abba'),5} ;
% 
% 	tmp_10_4{5,4} = (+3) * C{cIdxMap('VV','abba'),1} +...
% 		              (-3) * C{cIdxMap('AA','abba'),1} +...
% 		              (-9) * C{cIdxMap('VV','abba'),3} +...
% 		              (+9) * C{cIdxMap('AA','abba'),3} +...
% 		              (+6) * C{cIdxMap('VV','abba'),5} +...
% 		              (-6) * C{cIdxMap('AA','abba'),5} +...
% 	                (+2) * C{cIdxMap('VV','aabb'),1} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-6) * C{cIdxMap('VV','aabb'),3} +...
% 		              (+6) * C{cIdxMap('AA','aabb'),3} +...
% 		              (+2) * C{cIdxMap('VV','aabb'),5} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),5} ;
% 
% 	% 1.5 even Q6
% 	tmp_10_4{6,1} = (+1) * C{cIdxMap('VV','aabb'),2} +...
% 		              (-1) * C{cIdxMap('AA','aabb'),2} +...
% 		              (-3) * C{cIdxMap('VV','aabb'),4} +...
% 		              (+3) * C{cIdxMap('AA','aabb'),4} +...
% 		              (+2) * C{cIdxMap('VV','aabb'),6} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),6} ;
% 
% 	tmp_10_4{6,2} = (+1) * C{cIdxMap('VV','abba'),2} +...
% 		              (-1) * C{cIdxMap('AA','abba'),2} +...
% 		              (-3) * C{cIdxMap('VV','abba'),4} +...
% 		              (+3) * C{cIdxMap('AA','abba'),4} +...
% 		              (+2) * C{cIdxMap('VV','abba'),6} +...
% 		              (-2) * C{cIdxMap('AA','abba'),6} ;
% 
% 	tmp_10_4{6,3} = (+3) * C{cIdxMap('VV','aabb'),2} +...
% 		              (-3) * C{cIdxMap('AA','aabb'),2} +...
% 		              (-9) * C{cIdxMap('VV','aabb'),4} +...
% 		              (+9) * C{cIdxMap('AA','aabb'),4} +...
% 		              (+6) * C{cIdxMap('VV','aabb'),6} +...
% 		              (-6) * C{cIdxMap('AA','aabb'),6} +...
% 	                (+2) * C{cIdxMap('VV','abba'),2} +...
% 		              (-2) * C{cIdxMap('AA','abba'),2} +...
% 		              (-6) * C{cIdxMap('VV','abba'),4} +...
% 		              (+6) * C{cIdxMap('AA','abba'),4} +...
% 		              (+2) * C{cIdxMap('VV','abba'),6} +...
% 		              (-2) * C{cIdxMap('AA','abba'),6} ;
% 
% 	tmp_10_4{6,4} = (+3) * C{cIdxMap('VV','abba'),2} +...
% 		              (-3) * C{cIdxMap('AA','abba'),2} +...
% 		              (-9) * C{cIdxMap('VV','abba'),4} +...
% 		              (+9) * C{cIdxMap('AA','abba'),4} +...
% 		              (+6) * C{cIdxMap('VV','abba'),6} +...
% 		              (-6) * C{cIdxMap('AA','abba'),6} +...
% 	                (+2) * C{cIdxMap('VV','aabb'),2} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),2} +...
% 		              (-6) * C{cIdxMap('VV','aabb'),4} +...
% 		              (+6) * C{cIdxMap('AA','aabb'),4} +...
% 		              (+2) * C{cIdxMap('VV','aabb'),6} +...
% 		              (-2) * C{cIdxMap('AA','aabb'),6} ;
% 
% 	% 1.6 even Q7
% 	tmp_10_4{7,1} = (+1) * C{cIdxMap('VV','aabb'),1} +...
% 		              (-1) * C{cIdxMap('AA','aabb'),1} +...
% 		              (-1) * C{cIdxMap('VV','aabb'),5} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),5} ;
% 
% 	tmp_10_4{7,2} = (+1) * C{cIdxMap('VV','abba'),1} +...
% 		              (-1) * C{cIdxMap('AA','abba'),1} +...
% 		              (-1) * C{cIdxMap('VV','abba'),5} +...
% 		              (+1) * C{cIdxMap('AA','abba'),5} ;
% 
% 	tmp_10_4{7,3} = (-3) * C{cIdxMap('VV','aabb'),5} +...
% 		              (+3) * C{cIdxMap('AA','aabb'),5} +...
% 		              (-1) * C{cIdxMap('VV','abba'),5} +...
% 		              (+1) * C{cIdxMap('AA','abba'),5} ;
% 
% 	tmp_10_4{7,4} = (-3) * C{cIdxMap('VV','abba'),5} +...
% 		              (+3) * C{cIdxMap('AA','abba'),5} +...
% 		              (-1) * C{cIdxMap('VV','aabb'),5} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),5} ;
% 
% 	% 1.7 even Q8
% 	tmp_10_4{8,1} = (+1) * C{cIdxMap('VV','aabb'),2} +...
% 		              (-1) * C{cIdxMap('AA','aabb'),2} +...
% 		              (-1) * C{cIdxMap('VV','aabb'),6} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),6} ;
% 
% 	tmp_10_4{8,2} = (+1) * C{cIdxMap('VV','abba'),2} +...
% 		              (-1) * C{cIdxMap('AA','abba'),2} +...
% 		              (-1) * C{cIdxMap('VV','abba'),6} +...
% 		              (+1) * C{cIdxMap('AA','abba'),6} ;
% 
% 	tmp_10_4{8,3} = (-3) * C{cIdxMap('VV','aabb'),6} +...
% 		              (+3) * C{cIdxMap('AA','aabb'),6} +...
% 		              (-1) * C{cIdxMap('VV','abba'),6} +...
% 		              (+1) * C{cIdxMap('AA','abba'),6} ;
% 
% 	tmp_10_4{8,4} = (-3) * C{cIdxMap('VV','abba'),6} +...
% 		              (+3) * C{cIdxMap('AA','abba'),6} +...
% 		              (-1) * C{cIdxMap('VV','aabb'),6} +...
% 		              (+1) * C{cIdxMap('AA','aabb'),6} ;

	% 1.8 even part summary
	M72{1,1} = cell(7,2);
	for E = 1:2
		M72{1,1}{1,E} =                 3 * tmp{1,E} + 2 * tmp{2,E} - tmp{3,E};
		M72{1,1}{2,E} = (1.0 / 5.0) * ( 2 * tmp{1,E} - 2 * tmp{2,E} + tmp{3,E});
		M72{1,1}{3,E} = (1.0 / 5.0) * (-3 * tmp{1,E} + 3 * tmp{2,E} + tmp{3,E});
		M72{1,1}{4,E} = tmp{5,E};
		M72{1,1}{5,E} = tmp{6,E};
		M72{1,1}{6,E} = tmp{7,E};
		M72{1,1}{7,E} = tmp{8,E};
	end

	% 2. odd part:
	tmp = cell(10,2); % (:,1) are using E1 projection, (:,2) are using E3 projection
	for Q = 1:10
		for E = 1:2
			tmp{Q,E} = zeros(144,144);
		end
	end

% 	% 2.1 odd Q1
% 	tmp_10_4{1,1} = (-1) * C{cIdxMap('AV','aabb'),1} +...
% 		              (-1) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+1) * C{cIdxMap('AV','aabb'),3} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),3} ;
% 
% 	tmp_10_4{1,2} = (-1) * C{cIdxMap('AV','abba'),1} +...
% 		              (-1) * C{cIdxMap('VA','abba'),1} +...
% 		              (+1) * C{cIdxMap('AV','abba'),3} +...
% 		              (+1) * C{cIdxMap('VA','abba'),3} ;
% 
% 	tmp_10_4{1,3} = (+1) * C{cIdxMap('AV','aabb'),1} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+3) * C{cIdxMap('AV','aabb'),3} +...
% 		              (+3) * C{cIdxMap('VA','aabb'),3} +...
% 		              (+2) * C{cIdxMap('AV','abba'),3} +...
% 		              (+2) * C{cIdxMap('VA','abba'),3} ;
% 
% 	tmp_10_4{1,4} = (-1) * C{cIdxMap('AV','abba'),1} +...
% 		              (-1) * C{cIdxMap('VA','abba'),1} +...
% 		              (+3) * C{cIdxMap('AV','abba'),3} +...
% 		              (+3) * C{cIdxMap('VA','abba'),3} +...
% 		              (+2) * C{cIdxMap('AV','aabb'),3} +...
% 		              (+2) * C{cIdxMap('VA','aabb'),3} ;
% 
% 	% 1.2 odd Q2
% 	tmp_10_4{2,1} = (-1) * C{cIdxMap('AV','aabb'),2} +...
% 		              (-1) * C{cIdxMap('VA','aabb'),2} +...
% 		              (+1) * C{cIdxMap('AV','aabb'),4} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),4} ;
% 
% 	tmp_10_4{2,2} = (-1) * C{cIdxMap('AV','abba'),2} +...
% 		              (-1) * C{cIdxMap('VA','abba'),2} +...
% 		              (+1) * C{cIdxMap('AV','abba'),4} +...
% 		              (+1) * C{cIdxMap('VA','abba'),4} ;
% 
% 	tmp_10_4{2,3} = (-1) * C{cIdxMap('AV','aabb'),2} +...
% 		              (-1) * C{cIdxMap('VA','aabb'),2} +...
% 		              (+3) * C{cIdxMap('AV','aabb'),4} +...
% 		              (+3) * C{cIdxMap('VA','aabb'),4} +...
% 		              (+2) * C{cIdxMap('AV','abba'),4} +...
% 		              (+2) * C{cIdxMap('VA','abba'),4} ;
% 
% 	tmp_10_4{2,4} = (-1) * C{cIdxMap('AV','abba'),2} +...
% 		              (-1) * C{cIdxMap('VA','abba'),2} +...
% 		              (+3) * C{cIdxMap('AV','abba'),4} +...
% 		              (+3) * C{cIdxMap('VA','abba'),4} +...
% 		              (+2) * C{cIdxMap('AV','aabb'),4} +...
% 		              (+2) * C{cIdxMap('VA','aabb'),4} ;
% 
% 	% 1.3 odd Q3
% 	tmp_10_4{3,1} = (-1) * C{cIdxMap('AV','aabb'),1} +...
% 		              (-1) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+3) * C{cIdxMap('AV','aabb'),3} +...
% 		              (+3) * C{cIdxMap('VA','aabb'),3} +...
% 		              (-2) * C{cIdxMap('AV','aabb'),5} +...
% 		              (-2) * C{cIdxMap('VA','aabb'),5} ;
% 
% 	tmp_10_4{3,2} = (-1) * C{cIdxMap('AV','abba'),1} +...
% 		              (-1) * C{cIdxMap('VA','abba'),1} +...
% 		              (+3) * C{cIdxMap('AV','abba'),3} +...
% 		              (+3) * C{cIdxMap('VA','abba'),3} +...
% 		              (-2) * C{cIdxMap('AV','abba'),5} +...
% 		              (-2) * C{cIdxMap('VA','abba'),5} ;
% 
% 	tmp_10_4{3,3} = (-3) * C{cIdxMap('AV','aabb'),1} +...
% 		              (-3) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+9) * C{cIdxMap('AV','aabb'),3} +...
% 		              (+9) * C{cIdxMap('VA','aabb'),3} +...
% 		              (-6) * C{cIdxMap('AV','aabb'),5} +...
% 		              (-6) * C{cIdxMap('VA','aabb'),5} +...
% 	                (-2) * C{cIdxMap('AV','abba'),1} +...
% 		              (-2) * C{cIdxMap('VA','abba'),1} +...
% 		              (+6) * C{cIdxMap('AV','abba'),3} +...
% 		              (+6) * C{cIdxMap('VA','abba'),3} +...
% 		              (-6) * C{cIdxMap('AV','abba'),5} +...
% 		              (-6) * C{cIdxMap('VA','abba'),5} ;
% 
% 	tmp_10_4{3,4} = (-3) * C{cIdxMap('AV','abba'),1} +...
% 		              (-3) * C{cIdxMap('VA','abba'),1} +...
% 		              (+9) * C{cIdxMap('AV','abba'),3} +...
% 		              (+9) * C{cIdxMap('VA','abba'),3} +...
% 		              (-6) * C{cIdxMap('AV','abba'),5} +...
% 		              (-6) * C{cIdxMap('VA','abba'),5} +...
% 	                (-2) * C{cIdxMap('AV','aabb'),1} +...
% 		              (-2) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+6) * C{cIdxMap('AV','aabb'),3} +...
% 		              (+6) * C{cIdxMap('VA','aabb'),3} +...
% 		              (-6) * C{cIdxMap('AV','aabb'),5} +...
% 		              (-6) * C{cIdxMap('VA','aabb'),5} ;
% 
% 	% 1.4 odd Q5
% 	tmp_10_4{5,1} = (-1) * C{cIdxMap('AV','aabb'),1} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+3) * C{cIdxMap('AV','aabb'),3} +...
% 		              (-3) * C{cIdxMap('VA','aabb'),3} ;
% 
% 	tmp_10_4{5,2} = (-1) * C{cIdxMap('AV','abba'),1} +...
% 		              (+1) * C{cIdxMap('VA','abba'),1} +...
% 		              (+3) * C{cIdxMap('AV','abba'),3} +...
% 		              (-3) * C{cIdxMap('VA','abba'),3} ;
% 
% 	tmp_10_4{5,3} = (-3) * C{cIdxMap('AV','aabb'),1} +...
% 		              (+3) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+9) * C{cIdxMap('AV','aabb'),3} +...
% 		              (-9) * C{cIdxMap('VA','aabb'),3} +...
% 	                (-2) * C{cIdxMap('AV','abba'),1} +...
% 		              (+2) * C{cIdxMap('VA','abba'),1} +...
% 		              (+6) * C{cIdxMap('AV','abba'),3} +...
% 		              (-6) * C{cIdxMap('VA','abba'),3} ;
% 
% 	tmp_10_4{5,4} = (-3) * C{cIdxMap('AV','abba'),1} +...
% 		              (+3) * C{cIdxMap('VA','abba'),1} +...
% 		              (+9) * C{cIdxMap('AV','abba'),3} +...
% 		              (-9) * C{cIdxMap('VA','abba'),3} +...
% 	                (-2) * C{cIdxMap('AV','aabb'),1} +...
% 		              (+2) * C{cIdxMap('VA','aabb'),1} +...
% 		              (+6) * C{cIdxMap('AV','aabb'),3} +...
% 		              (-6) * C{cIdxMap('VA','aabb'),3} ;
% 
% 	% 1.5 even Q6
% 	tmp_10_4{6,1} = (-1) * C{cIdxMap('AV','aabb'),2} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),2} +...
% 		              (+3) * C{cIdxMap('AV','aabb'),4} +...
% 		              (-3) * C{cIdxMap('VA','aabb'),4} ;
% 
% 	tmp_10_4{6,2} = (-1) * C{cIdxMap('AV','abba'),2} +...
% 		              (+1) * C{cIdxMap('VA','abba'),2} +...
% 		              (+3) * C{cIdxMap('AV','abba'),4} +...
% 		              (-3) * C{cIdxMap('VA','abba'),4} ;
% 
% 	tmp_10_4{6,3} = (-3) * C{cIdxMap('AV','aabb'),2} +...
% 		              (+3) * C{cIdxMap('VA','aabb'),2} +...
% 		              (+9) * C{cIdxMap('AV','aabb'),4} +...
% 		              (-9) * C{cIdxMap('VA','aabb'),4} +...
% 	                (-2) * C{cIdxMap('AV','abba'),2} +...
% 		              (+2) * C{cIdxMap('VA','abba'),2} +...
% 		              (+6) * C{cIdxMap('AV','abba'),4} +...
% 		              (-6) * C{cIdxMap('VA','abba'),4} ;
% 
% 	tmp_10_4{6,4} = (-3) * C{cIdxMap('AV','abba'),2} +...
% 		              (+3) * C{cIdxMap('VA','abba'),2} +...
% 		              (+9) * C{cIdxMap('AV','abba'),4} +...
% 		              (-9) * C{cIdxMap('VA','abba'),4} +...
% 	                (-2) * C{cIdxMap('AV','aabb'),2} +...
% 		              (+2) * C{cIdxMap('VA','aabb'),2} +...
% 		              (+6) * C{cIdxMap('AV','aabb'),4} +...
% 		              (-6) * C{cIdxMap('VA','aabb'),4} ;
% 
% 	% 1.6 odd Q7
% 	tmp_10_4{7,1} = (-1) * C{cIdxMap('AV','aabb'),1} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),1} ;
% 
% 	tmp_10_4{7,2} = (-1) * C{cIdxMap('AV','abba'),1} +...
% 		              (+1) * C{cIdxMap('VA','abba'),1} ;
% 
% 	tmp_10_4{7,3} = zeros(16,16);
% 		              
% 	tmp_10_4{7,4} = zeros(16,16);
% 
% 	% 1.7 odd Q8
% 	tmp_10_4{8,1} = (-1) * C{cIdxMap('AV','aabb'),2} +...
% 		              (+1) * C{cIdxMap('VA','aabb'),2} ;
% 
% 	tmp_10_4{8,2} = (-1) * C{cIdxMap('AV','abba'),2} +...
% 		              (+1) * C{cIdxMap('VA','abba'),2} ;
% 
% 	tmp_10_4{8,3} = zeros(16,16);
% 		              
% 	tmp_10_4{8,4} = zeros(16,16);

	% 1.8 odd part summary
	M72{2,1} = cell(7,2);
	for E = 1:2
		M72{2,1}{1,E} =                 3 * tmp{1,E} + 2 * tmp{2,E} - tmp{3,E};
		M72{2,1}{2,E} = (1.0 / 5.0) * ( 2 * tmp{1,E} - 2 * tmp{2,E} + tmp{3,E});
		M72{2,1}{3,E} = (1.0 / 5.0) * (-3 * tmp{1,E} + 3 * tmp{2,E} + tmp{3,E});
		M72{2,1}{4,E} = tmp{5,E};
		M72{2,1}{5,E} = tmp{6,E};
		M72{2,1}{6,E} = tmp{7,E};
		M72{2,1}{7,E} = tmp{8,E};
	end

end
