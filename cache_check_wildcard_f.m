function [cache_match,match_num]=cache_check_wildcard_f(cache,data);
    cache_match=0;
    cache_size=length(cache(:,1));
    max_prio=0;
    match_num=0;
    for k=1:cache_size      
        if (data(1)<=cache(k,3) && data(1)>=cache(k,2)) && (data(2)<=cache(k,5) && data(2)>=cache(k,4))  && (data(3)<=cache(k,7) && data(3)>=cache(k,6))  && (data(4)<=cache(k,9) && data(4)>=cache(k,8))  && (data(5)<=cache(k,10) || cache(k,11)==0) && cache(k,1)==1;
             cache_match=1;
%             if(max_prio<cache(k,12))
%                 match_num=cache(k,13);
%             end
               match_num=cache(k,13);
               break;
        end
    end
end


