% Assuming:
% angle_mean : 1x1x31 array
% angle_std  : 1x1x31 array
% z          : 1x1x31 array

% Convert from 1x1x31 -> 31x1
angle_mean = squeeze(meanAngles);
angle_std  = squeeze(stddevAngles);
z          = squeeze(z);

% Make sure they are column vectors
angle_mean = angle_mean(:);
angle_std  = angle_std(:);
z          = z(:);

% Plot shaded error region
figure;

fill([z; flipud(z)], ...
     [angle_mean - angle_std; flipud(angle_mean + angle_std)], ...
     [0.7 0.7 1], ...
     'FaceAlpha', 0.3, ...
     'EdgeColor', 'none');

hold on;

% Plot mean curve
plot(z, angle_mean, 'b-', 'LineWidth', 2);

% Labels
xlabel('z');
ylabel('Angle');

box on;
hold off;