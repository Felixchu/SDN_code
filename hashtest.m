%cache size=500;
%BF=3000;
%false postive rate=5.6%
%load acl1_trace_m.mat;
CACHE_SIZE=1000;
BF_SIZE=7001;
cache=zeros(CACHE_SIZE,6);
BF=zeros(BF_SIZE,2);
BF_WORK=0;
FALSE_POS=0;
BF_MISS=0;
CACHE_CHANGE=0;
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
    packet_src=matrix_whole(:,1);packet_dst=matrix_whole(:,2);packet_src_p=matrix_whole(:,3);packet_dst_p=matrix_whole(:,4);packet_prot=matrix_whole(:,5);
else
    real_TOTAL_ROUND=TOTAL_ROUND;
end
for round=1:real_TOTAL_ROUND
    data=[packet_src(round),packet_dst(round),packet_src_p(round),packet_dst_p(round),packet_prot(round)];
    if(search_f(BF,data,BF_SIZE)==1)
        BF_WORK=BF_WORK+1;
        if(cache_check_f(cache,data)~=1)
            FALSE_POS=FALSE_POS+1;
            [cache_addentry_f_local_polling]=cache_addentry_f_local_polling_f(cache_addentry_f_local_polling,CACHE_SIZE);
            replace_data=cache(cache_addentry_f_local_polling,(2:end));
            [BF]=delete_f(BF,replace_data,BF_SIZE); 
            [BF]=insert_f(BF,data,BF_SIZE);
            [cache,cache_addentry_f_local_polling]=cache_addentry_f(cache,data,cache_addentry_f_local_polling); 
            CACHE_CHANGE=CACHE_CHANGE+1;
        end
    else
        BF_MISS=BF_MISS+1;
        [cache_addentry_f_local_polling]=cache_addentry_f_local_polling_f(cache_addentry_f_local_polling,CACHE_SIZE);
        if(all(cache(:,1))==1)          %all: check if all element are nonzero
            replace_data=cache(cache_addentry_f_local_polling,(2:end));
            [BF]=delete_f(BF,replace_data,BF_SIZE); 
            [BF]=insert_f(BF,data,BF_SIZE);
        else
            [BF]=insert_f(BF,data,BF_SIZE);
        end
        [cache,cache_addentry_f_local_polling]=cache_addentry_f(cache,data,cache_addentry_f_local_polling);
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


