function Kx = raideur(x,J)
global E;

k1 = (3*E*x(2)^4)/(12*x(1)^3);

L2= x(1)/sqrt(2);
k2 = (3*E*x(2)^4)/(12*L2^3);

%On calcule la matrice de raideur articulaire
Ktheta= [k1,0;0,k2];

% On trouve la matrice de raideur cartesienne
Kx = inv(J.')*Ktheta*J;
end