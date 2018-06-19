function [P,T] = generate_PT_1D(left, right, h,basis_type)
if basis_type==101              %һά����Ԫ
    N = (right-left)/h;         %��Ԫ����
    P = zeros(1,N+1);           %��������N+1���ڵ�
    T = zeros(2,N);             %��������N����Ԫ
    for i=1:1:N                 %ѭ��ÿ����Ԫ
        x(i) = left+(i-1)*h;    %����ڵ�����
        P(1,i) = x(i);          %���ڵ��������P�����ÿһ��
        T(:,i) =[i, i+1]' ;     %��ÿ����Ԫ�Ľڵ�ŷ���T�����ÿһ��
    end
    x(N+1) = left+N*h;          %���һ���ڵ�
    P(1,N+1) = x(N+1);

    
elseif basis_type==102          %һά����Ԫ
    N = (right-left)/h;         %��Ԫ����
    P = zeros(1,N+1);           %��������N+1���ڵ�
    T = zeros(2,N);             %��������N����Ԫ
    for i=1:1:N                 %ѭ��ÿ����Ԫ
        x(i) = left+(i-1)*h;    %����ڵ�����
        P(1,i) = x(i);          %���ڵ��������P�����ÿһ��
        T(:,i) =[i, i+1]' ;     %��ÿ����Ԫ�Ľڵ�ŷ���T�����ÿһ��
    end
    x(N+1) = left+N*h;          %���һ���ڵ�
    P(1,N+1) = x(N+1);
else
    error('we have no this type basis');
end



end