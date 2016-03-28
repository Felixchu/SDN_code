function [BF_data]=convert_rule2BF_wildcard_f(wildcard_value);
    for i=1:size(wildcard_value)
        temp_down=wildcard_value(1);
        temp_up=wildcard_value(2);
        temp_shift=fix((temp_up-temp_down+1)/2);
        temp_ans=temp_down+temp_shift;
        BF_data(1)=temp_ans;
        
        temp_down=wildcard_value(3);
        temp_up=wildcard_value(4);
        temp_shift=fix((temp_up-temp_down+1)/2);
        temp_ans=temp_down+temp_shift;
        BF_data(2)=temp_ans;
        
        temp_down=wildcard_value(5);
        temp_up=wildcard_value(6);
        temp_shift=fix((temp_up-temp_down+1)/2);
        temp_ans=temp_down+temp_shift;
        BF_data(3)=temp_ans;
        
        temp_down=wildcard_value(7);
        temp_up=wildcard_value(8);
        temp_shift=fix((temp_up-temp_down+1)/2);
        temp_ans=temp_down+temp_shift;
        BF_data(4)=temp_ans;
        
        temp_down=wildcard_value(9);
        temp_up=wildcard_value(10);
        temp_shift=fix((temp_up-temp_down+1)/2);
        temp_ans=temp_down+temp_shift;
        BF_data(5)=temp_ans;
    end
end