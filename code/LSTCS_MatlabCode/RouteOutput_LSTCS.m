hdMap = getMap(rrSim);
lanes = hdMap.map.lanes;

figure;
hold on;

% 颜色和线型的选择
colors = lines(7); % 使用Matlab自带的颜色方案，为7个actor分配颜色
lineStyles = {'-', '--', ':', '-.', '-', '--', ':'}; % 线型数组，应包含7个元素

% 绘制道路
plotHandles = []; % 用于存储绘图句柄
plotHandles(end+1) = plot(NaN, NaN, 'k', 'LineWidth', 1); % 用于图例的占位符

for i = 1:numel(lanes)
    control_points = lanes(i).geometry.values;
    x_coordinates = arrayfun(@(cp) cp.x, control_points);
    y_coordinates = arrayfun(@(cp) cp.y, control_points);
    plot(x_coordinates, y_coordinates, 'k', 'LineWidth', 1, 'Color', [0, 0, 0, 0.2]); % 道路使用黑色
end

% 绘制actor轨迹
actorIDs = [1, 2, 3, 6, 7, 8, 9];
actorLabels = {'Actor: AD1', 'Actor: CD1', 'Actor: AD2', 'Actor: CD3', 'Actor: AD3', 'Actor: CD2', 'Actor: AD4'};
for i = 1:length(actorIDs)
    poseActor = rrLog.get('Pose', 'ActorID', actorIDs(i));
    position_x = arrayfun(@(x) x.Pose(1,4), poseActor);
    position_y = arrayfun(@(x) x.Pose(2,4), poseActor);
    plotHandles(end+1) = plot(position_x, position_y, 'Color', colors(i, :), 'LineStyle', lineStyles{i}, 'LineWidth', 2);
end

% 设置标题和轴标签
title('Agent Positions from Lane Scale Traffic Control Scenario', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('X (m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Y (m)', 'FontSize', 12, 'FontWeight', 'bold');

% 图例
legend(plotHandles, {'Road: Lane', actorLabels{:}}, 'Location', 'best', 'FontSize', 10);

% 设置轴的比例和网格
axis equal;
grid on;

% 设置轴的外观
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1);

% 导出高分辨率图像
print('AgentPositionsGraph_LSTCS', '-dpng', '-r300'); % 导出为300 DPI的PNG图片

hold off;
