function A = assemble_matrix_volume_in_2D(matrix_size, coef, mesh, FE, der_trial_x,der_trial_y,der_test_x,der_test_y)
%������װ��,��Ҫ����ϵ������,�����С,P,T,Tb����,��̽�����Ļ��������ͼ���x,y�ĵ�����,���Ժ����Ļ��������ͼ�������
    A = sparse(matrix_size(1),matrix_size(2));
    P = mesh.P;
    T = mesh.T;
    Tb = FE.Tb;
    number_of_elements=size(T,2);%�õ���Ԫ����
    number_of_local_basis=get_number_of_local_basis(FE.basis_type_test);%�õ��ֲ��Ļ������ĸ���
    [Gauss_coefficient_reference_triangle,Gauss_point_reference_triangle]=generate_Gauss_reference_triangle(FE.Gauss_type);%�õ��ο���Ԫ�ĸ�˹Ȩϵ���͸�˹��
    for n=1: number_of_elements%ѭ��ÿ����Ԫ
        vertices=P(:,T(:,n));  %�õ�ÿ����Ԫ�ϵĵ������
        [Gauss_weight,Gauss_point]=generate_Gauss_local_triangle(Gauss_coefficient_reference_triangle,Gauss_point_reference_triangle,vertices);%�õ���ǰ�����ε�Ԫ�ĸ�˹Ȩϵ���͸�˹��
        for alpha = 1:number_of_local_basis%ѭ����̽����
            for beta = 1:number_of_local_basis%ѭ�����Ժ���
                int_value = Gauss_vol_int_trial_test_2D(coef,Gauss_weight,Gauss_point,vertices,FE.basis_type_trial,alpha,der_trial_x,der_trial_y,...
                                                                                               FE.basis_type_test,beta,der_test_x,der_test_y);%�����˹����
                A(Tb(beta,n),Tb(alpha,n))=A(Tb(beta,n),Tb(alpha,n))+int_value;
            end
        end
    end
end