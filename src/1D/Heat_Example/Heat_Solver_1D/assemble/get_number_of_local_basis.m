function [ result ] = get_number_of_local_basis( basis_type )
%GET_NUMBER_OF_LOCAL_BASIS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if basis_type==101
    result=2;
elseif basis_type==102
    result=3;
else
    warning='no such basis type'
end
end

