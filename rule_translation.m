rule_src_r=zeros(size(rule_src,1),2);
rule_dst_r=zeros(size(rule_src,1),2);
rule_src_p_r=zeros(size(rule_src,1),2);
rule_dst_p_r=zeros(size(rule_src,1),2);
rule_prot_r=zeros(size(rule_src,1),2);
temp={1 1 1 1 1 1};
temp_num=0;
temp_down=0;
temp_up=0;
for i=1:size(rule_src,1)
    temp=strsplit(rule_src{i},{'@','.','/'});
    temp_num=bitsll(str2num(temp{2}),24)+bitsll(str2num(temp{3}),16)+bitsll(str2num(temp{4}),8)+str2num(temp{5});
    wildcard=32-str2num(temp{6});
    temp_down=bitsll(temp_num/(2^wildcard),wildcard);
    temp_up=temp_down+2^(wildcard)-1;
    
    rule_src_r(i,:)=[temp_down temp_up];
    temp=strsplit(rule_dst{i},{'.','/'});
    temp_num=bitsll(str2num(temp{1}),24)+bitsll(str2num(temp{2}),16)+bitsll(str2num(temp{3}),8)+str2num(temp{4});
    wildcard=32-str2num(temp{5});
    temp_down=bitsll(temp_num/(2^wildcard),wildcard);
    temp_up=temp_down+2^(wildcard)-1;
    rule_dst_r(i,:)=[temp_down temp_up];
    
    temp=strsplit(rule_src_p{i},':');
    temp_down=str2num(temp{1});
    temp_down=2^(fix(log2(temp_down)));
    temp_up=str2num(temp{2});
    temp_up=2^(ceil(log2(temp_up)));
    rule_src_p_r(i,:)=[temp_down temp_up];
    
    temp=strsplit(rule_dst_p{i},':');
    temp_down=str2num(temp{1});
    temp_down=2^(fix(log2(temp_down)));
    temp_up=str2num(temp{2});
    temp_up=2^(ceil(log2(temp_up)));
    rule_dst_p_r(i,:)=[temp_down temp_up];
    
    temp=strsplit(rule_prot{i},'/');
    temp_num=hex2dec(temp{1}(3:end));
    if (temp{2}=='0xFF')
        rule_prot_r(i,1)=temp_num;
        rule_prot_r(i,2)=1;
    else
        rule_prot_r(i,:)=[0 0];
    end
end
rule_src=rule_src_r;
rule_dst=rule_dst_r;
rule_src_p=rule_src_p_r;
rule_dst_p=rule_dst_p_r;
rule_prot=rule_prot_r;
rule_prio=[size(rule_src,1):-1:1]';

max_prio=0;
max_golden=0;
% 
% for i=1:size(packet_src,1)
%     for k=1:size(rule_src,1)
%        if (packet_src(i)<=rule_src(k,2) && packet_src(i)>=rule_src(k,1)) && (packet_dst(i)<=rule_dst(k,2) && packet_dst(i)>=rule_dst(k,1)) && (packet_src_p(i)<=rule_src_p(k,2) && packet_src_p(i)>=rule_src_p(k,1)) ...
%            && (packet_dst_p(i)<=rule_dst_p(k,2) && packet_dst_p(i)>=rule_dst_p(k,1)) && (packet_prot(i)==rule_prot(k,1) ||rule_prot(k,2)==0)
%            if(rule_prio(k)>max_prio)
%             max_prio=rule_prio(k);
%             max_golden=k;
%            end
%            break;
%        end
%     end
%     max_prio=0;
%     packet_golden(i)=max_golden;
% end
