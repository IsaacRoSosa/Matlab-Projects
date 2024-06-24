%Realizamos la matriz para poder calcular los coeficientes
y1=2300; y2=2400; x1=300;x2=2800; x3= 600; y3= 4200; x4= 2200; y4= 300;
x1a=x1^3; x1b=x1^2; x1c=x1; x1d=1; x2a=x2^3;x2b=x2^2;x2c=x2;x2d=1; x3a=x3^3;x3b=x3^2;x3c=x3;x3d=1; x4a=x4^3;x4b=x4^2;x4c=x4;x4d=1;
A = [x1a x1b x1c x1d;
      x3a x3b x3c x3d;
      x4a x4b x4c x4d;
      x2a x2b x2c x2d;];
y = [y1; y3; y4;y2;];
x = inv(A)*y; 
coef=x;

%Función polinómica de 3er grado
yf = @(z) coef(1).*z.^3 + coef(2).*z.^2 + coef(3).*z + coef(4);
%Derivada de la función
dyf = @(z) 3*coef(1).*z.^2 + 2*coef(2).*z + coef(3);
%Segunda derivada de la función
dy2f = @(z) 6*coef(1).*z + 2*coef(2);

%Calculamos la longitud de la curva
ker = @(x) (1 + (dyf(x)).^2).^(1/2);
long = integral(ker, 300, 2800);

%Sacamos puntos máximos y mínimos
x01 = 780 ;
x02 = 2200;
zero1 = fzero(dyf,x01);
zero2 = fzero(dyf,x02);

%Calculamos los radios de curvatura
curvatura1  = (1 + (3.*coef(1).*zero1.^2+2.*coef(2).*zero1+coef(3)).^2).^(3/2) / ((6*coef(1)*zero1) + 2*coef(2));
curvatura2  = (1 + (3.*coef(1).*zero2.^2+2.*coef(2).*zero2+coef(3)).^2).^(3/2) / ((6*coef(1)*zero2) + 2*coef(2));
%Calculamos las y en ambos extremos locales
ymax = coef(1)*zero1.^3 + coef(2)*zero1.^2 + coef(3)*zero1 + coef(4);
ymin = coef(1)*zero2.^3 + coef(2)*zero2.^2 + coef(3)*zero2 + coef(4);
%zona critica de la primera curva
xcrit1 = zero1 - 35.5; %curvatura  -100.3314
xcrit2 = zero1 + 30; %curvatura -100.6128
%Calculamos las coordenadas de y de la zona critica
ycrit1 =  coef(1)*xcrit1.^3 + coef(2)*xcrit1.^2 + coef(3)*xcrit1 + coef(4);
ycrit2 = coef(1)*xcrit2.^3 + coef(2)*xcrit2.^2 + coef(3)*xcrit2 + coef(4);
%Verificamos que el radio de curvatura no sea menor a 100
%curvatura3  = (1 + (3.coef(1).(zero1+30).^2+2.coef(2).(zero1+30)+coef(3)).^2).^(3/2) / ((6*coef(1)*(zero1 +30)) + 2*coef(2));
%curvatura4  = (1 + (3.coef(1).(zero1-35.5).^2+2.coef(2).(zero1-35.5)+coef(3)).^2).^(3/2) / ((6*coef(1)*(zero1 -35.5)) + 2*coef(2));

%Zona critica de la segunda curva 
xcrit3 = zero2 + 35.5; %curvatura 100.6128
xcrit4 = zero2 - 30; %curvatura 100.3314
%Calculamos las coordenadas de y de la zona critica
ycrit3 =  coef(1)*xcrit3.^3 + coef(2)*xcrit3.^2 + coef(3)*xcrit3 + coef(4);
ycrit4 = coef(1)*xcrit4.^3 + coef(2)*xcrit4.^2 + coef(3)*xcrit4 + coef(4);
%Verificamos que el radio de curvatura no sea menor a 100
%curvatura5  = (1 + (3.coef(1).(zero2+35.5).^2+2.coef(2).(zero2+35.5)+coef(3)).^2).^(3/2) / ((6*coef(1)*(zero2 +35.5)) + 2*coef(2));
%curvatura6  = (1 + (3.coef(1).(zero2-30).^2+2.coef(2).(zero2-30)+coef(3)).^2).^(3/2) / ((6*coef(1)*(zero2 - 30)) + 2*coef(2));

%Definimos el tramo de la curva
zv=linspace(300,2800,5000);
% Hacemos la linea tangente
lin_tang = @(z) dyf(z).*(zv - z) + yf(z);
xx = 805.13;
xx2 = 2247.8;


veluser = input("Introduce la velocidad: ");


%velocidad maxima en las curvas
%teniendo en cuenta que el coeficiente de friccion estática es de .9
vmax1=sqrt(9.81*curvatura1*-1*.9);
vmax2=sqrt(9.81*curvatura2*.9);

%energía perdida en calor al derrapar
m=800;
calor1=(m/2)*veluser;

%distancia recorrida al derrapar
%teniendo en cuenta que la fricción cinética es de .4
dmax1=(vmax1.^2/(2*9.81*.4))*-1;
dmax2=vmax2.^2/(2*9.81*.4);

