function [match]=search_f(BF,data,BF_SIZE);
     [BF_match_loc]=hash_f(data,BF_SIZE);
      BF_match_loc=unique(BF_match_loc);
      if(all(BF(BF_match_loc))==1)
          match=1;
      else 
          match=0;
      end
end