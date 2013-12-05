%shouder equation  y=-0.000000000008647*t^5 + 0.00000002114*t^4 + -0.00001727*t^3 +  0.004471*t^2 +  0.1979 *t +   -90.14
% start at 0-800
% elbow equation y = -1E-12x6 + 4E-09x5 - 6E-06x4 + 0.0047x3 - 1.7678x2 + 264.4x
% start at 620 - 974  180 at 695 - 925
% start at 400 - 1300

function matchData()
    a = 10;
    b2 = 10; 
    dataArray = zeros(1000,7);
    temp = 1; 
    err = 0;
    errSum2 = 0; 
    d = 2.5;
    c = 9;
    b = 2.5;
    K1 = d/a;
    %K2 = d/c;
    %K3 = ((a^2)-(b^2)+(c^2)+(d^2))/(2*a*c);
    K4 = d/b;
    K5 = ((c^2)-(d^2)-(a^2)-(b^2))/(2*a*b);
    for sigma = 30:1:60
        for a2 = 0.5:0.2:3
            for e = 8:0.25:9.75 
                for f = 0.5:0.2:3
                    for t = 0:1:500 
                        theta2 = -0.000000000008647*(t^5) + 0.00000002114*(t^4) - 0.00001727*(t^3) +  0.004471*(t^2) +  0.1979*t - 90.14; 
                        I = cosd(theta2);
                        %A = I-K1-K2*I+K3;
                        B = -2*sind(theta2); 
                        %C = K1-(K2-1)*I+K3;
                        D = I-K1+K4*I+K5;
                        F = K1+(K4-1)*I+K5;
                       % G = (B^2)-(4*A*C); 
                        H = (B^2) - (4*D*F);
                        theta3 = 2*atan2d(-B-sqrt(H),2*D);
                        %theta3 = angleBound(theta3);
                        theta6 = theta3 - sigma; 
                        K1B = a2/b2;
                        %K2 = a2/e;
                        %K3 = ((b2^2)-(f^2)+(e^2)+(a2^2))/(2*b2*e);
                        K4B = a2/f;
                        K5B = ((e^2)-(a2^2)-(b2^2)-(f^2))/(2*b2*f);
                        I = cosd(theta6);
                        %A = I-K1-K2*I+K3;
                        B = -2*sind(theta6); 
                        %C = K1-(K2-1)*I+K3;
                        D = I-K1B+K4B*I+K5B;
                        F = K1B+(K4B-1)*I+K5B;
                        % G = (B^2)-(4*A*C); 
                        H = (B^2) - (4*D*F);
                        if H < 0;
                            errSum2 = errSum2 + 1; 
                        else
                            theta7 = 2*atan2d(-B+sqrt(H),2*D);
                            %theta7 = angleBound(theta7); 
                            if t < 40 
                                dTheta7 = 16.5;
                            elseif t >= 40 
                                dTheta7 =  -0.000000004037*t +  0.000006638*t + -0.003932*t + 0.9682*t + - 16.07;
                            end
                            err = err + abs(theta7-dTheta7);
                        end  
                    end
                    dataArray(temp,1) = a2;
                    dataArray(temp,2) = e;
                    dataArray(temp,3) = f;
                    dataArray(temp,4) = sigma;
                    dataArray(temp,5) = err;
                    dataArray(temp,6) = errSum2;
                    temp = temp + 1;
                    err = 0;
                    errSum2 = 0; 
                end
            end
        end
        xlswrite('matchDataSixBarSome31.xlsx',dataArray);
    end
end

function newAngle = angleBound(angle)
    if angle < 0; 
        newAngle = angle+360;
    elseif angle > 360;
        newAngle = angle-360;
    else newAngle = angle;
    end
end
