function [ count, ed ] = segmentation( sf, n, st, maxI )

count = 0;
ns = 0;
i = st;
ed = st;
while ((i < n) && (ns < maxI))
    if (sf(i) == 1)
        count = count + 1;
        ed = i;
    else
        ns = ns + 1;
    end
    i = i + 1;
end
    
end

