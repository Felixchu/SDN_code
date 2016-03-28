function [cache_match]=cache_check_f(cache,data);
    cache_match=0;
    cache_size=length(cache(:,1));
    for i=1:cache_size
        cache_data=cache(i,2:6);
        cache_valid=cache(1);
       if (all(cache_data==data)==1) && (cache_valid==1) 
          cache_match=1;
          break
       end
    end


end