function include( path )
%INCLUDE ���������Լ��ĺ������ļ�
%   �˺�������������ǰ·������Ϊpath���ļ���
curdir = fileparts(mfilename('fullpath'));  %��ȡ��ǰ�������к�����·��

% fullfile��������ļ���ȫ��·��
% genpath�ݹ�Ĳ������ļ����������ļ���·��
% addpath·�����뵽�������ļ������ķ�Χ��
addpath(genpath(fullfile(curdir, path)));
end

