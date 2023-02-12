function f=obj(x)
global rho
%on veut minimiser la masse du robot
f = rho*x(2)*x(2)*x(1)*(1+sqrt(2)/2);
end