function [ result ] = exact1( x,y )
%EXACT1 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
result = (y-y^2-x*y+x*y^2)*exp(x+y)+(x*y-x*y^2-0.5*x^2*y+0.5*x^2*y^2)*exp(x+y);

end

