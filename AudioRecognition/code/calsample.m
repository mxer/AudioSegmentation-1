function sample = calsample(sampledata)
    [m,n] = size(sampledata);
    if (n == 2)
        sample = sampledata(:,1);
    else
        sample = sampledata;
    end
end