% L������
% [-1, 1] x [-1, 1] �������������ȥ���½�[-1, 0] x [0, 1]������������
node = [1, 0; 1, 1; 0, 1; -1, 1; -1, 0; -1, -1; 0, -1; 0, 0]; %������������P����
elem = [1, 2, 8; 3, 8, 2; 8, 3, 5; 4, 5, 3; 7, 8, 6; 5, 6, 8]; %�������ӹ�ϵ��T����
showmesh(node, elem); axis on;
findelem(node, elem); %���������α��
findnode(node); %���ƽڵ���

% ���������3��һ�µ�ϸ��
for i = 1: 3
    [node, elem] = uniformrefine(node, elem);
end
showmesh(node, elem);