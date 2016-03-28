function [match]=search_f(BF,data,BF_SIZE);
    match=0;
    match_s=zeros(2,1);
      type='src';
     [BF_match_loc]=hash_f(data(1),BF_SIZE,type);
      BF_match_loc=unique(BF_match_loc);
      if(all(BF(BF_match_loc,1))==1)
          match_s(1)=1;
      end
      
       if(match_s(1)==0)
        return ;
        end
    
      
       type='dst';
     [BF_match_loc]=hash_f(data(2),BF_SIZE,type);
      BF_match_loc=unique(BF_match_loc);
      if(all(BF(BF_match_loc,2))==1)
          match_s(2)=1;
      end
      
       if(match_s(2)==0)
        return ;
       end
    
    match=1;
end