function b = assemble_vector_2D_volume_in_2D(vector_size, pde, mesh, FE, der_test_x,der_test_y, time)
%ASSEMBLE_VECTOR_1D_VOLUME_IN_1D �Ҷ�������װ��
%   �˴���ʾ��ϸ˵��
    b = zeros(vector_size,1);
    P = mesh.P;
    T = mesh.T;
    Tb = FE.Tb;
    number_of_elements=size(T,2);%�õ���Ԫ����
    number_of_local_basis=get_number_of_local_basis(FE.basis_type_test);%�õ����Ժ����ľֲ�����������
    [Gauss_coefficient_reference_triangle,Gauss_point_reference_triangle]=generate_Gauss_reference_triangle(FE.Gauss_type);%�õ��ο���Ԫ�ĸ�˹Ȩϵ���͸�˹��
    for n=1: number_of_elements%ѭ��ÿ����Ԫ
        vertices=P(:,T(:,n));%�õ�ÿ����Ԫ�ϵ������
        [Gauss_weight,Gauss_point]=generate_Gauss_local_triangle(Gauss_coefficient_reference_triangle,Gauss_point_reference_triangle,vertices);%�õ���ǰ��Ԫ�ĸ�˹Ȩϵ���͸�˹��
        for beta = 1:number_of_local_basis%ѭ�����Ժ����ľֲ�������
            int_value = Gauss_int_vector_test(pde.rhs, Gauss_weight, Gauss_point, vertices, FE.basis_type_test, beta, der_test_x, der_test_y, time);%�����˹����
             b(Tb(beta,n))=b(Tb(beta,n))+int_value;%�ӵ�ȫ�ֵ��Ҷ�������
        end
    end


end

