% clc
% clear
% close all
% format long
%������Ҫ�ĺ����ļ�

%�ڴ��ļ��������ɱ�Ҫ�����ݽṹPT����PbTb����
include('generate_PTPbTb_boundary');
%�ڴ��ļ����¸���ϵ���Ҷ�����⺯��
include('boundary_coefficient_righthand_exact');
%�ڴ��ļ�����������Ԫ���Ļ�����ɲ��֣�����������װ���߽紦���������ģ��
include('Finite_Element_Solver_1D');
%���ļ�������1D possion�����
include('Possion_Solver_1D');

%��ʵ���������涨��߽������������涨�������Լ�PT����ȣ���Ϊ������������
%����PT������������Ϳ�ʼ���룬�߽�����ҲӦ����������Ͷ����Ȼ�󴫸������
%��һ�ж������û������󣬶���Ҫ�������棬��PbTb������γ�ȴ�漰��������Ԫ�ռ�
%�ĸ�������Ҫ���ڲ����
%��ʼ���������
left = 0;                          %������˵�
right = 1;                         %�����Ҷ˵�
Gauss_type = 4;                    %��˹���ֵ����ͣ�ѡ�񼸵�ĸ�˹����
basis_type_trial = 101;            %��̽��������������
basis_type_test = 101;             %���Ժ�������������
der_trial = 1;                     %��̽����������
der_test = 1;                      %���Ժ����ĵ�����

fprintf('infinitenorm   L2norm   H1seminorm\n');
for i=2:1:7
    h=1/2^i;
    [solution,error] = Poisson_solver_1D(left,right,h,basis_type_trial,basis_type_test,der_trial,der_test,Gauss_type);
end
 