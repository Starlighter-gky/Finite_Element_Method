function [ result ] = exact2( x,y )
%EXACT2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
result = (x-2*x*y-0.5*x^2+x^2*y)*exp(x+y)+(x*y-x*y^2-0.5*x^2*y+0.5*x^2*y^2)*exp(x+y);

end

