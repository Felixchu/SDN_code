function [error]=cache_check_golden_wildcard_f(data,match_src,match_dst,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot);
    golden=data(6);
    error=0;
    wildcard_value=[rule_src(golden,:) rule_dst(golden,:) rule_src_p(golden,:) rule_dst_p(golden,:) rule_prot(golden,:)];
    [BF_data]=convert_rule2BF_wildcard_f(wildcard_value);
    if(BF_data(1)~=match_src || BF_data(2)~=match_dst)
       error=1; 
    end
end