function [BF]=insert_f(BF,data,BF_SIZE);
    [BF_match_loc]=hash_f(data,BF_SIZE);
    BF_match_loc=unique(BF_match_loc);
    BF(BF_match_loc)=BF(BF_match_loc)+1;
end