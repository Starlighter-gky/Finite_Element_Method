clc
clear
close all
format long
%%
%��������
left = -1;                  %��߽�
right = 1;                  %�ұ߽�
bottom = -1;                %�±߽�
top = 1;                    %�ϱ߽�
Gauss_type=4;               %Gauss���ֵ�����
basis_type_trial = 201;     %��̽�����Ļ���������
basis_type_test = 201;      %���Ժ����Ļ���������
%%
fprintf('infinitenorm  L2norm   H1seminorm\n');
for i=2:1:6
    hx=1/2^i;
    hy=1/2^i;
    [solution,error] = Poisson_solver_2D(left,right,bottom,top,hx,hy,basis_type_trial,basis_type_test,Gauss_type);
end
 