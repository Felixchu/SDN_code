function [cache_addentry_f_local_polling]=cache_addentry_f_local_polling_f(cache_addentry_f_local_polling,CACHE_SIZE)
    cache_addentry_f_local_polling=cache_addentry_f_local_polling+1;
    if(cache_addentry_f_local_polling>CACHE_SIZE)
       cache_addentry_f_local_polling=1;
    end
end