%cache size=500;
%BF=3000;
%false postive rate=5.6%
%rule: acl1_10000_2_05_1   trace:acl1_10000_2_05_1_trace
%load hashtest_wildcard_acl1_10000_2_05_1_data_after_traslation.mat;
CACHE_SIZE=1000;
BF_SIZE=7001;
cache=zeros(CACHE_SIZE,13);
BF=zeros(BF_SIZE,4);
BF_WORK=0;
FALSE_POS=0;
BF_MISS=0;
CACHE_CHANGE=0;
ERROR=0;
cache_addentry_f_local_polling=0;
TOTAL_ROUND=length(packet_src);
BF_TEST=1;
if BF_TEST==1
    matrix_whole=[packet_src packet_dst packet_src_p packet_dst_p packet_prot];
    diff_matrix=diff(matrix_whole,1,1);
    matrix_whole( ~any(diff_matrix,2), : ) = [];
   % matrix_unique=unique(matrix_whole(1:TOTAL_ROUND,:),'rows','stable');
    diffBF_total_round= length(matrix_whole(:,1));
    real_TOTAL_ROUND=diffBF_total_round;
    src=matrix_whole(:,1);dst=matrix_whole(:,2);port_s=matrix_whole(:,3);port_d=matrix_whole(:,4);prot=matrix_whole(:,5);
else
    real_TOTAL_ROUND=TOTAL_ROUND;
end
for round=1:real_TOTAL_ROUND
    data=[packet_src(round),packet_dst(round),packet_src_p(round),packet_dst_p(round),packet_prot(round),packet_golden(round)];
    [match,match_src,match_dst]=search_wildcard_f(BF,data,BF_SIZE);
    if(all(match)==1)
        BF_WORK=BF_WORK+1;
        [match,match_num]=cache_check_wildcard_f(cache,data);
        if(match~=1)
            FALSE_POS=FALSE_POS+1;
            [cache,BF,cache_addentry_f_local_polling]=new_cache_event_wildcard_f(cache,cache_addentry_f_local_polling,CACHE_SIZE,data,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,rule_prio,BF,BF_SIZE);
            CACHE_CHANGE=CACHE_CHANGE+1;
%         elseif (cache_check_golden_wildcard_f(data,match_src,match_dst,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,match_num) )
        elseif(match_num~=data(6)+1)
            m1=match_num;m2=data(6)+1;
            if ~((rule_src(m1)==rule_src(m2)) && (rule_dst(m1)==rule_dst(m2)) && (rule_src_p(m1)==rule_src_p(m2)) && (rule_dst_p(m1)==rule_dst_p(m2)) && (rule_prot(m1)==rule_prot(m2)))
                ERROR=ERROR+1;
            end
        end
    else
        BF_MISS=BF_MISS+1;
        [cache,BF,cache_addentry_f_local_polling]=new_cache_event_wildcard_f(cache,cache_addentry_f_local_polling,CACHE_SIZE,data,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,rule_prio,BF,BF_SIZE);
        CACHE_CHANGE=CACHE_CHANGE+1;
        
    end 
end


BF_WORK=TOTAL_ROUND-BF_MISS;
CACHE_HIT=BF_WORK-FALSE_POS; %=TOTAL-BF_MISS-FALSE_POS
CACHE_MISS=TOTAL_ROUND-CACHE_HIT;
CACHE_REPLACE=CACHE_CHANGE-CACHE_SIZE ;

Rate_BF_FALSE_POS=FALSE_POS/real_TOTAL_ROUND;
Rate_FALSE_POS=FALSE_POS/TOTAL_ROUND;
Rate_CACHE_MISS=CACHE_MISS/TOTAL_ROUND;


