function error = compute_error_on_nodes(exactso,Pb,solution)
%COMPUTE_ERROR_ON_NODES �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
for i =1:size(Pb,2)
exactsolution(i,1) = feval(exactso,Pb(:,i));
end
error=max(abs(solution-exactsolution));
end

