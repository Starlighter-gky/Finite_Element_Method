function A = assemble_matrix_volume_in_1D(coe_fun,matrix_size,P,T,Pb,Tb,basis_type_trial,der_trial,basis_type_test,der_test,Gauss_type)
    A = zeros(matrix_size(1),matrix_size(2));%��ʼ���նȾ���
    number_of_elements=size(T,2);            %T�������������Ԫ����
    number_of_local_basis=get_number_of_local_basis(basis_type_test);%�ֲ��������ĸ���
    for n=1: number_of_elements              %ѭ��ÿ����Ԫ
        vertices=P(:,T(:,n));                %�õ�ÿ����Ԫ��Ӧ�Ľڵ����꣬����������Ҷ˵�����
        [Gauss_weight,Gauss_point]=generate_Gauss_formula(vertices,Gauss_type);%�õ�������ĸ�˹��͸�˹Ȩϵ��
        for alpha = 1:number_of_local_basis                           %ѭ�����Ժ�����test function��
            for beta = 1:number_of_local_basis                        %ѭ����̽����(trial function)
                %�����˹���֣���Ҫ�����˹�㣬��˹Ȩ����̽�������ͼ������ף����Ժ������ͼ��������Լ������ǵڼ����ֲ�������
                int_value = Gauss_vol_int_trial_test(coe_fun,Gauss_weight,Gauss_point,vertices,basis_type_trial,alpha,der_trial,...
                                                                                               basis_type_test,beta,der_test);
                %��ÿһ�εĽ�������ܸնȾ�����Tb�����ҵ��������ܸնȾ����λ��
                A(Tb(beta,n),Tb(alpha,n))=A(Tb(beta,n),Tb(alpha,n))+int_value;
            end
        end
    end
end