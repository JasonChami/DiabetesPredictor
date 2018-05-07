function data = getdata(datapath)
    datafile = fullfile(datapath);
    dataID = fopen(datafile);
    data = textscan(dataID,'%f %f %f %f %f %f %f %f %s','Delimiter',',');
    fclose(dataID);
end