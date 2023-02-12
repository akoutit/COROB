
function [theta1,theta2,err] = MGI(x,y,l1,l2)
    err=0;
      theta1=0;
      theta2=0;
    if (l1-l2<norm([x y]))&& norm([x y])<l1+l2
        err=1;

    
    Ctheta2 = -(x*x+y*y-l1*l1-l2*l2)/(2*l1*l2);
    Stheta2 = sqrt(1-Ctheta2*Ctheta2);
    s=1;
     if imag(Ctheta2)==0 && imag(Stheta2)== 0 
    theta2 = atan2(Stheta2,Ctheta2);
     s=0;
    end
    
    B1 = l1+l2*cos(theta2);
    B2 = l2*Stheta2;
    Ctheta1 = (B1*x-B2*y)/(l1*l1+l2*l2);
    Stheta1 = (B1*y-B2*x)/(l1*l1+l2*l2);
    if imag(Ctheta1)==0 && imag(Stheta1)==0 && s == 0
     theta1 = atan2(Stheta1,Ctheta1);
     end
    end   

end