function [ result ] = exact( x,t )
%EXACT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
result = exp(-pi^2*t)*cos(pi*x)+(1-cos(t));


end

