function [pde, FE] = Heat_Solver_1D( pde, FE, initial, final, dt, theta)
% һά�ȷ��������
% ��Ҫ�����������ʽ�ķ���
% $u_t-\nabla \cdot c(x) \nabla u(x) = f(x),a\le x\le b$
%$u(a)=g_a$,
%$u'(b)+q_bu(b)=p_b$
Mt = (final - initial)/dt;
Pb = FE.Pb;
boundarynodes = FE.boundarynodes;                                      %����������
%------------------------------��װ��--------------------------------------%
%������װ��
matrix_size = [size(Pb,2), size(Pb,2)];                                    %�նȾ���Ĵ�С
x_now = generate_initial_vector(pde, Pb, initial);
vector_size = size(Pb, 2);                                                 %�Ҷ������Ĵ�С
for i = 0: 1: Mt-1
    t = initial+(i+1)*dt;
    M = assemble_matrix_volume_1D(pde.coefficient1 , FE, matrix_size, 0, 0, t-dt);
    %-----------------------------������װ��--------------------------------%
    A_now = assemble_matrix_volume_1D(pde.coefficient2, FE, matrix_size, 1, 1, t-dt);
    A_next = assemble_matrix_volume_1D(pde.coefficient2, FE, matrix_size, 1, 1, t);
    %������װ��
    b_now = assemble_vector_1D(pde.right_hand_side, FE, vector_size, 0, t-dt);
    b_next = assemble_vector_1D(pde.right_hand_side, FE, vector_size, 0, t);
    %----------------------------�����Է�����-------------------------------%
    A_tilde = M/dt + theta*A_next;
    b_tilde = theta*b_next+(1-theta)*b_now+M/dt*x_now-(1-theta)*A_now*x_now;
    %----------------------------����߽�����-------------------------------%
    [A_tilde, b_tilde] = treat_Dirichlet_boundary(A_tilde, b_tilde, boundarynodes, pde.exact_solution, Pb, t);           %����Dirichlet�߽�
    x_next = A_tilde\b_tilde;
    x_now = x_next;
end
solution  = x_next;
pde.solution = solution;
end