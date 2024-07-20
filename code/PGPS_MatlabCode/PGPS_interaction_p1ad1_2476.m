% Set maximum simulation time to 20 seconds
maxSimulationTimeSec = 20;

% Configure the simulation object rrSim with the maximum simulation time
set(rrSim, 'MaxSimulationTime', maxSimulationTimeSec);

% Enable logging for the simulation
set(rrSim, 'Logging', 'On');

% Start the simulation
set(rrSim, 'SimulationCommand', 'Start');

% Function to execute MQTT publishing at the specified simulation time
function publishMQTTData(filename)
    % 读取指定的CSV文件
    data = readtable(filename);

    % 设置MQTT客户端参数
    clientID = "KSkHCCQpDyUJOggzDhA7KCY";
    userName = "KSkHCCQpDyUJOggzDhA7KCY";
    password = "8yC2996eX6zlFHIkzBU0AoFc";
    rootCert = "C:\Users\zyj\Desktop\DigiCert Global Root G2.crt";
    brokerAddress = "ssl://mqtt3.thingspeak.com";
    port = 8883;

    % 创建MQTT客户端并连接到broker
    mqClient = mqttclient(brokerAddress, Port = port, ClientID = clientID, Username = userName, Password = password, CARootCertificate = rootCert);

    % 检查连接状态
    if mqClient.Connected
        fprintf('P1: Successfully connected to MQTT broker at %s\n', brokerAddress);
    else
        error('P1: Failed to connect to MQTT broker.');
    end

    % ThingSpeak Channel ID and field
    channelID = "2579802";
    field = "field2";
    topicToPublish = sprintf('channels/%s/publish/fields/%s', channelID, field);

    % 遍历每一行数据并发布到主题
    for i = 1:height(data)
        msg = jsonencode(table2struct(data(i,:)));
        write(mqClient, topicToPublish, msg);
        fprintf('P1: Published message to %s: %s\n', topicToPublish, msg);
        pause(1); % 暂停1秒以避免消息拥堵
    end

    % 清除MQTT客户端
    clear mqClient;
end

% Define the interaction times and corresponding filenames
interactionTimes = [1.840, 2.680, 4.000];
fileNames = {"Phase1PavementObject.csv", "Phase2PavementObject.csv", "Phase3PavementObject.csv"};
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
        publishMQTTData(fileNames{interactionIndex});
        
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
end

% Confirm end of simulation
fprintf('Simulation completed.\n');
