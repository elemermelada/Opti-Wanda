clc;
clear;
a=1;
b=0.7;
% x = [0:0.01:2];



% for i = 1:length(x);
% y(i) = b*sqrt(1-(x(i)/a-1)^2)*x(i)/a;
% end

% r=

% for i =1:length(x)
% r(i) = sqrt(x(i)^2+y(i)^2);
% th(i) = atan(y(i)/x(i));
% end
% for i=1:length(x)
% r(i+length(x)) = sqrt(x(i)^2+y(i)^2);
% th(i+length(x)) = -atan(y(i)/x(i));
% end



a = 1;
b = 5/2;

f=@(x) (b*((x)/a).*sqrt(1-(x-a).^2/a^2))

plot(0:0.1:5,f(0:0.1:5))
stop
th = [-pi/2:0.01:pi/2];
polarplot(th,f(cos(th)));

stop



t = linspace(0,2*pi,100)

for i =1:length(t)
x(i) = a*(1+sin(t(i)));
sin=(x-a)/a
y(i) = b*sqrt(1-((x-a)/a)^2)*(1+(x-a)/a);
end


a = 1;
b = 5/2;

t = linspace(0,2*pi,100)

for i =1:length(t)
x(i) = a*(1+sin(t(i)));
y(i) = b*cos(t(i))*(1+sin(t(i)));
end
