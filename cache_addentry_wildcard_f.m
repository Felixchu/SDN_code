function [cache,cache_addentry_f_local_polling]=cache_addentry_wildcard_f(cache,data,cache_addentry_f_local_polling,rule_src,rule_dst,rule_src_p,rule_dst_p,rule_prot,rule_prio);
   max_prio=0;
   max_golden=0;
   found_data=zeros(10,1);
   temp_data=zeros(10,1);
   for k=1:size(rule_src,1)
       if (data(1)<=rule_src(k,2) && data(1)>=rule_src(k,1)) && (data(2)<=rule_dst(k,2) && data(2)>=rule_dst(k,1)) && (data(3)<=rule_src_p(k,2) && data(3)>=rule_src_p(k,1)) ...
           && (data(4)<=rule_dst_p(k,2) && data(4)>=rule_dst_p(k,1)) && (data(5)==rule_prot(k,1) ||rule_prot(k,2)==0)
           if(rule_prio(k)>max_prio)
              max_prio=rule_prio(k);
              max_golden=k;
           end
       end
   end
     found_data=[rule_src(max_golden,1) rule_src(max_golden,2) rule_dst(max_golden,1) rule_dst(max_golden,2) rule_src_p(max_golden,1) rule_src_p(max_golden,2) rule_dst_p(max_golden,1) rule_dst_p(max_golden,2) rule_prot(max_golden,1) rule_prot(max_golden,2)];
     
     for k=1:size(rule_src,1)
         if(rule_prio(k)>max_prio)
            temp_data=[rule_src(k,1) rule_src(k,2) rule_dst(k,1) rule_dst(k,2) rule_src_p(k,1) rule_src_p(k,2) rule_dst_p(k,1) rule_dst_p(k,2) rule_prot(k,1) rule_prot(k,2)];
            s1=found_data(1);s2=found_data(2);s3=temp_data(1);s4=temp_data(2);d=data(1);
            a=sort([s1,d,s2,s3,s4]);
            a_eq_d=find(a==d);
            s1=a(a_eq_d(1));s2=a(a_eq_d(end));
            found_data(1)=s1;found_data(2)=s2;
            
            s1=found_data(3);s2=found_data(4);s3=temp_data(3);s4=temp_data(4);d=data(2);
            a=sort([s1,d,s2,s3,s4]);
            a_eq_d=find(a==d);
            s1=a(a_eq_d(1));s2=a(a_eq_d(end));
            found_data(3)=s1;found_data(4)=s2;
            
            s1=found_data(5);s2=found_data(6);s3=temp_data(5);s4=temp_data(6);d=data(3);
            a=sort([s1,d,s2,s3,s4]);
            a_eq_d=find(a==d);
            s1=a(a_eq_d(1));s2=a(a_eq_d(end));
            found_data(5)=s1;found_data(6)=s2;
            
            s1=found_data(7);s2=found_data(8);s3=temp_data(7);s4=temp_data(8);d=data(4);
            a=sort([s1,d,s2,s3,s4]);
            a_eq_d=find(a==d);
            s1=a(a_eq_d(1));s2=a(a_eq_d(end));
            found_data(7)=s1;found_data(8)=s2;
        end
     end

     cache(cache_addentry_f_local_polling,1)=1;
     cache(cache_addentry_f_local_polling,2:end-2)=found_data;
     cache(cache_addentry_f_local_polling,end-1)=max_prio;
     cache(cache_addentry_f_local_polling,end)=max_golden;
end

    
