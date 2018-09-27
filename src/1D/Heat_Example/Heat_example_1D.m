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
include('Heat_Solver_1D');
%��ʵ���������涨��߽������������涨�������Լ�PT����ȣ���Ϊ������������
%����PT������������Ϳ�ʼ���룬�߽�����ҲӦ����������Ͷ����Ȼ�󴫸������
%��һ�ж������û������󣬶���Ҫ�������棬��PbTb������γ�ȴ�漰��������Ԫ�ռ�
%�ĸ�������Ҫ���ڲ����
%��ʼ���������
left = 0;                          %������˵�
right = 1;                         %�����Ҷ˵�

initial = 0;                       %��ʼʱ�̣���ֹʱ�̣�ʱ�䲽��
final = 0.2;
dt = 0.001;
                                   %��ʱ�䷽��ʹ��theta��ʽ
theta = 1;

Gauss_type = 4;                    %��˹���ֵ����ͣ�ѡ�񼸵�ĸ�˹����
basis_type_trial = 101;            %��̽��������������
basis_type_test = 101;             %���Ժ�������������
der_trial = 1;                     %��̽����������
der_test = 1;                      %���Ժ����ĵ�����

fprintf('infinitenorm   L2norm   H1seminorm\n');
for i=2:1:7
    h=1/2^i;
    [solution,error] = Heat_Solver_1D(left, right, h, initial, final, dt, theta,basis_type_trial,basis_type_test,der_trial,der_test,Gauss_type);
end
 