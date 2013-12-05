function dataArray = plotData(filename)
    hold all;
    last = 0; 
    temp = 1; 
    i = 1; 
    plotAll = 0;
    plotAngle = 1;
    lastAngle = 90;
    dataArray = zeros(45000/8,1);
    data = xlsread(filename);
    while i < 45000
       if plotAll == 1   
           x = data(i,2);
           y = data(i,3);
           plot(x,y,'g');
           dataArray(1,temp) = x; 
           dataArray(2,temp) = y; 
           temp = temp + 1;
           x = data(i+1,2);
           y = data(i+1,3);
           plot(x,y,'r');
           dataArray(1,temp) = x; 
           dataArray(2,temp) = y; 
           temp = temp + 1;
           x = data(i+4,2);
           y = data(i+4,3);
           plot(x,y,'y');
           dataArray(1,temp) = x; 
           dataArray(2,temp) = y; 
           temp = temp + 1;
           x = data(i+5,2);
           y = data(i+5,3);
           plot(x,y,'b');
           dataArray(1,temp) = x; 
           dataArray(2,temp) = y; 
           temp = temp + 1;
           x = data(i+6,2);
           y = data(i+6,3);
           plot(x,y,'k'); 
           dataArray(1,temp) = x; 
           dataArray(2,temp) = y; 
           temp = temp + 1;
           x = data(i+6,2);
           y = data(i+6,3);
           %plot(x,y);
           dataArray(1,temp) = x; 
           dataArray(2,temp) = y; 
           temp = temp + 1;
           i = i + 8;
       end
       if plotAngle == 1
           % elbow angle 
           angle = getAngle(data,i+4,i+6,i+5,i+1); 
           plot(i,angle,'g');
           % shoulder angle
           angle = getAngle2(data,i+4,i+6);
           angle = 180 - angle;
           if angle < 0 
             angle = angle + 360;
           end
           plot(i,angle,'b'); 
           %wrist angle
           angle = getAngle(data,i+4,i+1,i+4,i+0);
           angle = 180 - angle; 
           plot(i,angle,'r');
           %error = abs(lastAngle - angle);
           %if error > 30
               %angle = lastAngle;
           %end
           %dataArray(temp,1) = real(angle); 
           %lastAngle = angle; 
           %temp = temp +1; 
           i = i + 8; 
       end
    end
    %xlswrite('angleDataE.xlsx',dataArray); 
end



function angle = getAngle(data, point1, point2, point3, point4)
    x1 = data(point1,2);
    y1 = data(point1,3);
    x2 = data(point2,2);
    y2 = data(point2,3);
    x3 = data(point3,2);
    y3 = data(point3,3);
    x4 = data(point4,2);
    y4 = data(point4,3);
    v1x = x1 - x2; % first vector components
    v1y = y1- y2;
    v2x = x4 - x3; % second vector componets
    v2y = y4- y3;
    mag1 = sqrt((v1x^2) + (v1y^2));
    mag2 = sqrt((v2x^2) + (v1y^2));
    dot = (v1x*v2x) + (v1y*v2y); 
    angle = acosd(dot/(mag1*mag2)); 
end
function angle = getAngle2(data, point1, point2)
    x1 = data(point1,2);
    y1 = data(point1,3); 
    x2 = data(point2,2);
    y2 = data(point2,3);
    vectorX = x2 - x1;
    vectorY = y2 - y1;
    angle = atan2d(vectorY,vectorX);
    if angle < 0 
        angle = angle + 360;
    end
end

function angle = getAngle3(data, point1, point2, point3)
    x1 = data(point1,2);
    y1 = data(point1,3);
    x2 = data(point2,2);
    y2 = data(point2,3);
    x3 = data(point3,2);
    y3 = data(point3,3);
    v1x = x2 - x1;
    v1y = y2 - y1; 
    v2x = x2 - x3;
    v2y = y2 - y3; 
end
    
    
    
    