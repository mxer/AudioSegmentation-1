function speaker_num = eval_speaker_num(mfc_list,len)
    result_list= {};
    mfc_center_list = {};
    seg_num_list = {};
    count = 0;
    talker_num = 0;
    dist_max = 13;
    for i = 1:len
        final_mfc = mfc_list{i};
        count = count + 1;
        if count == 1
            talker_num = talker_num + 1;
            result_list{i} = talker_num;
            mfc_center_list{talker_num} = final_mfc;
            seg_num_list{talker_num} = 1;
        else
            distmin = inf;
            for j = 1:(i-1)
                d = distance(final_mfc, mfc_list{j});
                dist = sum(min(d,[],2)) / size(d,1);
                if dist < distmin
                    distmin = dist;
                    result_list{i} = result_list{j};
                end
            end
            if dist < dist_max
                select_speaker = result_list{i};
                mfc_center_list{select_speaker} = (mfc_center_list{select_speaker}*seg_num_list{select_speaker}+final_mfc)/(seg_num_list{select_speaker}+1);
                seg_num_list{select_speaker} = seg_num_list{select_speaker} + 1;
            else
                talker_num = talker_num + 1;
                result_list{i} = talker_num;
                mfc_center_list{talker_num} = final_mfc;
                seg_num_list{talker_num} = 1;
            end
        end
    end
    speaker_num = talker_num;
end