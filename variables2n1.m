%% Вводные данные системы

dimension = 2; % число гармоник сигнала
r = 1.2; % параметр
alpha = [1,3]; % параметр
mu = 2; % параметр, влияет на скорость сходимости
zMax = 5; % максимум нормы оценки состояния z 
maxOmega = 10; % максимум нормы вектора оценённых частот 
eigenvalues = -[0.4 0.5 0.8 1 0.3]*2; % собств. числа A-LC
omegaLimiter = sqrt(dimension)*maxOmega;
initialOmega = [2,5]; % Подаваемая частота при t=0
initialTheta = [initialOmega(1)^2-alpha(1);...
    initialOmega(2)^2-alpha(2)]; % подаваемая производная вектора оценки частот при t=0

initialZ = [1*sin(0); 1*r^2*cos(0)/initialOmega(1);...
          1*sin(0); 1*r^2*cos(0)/initialOmega(2); 0]; % состояние z при t=0


A = zeros(2*dimension+1 , 2*dimension+1); % осциллятор

%G = zeros(2*dimension+1 , 2*dimension+1);


for k = 1:dimension
    %G(2*k-1:2*k, 2*k-1:2*k) = [0 omega_(k)^2/r^2; -r^2 0];
    A(2*k-1:2*k, 2*k-1:2*k) = [0 (r^2)*alpha(k); -r^2 0];
end


C = zeros(1, 2*dimension+1);
C(1:2:end) = 1;

L = (place(A',C',eigenvalues))'; % наблюдатель

delta = C*A;

bigGammaZ0 = zeros(2*dimension+1, dimension); 

%A = [0 r^2*alpha 0; -r^2 0 0; 0 0 0];
% Наблюдатель : A - LC: с L таким, что собственные числа{g_i} A-LC < 0
% Транспонируем : A' - L'C'


%% Переключатели
turn_mods_on = 0; % включить моды
freqSwitcher = 100; % момент включения модификации (в сек)
noiseSelector = 0; % 0 - шум. 1 - синус-помеха
noiseOrSwitch = 0; % 0 - noiseSelector. 1 - изменение сигнала
%% Сигналы
% исходный сигнал
amp = [1;1];
freq = [2;3];
bias = [0;0];
%bias = [1;1];
phase = [0;0];

% модификации
amp_M = [1;1];
freq_M = [1.8;3.2];
bias_M = [0;0];
phase_M = [0;0];
