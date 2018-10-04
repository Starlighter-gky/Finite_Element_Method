function [solution,error] = Poisson_solver_1D(left,right,h,basis_type_trial,basis_type_test,der_trial,der_test,Gauss_type)
% һάpossion���������
% ��Ҫ�����������ʽ�ķ���
% $-\nabla \cdot c(x) \nabla u(x) = f(x),a\le x\le b$
%$u(a)=g_a$,
%$u'(b)+q_bu(b)=p_b$
% left = 0;                          %������˵�
% right = 1;                         %�����Ҷ˵�
% Gauss_type=4;                      %��˹���ֵ����ͣ�ѡ�񼸵�ĸ�˹����
% basis_type_trial = 102;            %��̽��������������
% basis_type_test = 102;             %���Ժ�������������
% der_trial = 1;                     %��̽����������
% der_test = 1;                      %���Ժ����ĵ�����

N=(right-left)/h;                  %�������
basis_type = basis_type_trial;                  %����������
[P,T] = generate_PT_1D(left, right, h,basis_type);                         %P����洢�ڵ��ż����꣬T����洢ÿ����Ԫ�Ľڵ�ţ���һ���Ĺ�������
[Pb,Tb] = generate_PbTb_1D(left, right, h,basis_type);                     %Pb����洢����Ԫ�ڵ㼰���꣬Tb����洢ÿ����Ԫ������Ԫ�ڵ�ţ���һ���Ĺ�������
boundarynodes = generate_boundarynodes(N, basis_type);                     %���ɱ߽�㣬�洢��Ӧ�ı߽�������Լ��߽�������Ԫ���

%------------------------------��װ��--------------------------------------%
%������װ��
matrix_size = [size(Pb,2), size(Pb,2)];                                          %�նȾ���Ĵ�С
A = assemble_matrix_volume_in_1D('coefficient_fun_c',matrix_size,P,T,Pb,Tb,basis_type_trial,der_trial,basis_type_test,der_test,Gauss_type);
%������װ��
vector_size = size(Pb,2);                                                        %�Ҷ������Ĵ�С
b = assemble_vector_1D_volume_in_1D('righthand_fun_f',P,T,Pb,Tb,vector_size,basis_type_test,Gauss_type);
%----------------------------����߽�����----------------------------------%
%�߽���������
[ A, b ] = treat_Robin_boundary( A, b, boundarynodes,'coefficient_fun_c','Robin_fun_pb','Robin_fun_qb',Pb);
[ A, b ] = treat_Neumann_boundary( A, b, boundarynodes,'coefficient_fun_c','Neumann_fun_rb',Pb);%����Neumann�߽�����    
[ A, b ] = treat_Dirichlet_boundary(A, b, boundarynodes,'Dirichlet_fun_g',Pb);           %����Dirichlet�߽�
%----------------------------�����Է�����----------------------------------%
solution = A\b;
%---------------------------�������---------------------------------------%
%������
%error = compute_error_on_nodes('exact',Pb,solution);
error = compute_inf_error('exact', solution,P,T,Tb, basis_type, 0);                       %������������
inf_error = max(error);
L2_error = compute_Hs_error('exact', solution,P,T, Tb, basis_type, 0,Gauss_type);         %����L2�������
H1_semi_error = compute_Hs_error('exact1', solution,P,T, Tb, basis_type, 1,Gauss_type);   %����H1�뷶���
fprintf('%7.4e  %7.4e  %7.4e\n',inf_error,L2_error,H1_semi_error);
end