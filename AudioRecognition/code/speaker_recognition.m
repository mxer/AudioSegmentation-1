function speaker_recognition(segmentation_list,len,FS)
    output = fopen('recognition/result.txt', 'wt');
    % fileList = dir('segmentation/*.wav');
    % len = length(fileList);
    total_mfc = [];
    mfc_list = {};
    
    for i = 1:len
        % filename = ['segmentation/', fileList(i).name];
        % fname{i} = filename;
        % [sampledata,FS] = audioread(filename);
        % %sampledata = sample_data(i); 
        % sample = calsample(sampledata);
        sample = segmentation_list{i};
        mfc = mfcc(sample, FS);
        final_mfc = combine_frame_feature(mfc',1);
        mfc_list{i} = final_mfc;
        final_mfc = final_mfc(:);
        total_mfc = [total_mfc;final_mfc'];
    end
    talker_num = eval_speaker_num(mfc_list,len);
    % talker_num = 7;  
    Idx = kmeans(total_mfc,talker_num);
    fprintf(output, '%d\n', talker_num);
    for i = 1:len
        fprintf(output, '%d\n', Idx(i,1));
    end
    fclose(output);
end
    
    