% Initialisation
clear all
close all
clc

% Choix du materiau
global E rho 
E = 210*10^9 ; % 210 GPa pour l'acier, 70 pour l'aluminium
rho = 7850 ; % 7850 kg/m^3 pour l'acier, 2800 pour l'alu

%contrainte de raideur
global F xm
F= 100; %[N]
xm = 10^-4; %[m]

% Optimisation
% x = [l1 h1 xc yc]

A = [];
b = [];
Aeq = [];
beq = [];
lb = [0.5 0 0 0];
ub = [1 0.1 2 2];

options=optimset('Display','iter', 'maxiter',400,'MaxFunEvals',600,'TolFun',1e-8, 'TolX',1e-8);
x = fmincon('obj',[0.9 0.09 0.8 0.1], A, b, Aeq, beq, lb, ub, 'nonlcon', options);



l1 = x(1);
l2 = l1/sqrt(2);

qmin = -pi;
qmax = pi;

figure;

Xvec = [];
Yvec = [];
for q1 = qmin:0.05:qmax
    for q2 = qmin:0.05:qmax
        X = l1*cos(q1)+l2*cos(q1+q2);
        Y = l1*sin(q1)+l2*sin(q1+q2);
        Xvec = [Xvec; X];
        Yvec = [Yvec; Y];
    end
end
plot(Xvec, Yvec, '* y');
  title('Solution optimale');
 rectangle('Position',[x(3)-0.25 x(4)-0.25 0.5 0.5],'EdgeColor','k','FaceColor',[0 .5 .5]);

f2=figure;
J=Jacob(x(3),x(4),l1,l2);
%à utiliser pour voir les contraintes dans l'espace de travail

%x_= x(3)-0.25:0.01:x(3)+0.25; 
%y_= x(4)-0.25:0.01:x(4)+0.25;

%à utiliser pour voir le contraintses dans l'espace ateignable

x_=-(l1+l2):0.01:(l1+l2);
y_=-(l1+l2):0.01:(l1+l2);


[X,Y] = meshgrid(x_,y_);
R=zeros(size(X));
for i=1:size(X,1)
    for j=1:size(X,2)
        x1=X(i,j);
        y1=Y(i,j);
        R(i,j)=NaN;
        [theta1,theta2,err] = MGI(x1,y1,l1,l2);
        if err==1
        J=Jacob(x1,y1,l1,l2);
        Kx = raideur([x(1),x(2)],J);
       
        R(i,j)=-xm + F/norm(Kx);
        end
    end
end
    
contourf(X,Y,R);
colorbar;
 title('contrainte de raideur' )
rectangle('Position',[x(3)-0.25 x(4)-0.25 0.5 0.5],'EdgeColor','k');
figure;
R=zeros(size(X));
X1=X;
Y1=Y;
R1=R;
li=[];
lj=[];

for i=1:size(X,1)
    for j=1:size(X,2)
        x1=X(i,j);
        y1=Y(i,j);
        R(i,j)=NaN;
        [theta1,theta2,err] = MGI(x1,y1,l1,l2);
        if err==1
            J=Jacob(x1,y1,l1,l2);
            R(i,j)=-1/cond(J) + 0.2;

        end
    end
        
end
    
contourf(X,Y,R);
colorbar;
 title('contrainte de dextrité' )
rectangle('Position',[x(3)-0.25 x(4)-0.25 0.5 0.5],'EdgeColor','k');
