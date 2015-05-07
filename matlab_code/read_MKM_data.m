function [ data ] = read_MKM_data( filename )

% Read in headers.
fid = fopen(filename);
max_scans = 400;
strings = textscan(fid,'%s',max_scans);
fclose(fid);
headers = {};
header_line = 24;
i = 1;
line = 1;
while (line < header_line)
    if strcmp(strings{1}{i},'#')
        line = line + 1;
    end
    i = i + 1;
end
i = i - 1;
while ~strcmp(strings{1}{i+1},'#')
    headers{length(headers)+1} = strings{1}{i+1};
    i = i+1;
end

% Read in data.
raw_data = dlmread(filename,'\t',header_line+1,0);

% Match headers with data.
for i = 1:length(headers)
    values{i} = raw_data(:,i);
end
data = containers.Map(headers,values);

end

