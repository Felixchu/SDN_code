function [cache,BF,cache_addentry_f_local_polling]=new_cache_event_wildcard_f(cache,cache_addentry_f_local_polling,CACHE_SIZE,data,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,rule_prio,BF,BF_SIZE);
    [cache_addentry_f_local_polling]=cache_addentry_f_local_polling_f(cache_addentry_f_local_polling,CACHE_SIZE);
    if(all(cache(:,1))==1)          %all: check if all element are nonzero
        replace_wildcare_value=cache(cache_addentry_f_local_polling,(2:end));
        replace_BF_data=convert_rule2BF_wildcard_f(replace_wildcare_value);
        [cache,cache_addentry_f_local_polling]=cache_addentry_wildcard_f(cache,data,cache_addentry_f_local_polling,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,rule_prio);
        insert_wildcare_value=cache(cache_addentry_f_local_polling,(2:end));
        insery_BF_data=convert_rule2BF_wildcard_f(insert_wildcare_value);
        [BF]=delete_wildcard_f(BF,replace_BF_data,BF_SIZE); 
        [BF]=insert_wildcard_f(BF,insery_BF_data,BF_SIZE);
    else
        [cache,cache_addentry_f_local_polling]=cache_addentry_wildcard_f(cache,data,cache_addentry_f_local_polling,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,rule_prio);
        insert_wildcare_value=cache(cache_addentry_f_local_polling,(2:end));
        insery_BF_data=convert_rule2BF_wildcard_f(insert_wildcare_value);
        [BF]=insert_wildcard_f(BF,insery_BF_data,BF_SIZE);
    end


end
