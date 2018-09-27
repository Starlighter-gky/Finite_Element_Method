function [result] = Poisson_solver_2D(pde, mesh, FE)
% ��άpossion���������
interval_x=[mesh.left mesh.right];
interval_y=[mesh.bottom mesh.top];
h=[mesh.hx,mesh.hy];
basis_type = FE.basis_type_trial;
Nx=(interval_x(2)-interval_x(1))/h(1);
Ny=(interval_y(2)-interval_y(1))/h(2);
[mesh.P, mesh.T] = generate_PT_2D(interval_x, interval_y, h, basis_type); %��������ڵ㼰���
[FE.Pb, FE.Tb] = generate_PbTb_2D(mesh.P, mesh.T, basis_type);                               %��������Ԫ�ڵ㼰���
Tb = FE.Tb;
boundaryedges = generate_boundaryedges_2D_triangle(Nx,Ny);                 %���ɱ߽��
boundarynodes = generate_boundarynodes_2D_triangle(Nx,Ny);                 %���ɱ߽��

%-----------------------��װ�նȾ���----------------------------------------%
%��װ�նȾ���
matrix_size = [size(FE.Pb,2), size(FE.Pb,2)];                                    %��ʼ���նȾ���
A1 = assemble_matrix_volume_in_2D(matrix_size, pde, mesh, FE, 1, 0, 1, 0);
A2 = assemble_matrix_volume_in_2D(matrix_size, pde, mesh, FE, 0, 1, 0, 1);
A = A1+A2;

%-----------------------��װ�Ҷ�����----------------------------------------%
%��װ�Ҷ�����
vector_size = size(FE.Pb,2);                                                  %��ʼ���Ҷ�����
b = assemble_vector_2D_volume_in_2D(vector_size, pde, mesh, FE, 0,0);

%----------------------����߽�����-----------------------------------------%
%����߽�����
%[ A, b ] = treat_Neumann_boundary( A, b, boundarynodes,'function_c','exact1',Pb);    
[A,b] = treat_Dirichlet_boundary(A, b, boundarynodes,pde.bdry.u_dirichlet,FE.Pb);
%------------------------������Է�����-------------------------------------%
%������Է�����
solution = A\b;
%------------------------������-------------------------------------------%
result.solution = solution;
%error = compute_error_on_nodes('exact',Pb,solution);
P = mesh.P;
T = mesh.T;
error=compute_inf_error(pde.exact_sol.u, solution,P,T,Tb, basis_type, 0,0);
inf_error = max(error);
L2_error=compute_Hs_error(pde.exact_sol.u, solution,P,T, Tb, basis_type, 0,0,FE.Gauss_type);
H1_error1=compute_Hs_error(pde.exact_sol.u_x, solution,P,T, Tb, basis_type, 1,0,FE.Gauss_type);
H1_error2=compute_Hs_error(pde.exact_sol.u_y, solution,P,T, Tb, basis_type, 0,1,FE.Gauss_type);
H1_error=sqrt(H1_error1^2+H1_error2^2);
result.error.L_inf = inf_error;
result.errorl.L2 = L2_error;
result.error.H1 = H1_error;
end