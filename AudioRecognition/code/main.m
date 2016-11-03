outputdir = './segmentation/';

[sample,fs] = audioread('audio_data/input.wav');
[m,c] = size(sample);
s = zeros(m, 1);
if (c==1) 
    s = sample.^2;
else
    for i = 1:c
        s = s + sample(:,i).^2;
    end
end
maxE = max(s);
fps = 100;
th_sf = 0.15;
maxI = 5;
minD = 58;
step = fs/fps;
n = int32(m/step);
sf = zeros(n, 1, 'uint8');
for i=1:n
    temp = s((i-1) * step + 1: i * step);
    e = max(temp);
    if (e < th_sf * maxE)
        sf(i) = 1;
        
    else
        sf(i) = 0;
       
    end
end
    
i = 1;
last = 1;
seg = [];
while (i <= n) 
    if (sf(i) == 1)
        [count, ed] = segmentation(sf, n, i, maxI);
        if (count >= minD)
            seg = [seg; last (i - 1)];
            last = ed + 1;
        end
        i = ed + 1;
    else
        i = i + 1;
    end
end
seg = [seg; last n];

[ms, two] = size(seg);
count = 0;
segmentation_list = {};
for i = 1:ms
    if (seg(i,2) - seg(i,1) > 20)
        y = sample(seg(i,1)*step - step + 1:seg(i,2)*step,:);
        count = count + 1;
        segmentation_list{count} = y;
        if count < 10
          filename = sprintf('%s00%d.wav', outputdir, count);
        end
        if count >= 10
            filename = sprintf('%s0%d.wav', outputdir, count);
        end
        audiowrite(filename, y, 16000);
    end
end

speaker_recognition(segmentation_list,count,fs);