estado = 1;

for x = 805:871
    eq_cur = @(x) ((1 + (dy2f(x).^2)).^(3/2))/abs(dy2f(x));
    vmax(x) = sqrt(9.81 *  eq_cur(x) * 0.9);

    if veluser > vmax(x)
        disp("EL AUTO DERRAPO")
        dmax = veluser.^2/(2*9.81*.4);
        disp("La distancia recorrida al derrapar es: " + dmax);
        disp("La energía perdida como calor es de: " + calor1);
        estado = estado + 1;
        plot(zv, lin_tang(x), 'g')
        hold on
        dreccorido = 805 + dmax;
        break
    end
end 


zv1=linspace(805.13,2800,5000);
zv2=linspace(2247.8,2800,5000);
%Definimos la primera zona critica
z1 = linspace(805.13,870.63);
%Definimos la segunda zona critica
z2 = linspace(2247.8,2313.3);
%Le damos el estilo a la funcion para que sea similar a una pista
plot(zv,yf(zv),'-k','LineWidth',12)
hold on
plot(zv,yf(zv),'w','LineWidth',3, 'LineStyle','--')
hold on
plot(z1,yf(z1),'y','LineWidth',12)
hold on
plot(z2,yf(z2),'y','LineWidth',12)
hold on
%Graficamos los puntos Iniciales y los otros 2
plot(x1,y1,'r-o')
hold on
plot(x2,y2,'r-o')
hold on
plot(x3,y3,'r-o')
hold on
plot(x4,y4,'r-o')
% Graficamos las lineas tangentes
% plot(zv, lin_tang(xx), 'r')
% hold on
% plot(zv, lin_tang(xx2), 'r')
% hold on
%Graficamos Extremos locales
plot(zero1,ymax,'r-o')
hold on
plot(zero2,ymin,'r-o')
hold on
%Graficamos los puntos que definan la primera zona de derrape
plot(xcrit1,ycrit1,'r-o')
hold on
plot(xcrit2,ycrit2,'r-o')
hold on
%Graficamos los puntos que definan la segunda zona de derrape
plot(xcrit3,ycrit3,'r-o')
hold on
plot(xcrit4,ycrit4,'r-o')
hold on

%Graficamos la primer grada
grada1 = patch([805 885 885 805 805],[4617.93 4617.93 4627.93 4627.93 4617.93], [.5 0 .5]);
%Rotarlo usando el vertice inferior izquierdo con la función "rotate"
rotate(grada1, [0 0 1], 25, [805 4617.93 0]) 
hold on
%Graficamos la segunda grada
grada2 = patch([2247.8 2327.8 2327.8 2247.8 2247.8],[248.8 248.8 238.8 238.8 248.8], [.5 0 .5]);
rotate(grada2, [0 0 1], -22, [2247.8 248.8 0]) 
hold on


%Desplegamos los datos de los coeficientes
disp("Coeficiente 1 " + coef(1));
disp("Coeficiente 2 " + coef(2));
disp("Coeficiente 3 " + coef(3));
disp("Coeficiente 4 " + coef(4));
%Desplegamos la longitud de la curva
disp("longitud " +  long);
%Desplegamos los radios de curvatura de ambas curvas
disp("curvatura 1 " + curvatura1);
disp("curvatura 2 " + curvatura2);
%Desplegamos la informar de los extremos locales
disp("xmin " + zero1);
disp("xmax " + zero2);
disp("Y min " + ymin );
disp("Y max " + ymax );

xlabel('X')
ylabel('Y')
title('Fragmento de pista Formula 1')


string1 = "Velocidad: " + veluser + 'm/s';
string2 = "No hay Perdida de Calor";
string3 = "La energía perdida como calor es de : " + calor1;
string4 = "La distancia recorrida al derrapar es : " + dmax + "m";
string5 = "Longitud de la pista: " + long + "m";
string6 = "Radio Curvatura1: " + curvatura1;
string7 = "Radio Curvatura2: " + curvatura2;


%Mostramos información sobre el vehiculo
text(2000,3850, string1)
text(2000,3700,"No hay aceleración", "FontSize",10)

%Mostramos información sobre la pista
text(2000,4650,string5)
text(2000,4400,string6)
text(2000,4250,string7)



%Animacion 
p = plot(x(1),y(1),'o','MarkerFaceColor','red');

hold off
axis manual
if estado == 1
    text(2000,3550,string2)

    for f = 300:2800
        p.XData = f;
        p.YData = yf(f);
         drawnow
        
    end
    text(2000,3400,"No hubo derrape")
end
contador = 0;
%Caso de derrape
if estado == 2
    text(2000,3550,string3)
    text(2000,3400,string4)

    for f = 300:805
        p.XData = f;
        p.YData = yf(f);
         drawnow
    if f == 805
    for l = 805:dmax+804
        contador = contador +1;
        p.XData = l;
        p.YData = 4597.77+(0.4500*(contador));
         drawnow

    end
    end
    end
        
    text(1000,5500,"DERRAPO","FontSize",40,"Color",'r')
end