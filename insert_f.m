function [BF]=insert_f(BF,data,BF_SIZE);
    for i=1:2
        switch i
            case 1
                type='src';
            case 2
                type ='dst';
            case 3
                type ='src_p';
            case 4
                type='dst_p';
        end
    [BF_match_loc]=hash_wildcard_f(data(i),BF_SIZE,type);
    BF_match_loc=unique(BF_match_loc);
    BF(BF_match_loc,i)=BF(BF_match_loc,i)+1;
    
end