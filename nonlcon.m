function [C, Ceq]=nonlcon(x)
global F xm 

% x(1) = L1 longueur du bras 1
% x(2) = b côté de la section carrée
% x(3) = xc; x(4) = yc coordonnées du centre du carré qui constitue l'espace de travail 

% On contraint la position (xc,yc) a l'interieur de l'espace de travail
% On contraint pour l'instant cette position exactement sur la ligne
% mediane de l'espace de travail
a= 0.5*sqrt(2); %la diagonale du carré
C(1) = sqrt(x(3)^2+x(4)^2) + a/2 - (x(1) + x(1)/sqrt(2)); % La position du centre du cercle circonscrit au carré doit etre inferieure a l1+l2-a/2
C(2) = -sqrt(x(3)^2+x(4)^2) + a/2 + (x(1) - x(1)/sqrt(2)); % La position du centre du cercle circonscrit au carré doit etre superieure a l1-l2+a/2



k=1;
for i = -1:0.2:1
    for j = -1:0.2:1
% On calcule la jacobienne (necessaire pour la dexterite et la raideur)        
J= Jacob(x(3)+i*0.25,x(4)+j*0.25,x(1),x(1)/sqrt(2));

% On calcule la matrice de raideur cartesienne
Kx = raideur([x(1),x(2)],J);

%contrainte de raideur
C(1+2*k)=-xm + F/norm(Kx);

%contrainte de dexterite
C(2+2*k)= -1/cond(J) + 0.2;

k= k+1;
    end
end


Ceq = [];
end