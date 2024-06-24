%%
% Javier Jorge Hernández Verduzco | A01722667
% Isaac Rojas Sosa | A01198693
% Felipe de Jesús García García |  A01705893
% Marcelo Carmona Alfaro | A01178015
clear;
clc;
% Crear Grid
N = 50; % Número de vectores en x y y
Xmin = -12;
Xmax = 12;
Ymin = -12;
Ymax = 12;
x = linspace(Xmin,Xmax, N); % Creación de vectores
y = linspace(Ymin,Ymax, N); % Creación de vectores
[X,Y] = meshgrid(x,y);  % Matriz / Malla
% Campo Eléctrico
k = 8.98e9; % Constante de Coulomb
Q = 30; % Carga de los cables
Nq = 30; % Número de cargas
w = 0.5; % Ancho de cada carga
Ex = zeros(N); % Inicializar componentes X del campo eléctrico
Ey = zeros(N); % Inicializar componentes Y del campo eléctrico
% Cable negativo
L_n = 4; % longitud del cable negativo
lambda_n = -Q/L_n; % densidad de carga lineal negativa
yn = linspace(-L_n/2,L_n/2,Nq); % posición y de las cargas del cable negativo
xQn_cable = w*ones(1,Nq); % posición x de las cargas del cable negativo
%Calculos
for i = 1:Nq
Rx = X - xQn_cable(i); % Distancia de entre punto de la malla a la carga negativa en X
Ry = Y - yn(i); % Distancia de entre punto de la malla a la carga negativa en Y
R = sqrt(Rx.^2 + Ry.^2).^3;
Ex = Ex + k .* (lambda_n) .* Rx ./R;
Ey = Ey + k .* (lambda_n) .* Ry ./R;
end
% Cable positivo
L_p = 4.3; % longitud del cable positivo
lambda_p = Q/L_p; % densidad de carga lineal positiva
yp = linspace(-L_p/2,L_p/2,Nq); % posición y de las cargas del cable positivo
xQp_cable = -w*ones(1,Nq); % posición x de las cargas del cable positivo
for i = 1:Nq
Rx = X - xQp_cable(i); % Distancia de entre punto de la malla a la carga positiva en X
Ry = Y - yp(i); % Distancia de entre punto de la malla a la carga positiva en Y
R = sqrt(Rx.^2 + Ry.^2).^3;
Ex = Ex + k .* (lambda_p).* Rx ./R;
Ey = Ey + k .* (lambda_p).* Ry ./R;
end
E = sqrt(Ex.^2 + Ey.^2);
% Componentes X
u = Ex./E;
% Componentes Y
v = Ey./E;
%Dibujar el campo y los cables
quiver(X,Y,u,v,'black', 'LineWidth',1); %Dibujar campo eléctrico
hold on
% Cable negativo
for i = 1:Nq
rectangle('Position',[xQn_cable(i)-w/2 yn(i)-L_n/(2*Nq) w L_n/Nq], 'Curvature',[1 1],'FaceColor','b');
end
% Cable positivo
for i = 1:Nq
rectangle('Position',[xQp_cable(i)-w/2 yp(i)-L_p/(2*Nq) w L_p/Nq], 'Curvature',[1 1],'FaceColor','r');
end
%Grafica la intensidad del campo eléctrico (cuando no se encuentra
%comentado)
figure (3)
hold on;
pcolor(x,y,E);colormap jet; shading interp;
h2 = streamslice(x,y,u,v,2);
set(h2,'Color',[1 1 1]);
set(h2, 'lineWidth', 1.5);
xlabel('eje-x');
ylabel('eje-y');
hold off;
