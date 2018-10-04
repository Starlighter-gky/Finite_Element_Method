function  error = compute_error( pde, FE, final )
%COMPUTE_ERROR �˺���Ϊ������ģ��
%   �˴���ʾ��ϸ˵��
%   ������
inf_error1 = compute_inf_error(pde.exact_solution, pde.solution, FE, 0, final);      %������������
inf_error = max(inf_error1);
L2_error = compute_Hs_error(pde.exact_solution, pde.solution, FE, 0, final);         %����L2�������
H1_semi_error = compute_Hs_error(pde.gradient, pde.solution, FE, 1, final);          %����H1�뷶���
error = [inf_error, L2_error, H1_semi_error];
fprintf('%7.4e  %7.4e  %7.4e\n',inf_error,L2_error,H1_semi_error);
end

