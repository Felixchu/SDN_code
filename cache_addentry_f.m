function [cache,cache_addentry_f_local_polling]=cache_addentry_f(cache,data,cache_addentry_f_local_polling);
   
    cache(cache_addentry_f_local_polling,1)=1;
    cache(cache_addentry_f_local_polling,2:end)=data;
end