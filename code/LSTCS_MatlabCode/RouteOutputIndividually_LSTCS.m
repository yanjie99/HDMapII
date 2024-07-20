hdMap = getMap(rrSim);
lanes = hdMap.map.lanes;

% 获取actor数据
actorIDs = [1, 2, 3, 6, 7, 8, 9];
actorLabels = {'AD1', 'CD1', 'AD2', 'CD3', 'AD3', 'CD2', 'AD4'}; % 去掉冒号
colors = lines(7); % 使用Matlab自带的颜色方案

% 绘制每个actor的轨迹
for i = 1:length(actorIDs)
    figure;
    hold on;
    
    % 绘制道路
    roadHandle = plot(NaN, NaN, 'k', 'LineWidth', 1); % 占位符句柄
    for j = 1:numel(lanes)
        control_points = lanes(j).geometry.values;
        x_coordinates = arrayfun(@(cp) cp.x, control_points);
        y_coordinates = arrayfun(@(cp) cp.y, control_points);
        plot(x_coordinates, y_coordinates, 'k', 'LineWidth', 1, 'Color', [0, 0, 0, 0.2]); % 道路使用黑色
    end
    
    % 绘制actor轨迹
    poseActor = rrLog.get('Pose', 'ActorID', actorIDs(i));
    position_x = arrayfun(@(x) x.Pose(1,4), poseActor);
    position_y = arrayfun(@(x) x.Pose(2,4), poseActor);
    actorHandle = plot(position_x, position_y, 'Color', colors(i, :), 'LineStyle', '-', 'LineWidth', 2);
    
    % 设置标题和轴标签
    title(['Position of ' actorLabels{i} ' from Lane Scale Traffic Control Scenario'], 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('X (m)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Y (m)', 'FontSize', 12, 'FontWeight', 'bold');
    
    % 图例
    legend([roadHandle, actorHandle], {'Road: Lane', actorLabels{i}}, 'Location', 'best', 'FontSize', 10);
    
    % 设置轴的比例和网格
    axis equal;
    grid on;
    
    % 设置轴的外观
    set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1);
    
    % 导出高分辨率图像
    print(['LSTCS_AgentPositionsGraph_' actorLabels{i}], '-dpng', '-r300'); % 导出为300 DPI的PNG图片
    
    hold off;
end



