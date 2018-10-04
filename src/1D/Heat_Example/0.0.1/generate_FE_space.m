function  FE  = generate_FE_space( FE, left, right, h )
%GENERATE_FE_SPACE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
N = (right - left)/h;                                                      %�������
basis_type = FE.basis_type_trial;                                          %����������
[FE.P, FE.T] = generate_PT_1D(left, right, h,basis_type);                  %P����洢�ڵ��ż����꣬T����洢ÿ����Ԫ�Ľڵ�ţ���һ���Ĺ�������
[FE.Pb, FE.Tb] = generate_PbTb_1D(left, right, h,basis_type);              %Pb����洢����Ԫ�ڵ㼰���꣬Tb����洢ÿ����Ԫ������Ԫ�ڵ�ţ���һ���Ĺ�������
FE.boundarynodes = generate_boundarynodes(N, basis_type);                  %���ɱ߽�㣬�洢��Ӧ�ı߽�������Լ��߽�������Ԫ���

end

