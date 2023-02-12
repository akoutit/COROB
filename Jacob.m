function J = Jacob(x,y,l1,l2)

[theta1,theta2,err] = MGI(x,y,l1,l2);

if err==1
%on calcule les vecteurs unitaires des bras du robot
u1 =[cos(theta1); sin(theta1)];
u2 =[cos(theta1+theta2); sin(theta1+theta2)];

%On calcule la jacobienne
R = [[0 -1];
    [1 0]];
L= [[l1 0];
    [l2 l2]];
J=[R*u1 R*u2]*L;
end
end

