function [match,match_src,match_dst]=search_wildcard_f(BF,data,BF_SIZE);
%this is for src dst src_p dst_p as range rule
    match_s=zeros(4,1);
    match=0;
    src=data(1);
    dst=data(2);
    src_p=data(3);
    dst_p=data(4);
    prot=data(5);
    match_src=[];
    match_dst=[];
    for i=0:30
        type='src';
        temp_data=bitsll(fix(src/(2^i)),i)+2^(i-1);
        [BF_match_loc]=hash_wildcard_f(temp_data,BF_SIZE,type);
        BF_match_loc=unique(BF_match_loc);
        if(all(BF(BF_match_loc,1))==1)
          match_s(1)=1;
          %match_src=[match_src temp_data];
          break;
        end
    end
    if(match_s(1)==0)
        return ;
    end
    
    
    
    for i=0:30
        type='dst';
        temp_data=bitsll(fix(dst/(2^i)),i)+2^(i-1);
        [BF_match_loc]=hash_wildcard_f(temp_data,BF_SIZE,type);
        BF_match_loc=unique(BF_match_loc);
        if(all(BF(BF_match_loc,2))==1)
          match_s(2)=1;
         % match_dst=[match_dst temp_data];
         break;
        end
    end
    if(match_s(2)==0)
        return ;
    end
 
%     for i=0:14
%         type='src_p';
%         temp_data=bitsll(fix(src_p/(2^i)),i)+2^(i-1);
%         [BF_match_loc]=hash_wildcard_f(temp_data,BF_SIZE,type);
%         BF_match_loc=unique(BF_match_loc);
%         if(all(BF(BF_match_loc,3))==1)
%           match_s(3)=1;
%           break;
%         end
%     end
%     if(match_s(3)==0)
%         return ;
%     end
%     
%     for i=0:14
%         type='dst_p';
%         temp_data=bitsll(fix(dst_p/(2^i)),i)+2^(i-1);
%         [BF_match_loc]=hash_wildcard_f(temp_data,BF_SIZE,type);
%         BF_match_loc=unique(BF_match_loc);
%         if(all(BF(BF_match_loc,4))==1)
%           match_s(4)=1;
%           break;
%         end
%     end
%     if(match_s(4)==0)
%         return ;
%     end
    
    match=1;
end