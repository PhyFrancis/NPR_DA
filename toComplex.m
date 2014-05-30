function y = toComplex(x)
	% transform real x into complex y by binning neighbouring numbers in x:
	% y = (x(1,1),x(1,2)) , (x(1,3),x(1,4) , ...
	%     (x(2,1),x(2,2)) , (x(2,3),x(2,4) , ...
	
	y = complex(x(:,1:2:end),x(:,2:2:end));

end
