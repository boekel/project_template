%% Unsere Erweiterung mit dem Charisma-Faktor
%  30.11.2013 13:45
%  Lukas
%% Initialization
% number of agents
N = 100;
% number of iterations
iter = 5000;
% convergence parameter
c = 0.002;
% u in [0, 1]
u = 0.35;

% initialize matrix with vectors of opinions
M = zeros(N, iter);
% opinions at the beginning
M(:, 1) = rand(N, 1);
% initialize charisma
gamma = rand(N, 1);

%% Calculation
for t=1:iter-1
   % shuffle the rows of the matrix
   newindex = randperm(size(M,1));
   M = M(newindex,:);
   gamma = gamma(newindex);
   % interactions
   % (we split the matrix in two halfs)
   half = N/2;
   for j=1:half
       if (abs(M(j, t) - M(j+half, t)) < u)
           delta = c*(M(j+half, t) - M(j,t));
           M(j, t+1) = M(j, t) + delta*((2*gamma(j+half))/(gamma(j)+gamma(j+half)));
           M(j+half, t+1) = M(j+half, t) - delta*((2*gamma(j))/(gamma(j)+gamma(j+half)));
       else
           M(j, t+1) = M(j, t);
           M(j+half, t+1) = M(j+half, t);
       end
   end
end

%% Plot
for i=1:N-1
    plot(M(i, :))
    hold on
end
plot(M(N, :));