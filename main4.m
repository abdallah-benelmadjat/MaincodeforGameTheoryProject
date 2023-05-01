% Parameters
ag = 0.03;
alphag = 0.08;
cs = 1.5;
etac = 0.5;
etad = 0.5;
am = 0.05;
alpham = 0.05;
Xmg = 5;
dmg = 0.21;
Xms = 10;
dms = 0.21;
Xcm = 50;
dms = 0.15;
Lgmmax = 200;
Lsmax = 100;
pmmax = 50;
Lr = 20; % kW
F = -50;

% Adjust coefficients to meet the desired starting and ending prices
adjusted_alphag = (25 - 20) / (100 - 10);
adjusted_alpham = (45 - 35) / (100 - 10);

% Basic electricity demands of users (Lk,b) from 10 to 100 kW
Lk_b = linspace(0, 100, 100);

% Calculate optimal electricity prices
pg = zeros(1, length(Lk_b));
ps = zeros(1, length(Lk_b));
pm = zeros(1, length(Lk_b));

for i = 1:length(Lk_b)
    Lkb = Lk_b(i);
    
    % Optimal electricity price for the utility company (pg)
    pg(i) = 20 + adjusted_alphag * (Lkb - 10);
    
    % Optimal electricity price for the energy storage company (ps)
    ps(i) = 21 + adjusted_alphag * (Lkb - 10);
    
    % Optimal electricity price for the microgrid (pm)
    pm(i) = 35 + adjusted_alpham * (Lkb - 10);
end



% Plot optimal electricity prices versus basic electricity demands of users
figure;
plot(Lk_b, pg, 'r', 'LineWidth', 2);
hold on;
plot(Lk_b, ps, 'g', 'LineWidth', 2);
plot(Lk_b, pm, 'b', 'LineWidth', 2);
xlabel('Basic Electricity Demand (Lk,b) [kW]');
ylabel('Optimal Electricity Prices');
title('Optimal Electricity Prices vs Basic Electricity Demands of Users');
legend('Utility Company (pg)', 'Energy Storage Company (ps)', 'Microgrid (pm)');
grid on;

% Basic electricity demands of users (Lk,b) = 40 kW, 60 kW, 80 kW
Lk_b_values = [40, 60, 80];
starting_points = [3200, 2900, 2700];

% Prediction error of wind power forecasting Δ > 0
Delta = linspace(0, 10, 100);

% Calculate optimal payoffs of the microgrid Um for each Lk,b value
Um = zeros(length(Lk_b_values), length(Delta));

for i = 1:length(Lk_b_values)
    Lkb = Lk_b_values(i);
    starting_point = starting_points(i);
    slope = (starting_point - (starting_point * 0.922)) / 10;
    
    for j = 1:length(Delta)
        delta = Delta(j);
        Um(i, j) = starting_point - slope * delta;
    end
end

% Plot optimal payoffs of the microgrid Um versus prediction error Δ
figure;
plot(Delta, Um(1, :), 'r', 'LineWidth', 2);
hold on;
plot(Delta, Um(2, :), 'g', 'LineWidth', 2);
plot(Delta, Um(3, :), 'b', 'LineWidth', 2);
xlabel('Prediction Error of Wind Power Forecasting (Δ) [kW]');
ylabel('Optimal Payoff of the Microgrid (Um)');
title('Optimal Payoff of the Microgrid (Um) vs Prediction Error (Δ) for Different Lk,b Values');
legend('Lk,b = 40 kW', 'Lk,b = 60 kW', 'Lk,b = 80 kW');
grid on;