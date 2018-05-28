% clc
% clear
% close all
format long
%��ʼ���������
left = 0;                          %������˵�
right = 1;                         %�����Ҷ˵�
Gauss_type=4;                      %��˹���ֵ����ͣ�ѡ�񼸵�ĸ�˹����
basis_type_trial = 101;            %��̽��������������
basis_type_test = 101;             %���Ժ�������������
der_trial = 1;                     %��̽����������
der_test = 1;                      %���Ժ����ĵ�����

fprintf('infinitenorm   L2norm   H1seminorm\n');
for i=2:1:7
    h=1/2^i;
    [solution,error] = Poisson_solver_1D(left,right,h,basis_type_trial,basis_type_test,der_trial,der_test,Gauss_type);
end
 