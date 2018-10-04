clc
clear
close all
% ��������
left = 0;                                %������˵�
right = 1;                               %�����Ҷ˵�
% ����ʱ������
initial = 0;                             %��ʼʱ�̣���ֹʱ�̣�ʱ�䲽��
final = 0.2;
dt = 0.1;                                  
theta = 1;                               %��ʱ�䷽��ʹ��theta��ʽ
% ������Ϣ
pde.exact_solution = @(x, t) 1 + x^2 + t;
pde.gradient = @(x, t) 2*x;
pde.initial_fun = @(x, t) 1 + x^2;
pde.right_hand_side = @(x, t) -1;
pde.coefficient1 = @(x, t) 1;
pde.coefficient2 = @(x, t) 1;
% ����Ԫ�ռ���Ϣ
FE.Gauss_type = 4;                       %��˹���ֵ����ͣ�ѡ�񼸵�ĸ�˹����
FE.basis_type_trial = 101;               %��̽��������������
FE.basis_type_test = 101;                %���Ժ�������������

fprintf('infinitenorm   L2norm   H1seminorm\n');
for i=2:1:7
    h=1/2^i;
    FE  = generate_FE_space( FE, left, right, h );
    [pde, FE] = Heat_Solver_1D(pde, FE, initial, final, dt, theta);
    error = compute_error( pde, FE, final );
end
 