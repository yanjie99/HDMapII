rrLog = get(rrSim,"SimulationLog");

% 获取数据
velocityAgent1 = get(rrLog,'Velocity','ActorID',1);
velocityAgent2 = get(rrLog,'Velocity','ActorID',2);
velocityAgent3 = get(rrLog,'Velocity','ActorID',3);
velocityAgent6 = get(rrLog,'Velocity','ActorID',6);
velocityAgent7 = get(rrLog,'Velocity','ActorID',7);
velocityAgent8 = get(rrLog,'Velocity','ActorID',8);
velocityAgent9 = get(rrLog,'Velocity','ActorID',9);
time = [velocityAgent2.Time];

% 计算速度
velMagAgent1 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent1);
velMagAgent2 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent2);
velMagAgent3 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent3);
velMagAgent6 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent6);
velMagAgent7 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent7);
velMagAgent8 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent8);
velMagAgent9 = arrayfun(@(x) norm(x.Velocity,2), velocityAgent9);

% 创建图
figure;
hold on;

% 颜色和线型的选择
colors = lines(7); % 使用Matlab自带的颜色方案
lineStyles = {'-', '--', ':', '-.', '-', '--', ':'};

% 绘制曲线
plot(time, velMagAgent1, 'Color', colors(1, :), 'LineStyle', lineStyles{1}, 'LineWidth', 2);
plot(time, velMagAgent2, 'Color', colors(2, :), 'LineStyle', lineStyles{2}, 'LineWidth', 2);
plot(time, velMagAgent3, 'Color', colors(3, :), 'LineStyle', lineStyles{3}, 'LineWidth', 2);
plot(time, velMagAgent6, 'Color', colors(4, :), 'LineStyle', lineStyles{4}, 'LineWidth', 2);
plot(time, velMagAgent7, 'Color', colors(5, :), 'LineStyle', lineStyles{5}, 'LineWidth', 2);
plot(time, velMagAgent8, 'Color', colors(6, :), 'LineStyle', lineStyles{6}, 'LineWidth', 2);
plot(time, velMagAgent9, 'Color', colors(7, :), 'LineStyle', lineStyles{7}, 'LineWidth', 2);

% 设置标题和轴标签
title('Agent Velocities from Lane Scale Traffic Control Scenario', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Time (sec)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Velocity (m/sec)', 'FontSize', 12, 'FontWeight', 'bold');

% 图例
legend({'Actor = AD1', 'Actor = CD1', 'Actor = AD2', 'Actor = CD3', 'Actor = AD3', 'Actor = CD2', 'Actor = AD4'}, ...
    'Location', 'best', 'FontSize', 10);

% 网格
grid on;

% 设置轴的外观
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1);

% 导出高分辨率图像
print('LSTCScenario AgentVelocitiesGraph', '-dpng', '-r300'); % 导出为300 DPI的PNG图片

hold off;
