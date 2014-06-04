function [bulk_data nConf] = load_bulk_file(place,name,all_traj)
	% TODO add description here
	
	bulk_data = [];
	nConf = 0;

	for traj = all_traj
		trajs=int2str(traj);
		fn = [place,'traj_',trajs,'_',name];
		if ~exist(fn,'file')
			fprintf('File %s doesnt exist!\n', fn);
			continue;
		end

		bulk_data = [bulk_data, importdata(fn)];

		nConf = nConf + 1;
	end

	fprintf('Number of %s files:\t%d\n',name,nConf);

end
