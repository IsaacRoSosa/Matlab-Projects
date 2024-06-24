clc;
clear all;
% Parámetros
% Parámetros
M = 0.1; %masa del iman
R = 1; %Radio de la espira
I = 2000; %Corriente
Niu = 3909; %Momento magnetico dipolar Niu_subzero = 4*pi*1e-7; %Permeabilidad al vacio g = 9.81; %gravedad
% Tiempo inicial y final
t0 = 0;
tf = 10;
% Paso de tiempo
dt = 0.01;
% Número de puntos
N = round((tf - t0) / dt);
% Vectores para almacenar los resultados t = zeros(N, 1);
z = zeros(N, 1);
v = zeros(N, 1);
a = zeros(N, 1);
% Condiciones iniciales
z(1) = 1; % Posición inicial
v(1) = 0; % Velocidad inicial
% Método de Runge-Kutta
for i = 1:N-1
 t(i+1) = t(i) + dt;
k1v = dt * (f(z(i), v(i), M, R, I, Niu, Niu_subzero) - g);
k1z = dt * v(i);
k2v = dt * (f(z(i) + k1z/2, v(i) + k1v/2, M, R, I, Niu, Niu_subzero) - g);
k2z = dt * (v(i) + k1v/2);
k3v = dt * (f(z(i) + k2z/2, v(i) + k2v/2, M, R, I, Niu, Niu_subzero) - g);
k3z = dt * (v(i) + k2v/2);
k4v = dt * (f(z(i) + k3z, v(i) + k3v, M, R, I, Niu, Niu_subzero) - g); k4z = dt * (v(i) + k3v);
v(i+1) = v(i) + (k1v + 2*k2v + 2*k3v + k4v) / 6;
z(i+1) = z(i) + (k1z + 2*k2z + 2*k3z + k4z) / 6;
a(i+1) = (v(i+1) - v(i)) / dt;
end
% Gráficos
figure;
subplot(3, 1, 1);
plot(t, z);
xlabel('Tiempo');
ylabel('Posición');
title('Posición vertical de la góndola');
%Grafica de Velocidad
subplot(3, 1, 2);
plot(t, v);
xlabel('Tiempo');
ylabel('Velocidad');
title('Velocidad de la góndola');
%Grafica de la aceleración
subplot(3, 1, 3);
plot(t, a);
xlabel('Tiempo');
ylabel('Aceleración');

title('Aceleración de la góndola');
function res = f(z, v, M, R, I, Niu, Niu_subzero)
res = ((3 * Niu * Niu_subzero * R^2 * I) / (2 * M)) * (z / (R^2 + z^2)^(5/2));
end
