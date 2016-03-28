function [BF_match_loc]=hash_wildcard_f(data,BF_SIZE,type);
    length=0;
    switch (type)
        case 'src'
            length=32;
        case 'dst'
            length=32;
        case 'src_p'
            length=16;
        case 'dst_p'
            length=16;
        otherwise
            length=16;
    end
    if(length==32)
        bitvector_src=de2bi(uint32(data),length);
    else
        bitvector=de2bi(uint16(data),length);
        bitvector_src=[bitvector bitvector];
    end
    bitvector_dst=[bitvector_src(2) bitvector_src(7) bitvector_src(21) bitvector_src(32) bitvector_src(2) bitvector_src(8) bitvector_src(30) bitvector_src(4) bitvector_src(11) bitvector_src(15) bitvector_src(6) bitvector_src(17) bitvector_src(31) bitvector_src(28) bitvector_src(24) bitvector_src(5) bitvector_src(26) bitvector_src(1) bitvector_src(19) bitvector_src(6) bitvector_src(2) bitvector_src(10) bitvector_src(25) bitvector_src(25) bitvector_src(28) bitvector_src(30) bitvector_src(6) bitvector_src(11) bitvector_src(29) bitvector_src(17) bitvector_src(11) bitvector_src(8)];
    bitvector_port_s=[bitvector_src(20) bitvector_src(8) bitvector_src(1) bitvector_src(31) bitvector_src(17) bitvector_src(15) bitvector_src(22) bitvector_src(29) bitvector_src(32) bitvector_src(1) bitvector_src(2) bitvector_src(15) bitvector_src(28) bitvector_src(23) bitvector_src(15) bitvector_src(14)];
    bitvector_port_d=[bitvector_src(1) bitvector_src(32) bitvector_src(29) bitvector_src(22) bitvector_src(14) bitvector_src(17) bitvector_src(7) bitvector_src(9) bitvector_src(20) bitvector_src(4) bitvector_src(28) bitvector_src(19) bitvector_src(30) bitvector_src(4) bitvector_src(3) bitvector_src(26)];
    bitvector_xor_temp=xor(bitvector_src,bitvector_dst);
    bitvector_1=xor(xor(bitvector_src,bitvector_dst),[bitvector_port_s bitvector_port_d]);
    bitvector_2=xor(or(xor(bitvector_src,bitvector_dst),[bitvector_port_s bitvector_port_d]),bitrevorder([bitvector_dst]));
    bitvector_3=xor(xor(and(bitrevorder(bitvector_dst),bitvector_src),bitvector_dst),[bitvector_port_d bitvector_port_s]);
    bitvector_4=xor(xor(xor(bitrevorder(bitvector_src),bitvector_src),bitrevorder(bitvector_dst)),[bitvector_port_d bitvector_port_s]);
    bitvector_5=xor(xor(and(bitrevorder(bitvector_src),bitvector_src),bitrevorder(bitvector_dst)),[xor(bitvector_port_s,bitvector_port_d),bitrevorder(bitvector_port_s)]);
    num_1=mod(bi2de(bitvector_1),BF_SIZE)+1;
    num_2=mod(bi2de(bitvector_2),BF_SIZE)+1;
    num_3=mod(bi2de(bitvector_3),BF_SIZE)+1;
    num_4=mod(bi2de(bitvector_4),BF_SIZE)+1;
    num_5=mod(bi2de(bitvector_5),BF_SIZE)+1;
    BF_match_loc=[num_1 num_5 num_2 num_3];
end