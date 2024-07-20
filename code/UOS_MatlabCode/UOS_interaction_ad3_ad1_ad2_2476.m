% Set maximum simulation time to 20 seconds
maxSimulationTimeSec = 20;

% Configure the simulation object rrSim with the maximum simulation time
set(rrSim, 'MaxSimulationTime', maxSimulationTimeSec);

% Enable logging for the simulation
set(rrSim, 'Logging', 'On');

% Start the simulation
set(rrSim, 'SimulationCommand', 'Start');

% Define the interaction times and corresponding filenames
interactionTimes = [0.560, 5.120];
fileNames = {"Phase1PavementObject.csv", "Phase2PavementObject.csv"};
fields = {"field1", "field2"};
interactionIndex = 1;

% Wait for the simulation to reach specific times
while true
    % Get the current simulation time
    simTime = get(rrSim, 'SimulationTime');
    
    % Output the current simulation time
    fprintf('Current simulation time: %.3f seconds\n', simTime);
    
    % Check if the simulation time has reached the next interaction time
    if interactionIndex <= length(interactionTimes) && simTime >= interactionTimes(interactionIndex)
        % Pause the simulation
        set(rrSim, 'SimulationCommand', 'Pause');
        
        % Wait until the simulation is fully paused
        while ~strcmp(get(rrSim, 'SimulationStatus'), 'Paused')
            pause(1);
        end
        
        % Publish MQTT data from the corresponding file
        publishMQTTData(fileNames{interactionIndex}, fields{interactionIndex});
        
        % Move to the next interaction time
        interactionIndex = interactionIndex + 1;
        
        % Resume the simulation
        set(rrSim, 'SimulationCommand', 'Continue');
    end
    
    % Break the loop if all interactions are completed
    if interactionIndex > length(interactionTimes)
        break;
    end
    
    % Pause for a short time to avoid busy-waiting
    pause(0.1);
end

% Wait for the simulation to complete
while strcmp(get(rrSim, 'SimulationStatus'), 'Running')
    % Pause for 1 second to avoid busy-waiting
    pause(1);
    
    % Output the current simulation time while running
    simTime = get(rrSim, 'SimulationTime');
    fprintf('Current simulation time: %.3f seconds\n', simTime);
end

% Confirm end of simulation
fprintf('Simulation completed.\n');

% Function to execute MQTT publishing at the specified simulation time
function publishMQTTData(filename, field)
    try
        % 读取指定的CSV文件
        data = readtable(filename);

        % 设置AD3MQTT客户端参数
        clientID = "BQUYGQMkOzwEMg4CNxAaJDc";
        userName = "BQUYGQMkOzwEMg4CNxAaJDc";
        password = "fEdKNrcqgGSC4elXoAa/EF2e";
        rootCert = "C:\Users\zyj\Desktop\DigiCert Global Root G2.crt";
        brokerAddress = "ssl://mqtt3.thingspeak.com";
        port = 8883;

        % 创建MQTT客户端并连接到broker
        mqClient = mqttclient(brokerAddress, Port = port, ClientID = clientID, Username = userName, Password = password, CARootCertificate = rootCert);

        % 检查连接状态
        if mqClient.Connected
            fprintf('AD3: Successfully connected to MQTT broker at %s\n', brokerAddress);
        else
            error('AD3: Failed to connect to MQTT broker.');
        end

        % ThingSpeak Channel ID and field
        channelID = "2579802";
        topicToPublish = sprintf('channels/%s/publish/fields/%s', channelID, field);

        % 遍历每一行数据并发布到主题
        for i = 1:height(data)
            msg = jsonencode(table2struct(data(i,:)));
            write(mqClient, topicToPublish, msg);
            fprintf('AD3: Published message to %s: %s\n', topicToPublish, msg);
            pause(1); % 暂停1秒以避免消息拥堵
        end
    catch ME
        fprintf('AD3: An error occurred: %s\n', ME.message);
    end

    % 清除MQTT客户端
    clear mqClient;
end
