function [solution,error] = Poisson_solver_2D(left,right,bottom,top,hx,hy,basis_type_trial,basis_type_test,Gauss_type)
% ��άpossion���������
% left,right,bottom,top�ֱ�Ϊ������������ϱ߽�
% hx,hyΪx�����y����Ĳ���
% basis_type_trialΪ��̽�����Ļ���������
% basis_type_testΪ���Ժ����Ļ���������
% Gauss_typeΪGauss���ֹ�ʽ�ĵ�����,��ѡ�񼸵��Gauss����
interval_x=[left right];
interval_y=[bottom top];
h=[hx,hy];
basis_type = 201;
Nx=(interval_x(2)-interval_x(1))/h(1);
Ny=(interval_y(2)-interval_y(1))/h(2);
[P,T] = generate_PT_2D(interval_x, interval_y, h,basis_type);              %��������ڵ㼰���
[Pb,Tb] = generate_PbTb_2D(P, T,basis_type);                               %��������Ԫ�ڵ㼰���
boundaryedges = generate_boundaryedges_2D_triangle(Nx,Ny);                 %���ɱ߽��
boundarynodes = generate_boundarynodes_2D_triangle(Nx,Ny);                 %���ɱ߽��

%-----------------------��װ�նȾ���----------------------------------------%
%��װ�նȾ���
matrix_size = [size(Pb,2), size(Pb,2)];                                    %��ʼ���նȾ���
A1 = assemble_matrix_volume_in_2D('function_c',matrix_size,P,T,Pb,Tb,basis_type_trial,1,0,basis_type_test,1,0,Gauss_type);
A2 = assemble_matrix_volume_in_2D('function_c',matrix_size,P,T,Pb,Tb,basis_type_trial,0,1,basis_type_test,0,1,Gauss_type);
A = A1+A2;

%-----------------------��װ�Ҷ�����----------------------------------------%
%��װ�Ҷ�����
vector_size = size(Pb,2);                                                  %��ʼ���Ҷ�����
b = assemble_vector_2D_volume_in_2D('function_f',P,T,Pb,Tb,vector_size,basis_type_test,0,0,Gauss_type);

%----------------------����߽�����-----------------------------------------%
%����߽�����
%[ A, b ] = treat_Neumann_boundary( A, b, boundarynodes,'function_c','exact1',Pb);    
[A,b] = treat_Dirichlet_boundary(A, b, boundarynodes,'function_g',Pb);
%------------------------������Է�����-------------------------------------%
%������Է�����
solution = A\b;
%------------------------������-------------------------------------------%

%error = compute_error_on_nodes('exact',Pb,solution);
error=compute_inf_error('exact', solution,P,T,Tb, basis_type, 0,0);
inf_error = max(error);
L2_error=compute_Hs_error('exact', solution,P,T, Tb, basis_type, 0,0,Gauss_type);
H1_error1=compute_Hs_error('exact1', solution,P,T, Tb, basis_type, 1,0,Gauss_type);
H1_error2=compute_Hs_error('exact2', solution,P,T, Tb, basis_type, 0,1,Gauss_type);
H1_error=sqrt(H1_error1^2+H1_error2^2);
fprintf('%7.4e    %7.4e    %7.4e\n',inf_error,L2_error,H1_error);
end