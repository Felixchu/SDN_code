function [hash]=JSHach_f(string)
    hash=1315423911;
    for i=1:length(string)
        hash=bitxor(hash,(bitsll(uint32(hash),5)+string(i)+bitsrl(uint32(hash),2)));
    end

end
