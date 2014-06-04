function cnv_tensor = cnv_ord_4tensor(tensor, origOrd)
	% convert the indices' order from origOrd to '1234'
	
	cnv_tensor = zeros(144,144);
	if origOrd == '1234'
		cnv_tensor = tensor;
	elseif origOrd == '3214'
		for i = 1:12
			for j = 1:12
				for k = 1:12
					for l = 1:12
						cnv_tensor(tensorMap(i,j),tensorMap(k,l)) = tensor(tensorMap(k,j),tensorMap(i,l));
					end
				end
			end
		end
	elseif origOrd == '1432'
		for i = 1:12
			for j = 1:12
				for k = 1:12
					for l = 1:12
						cnv_tensor(tensorMap(i,j),tensorMap(k,l)) = tensor(tensorMap(i,l),tensorMap(k,j));
					end
				end
			end
		end
	end

	clear i;
	clear j;
	clear k;
	clear l;
end
