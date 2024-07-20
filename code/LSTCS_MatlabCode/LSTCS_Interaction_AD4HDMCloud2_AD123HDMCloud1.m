% Set maximum simulation time to 20 seconds
maxSimulationTimeSec = 20;

% Configure the simulation object rrSim with the maximum simulation time
set(rrSim, 'MaxSimulationTime', maxSimulationTimeSec);

% Enable logging for the simulation
set(rrSim, 'Logging', 'On');

% Start the simulation
set(rrSim, 'SimulationCommand', 'Start');

% Function to execute MQTT publishing at the specified simulation time
function publishMQTTData(filename, brokerAddress, port, clientID, userName, password, rootCert, channelID, field, clientName)
    % 读取指定的CSV文件
    try
        data = readtable(filename);
    catch ME
        error('Error reading CSV file: %s', ME.message);
    end

    % 创建MQTT客户端并连接到broker
    try
        mqClient = mqttclient(brokerAddress, Port = port, ClientID = clientID, Username = userName, Password = password, CARootCertificate = rootCert);
    catch ME
        error('Error creating MQTT client: %s', ME.message);
    end

    % 检查连接状态
    if mqClient.Connected
        fprintf('%s: Successfully connected to MQTT broker at %s\n', clientName, brokerAddress);
    else
        error('%s: Failed to connect to MQTT broker.', clientName);
    end

    % 构建要发布的主题
    topicToPublish = sprintf('channels/%s/publish/fields/%s', channelID, field);

    % 遍历每一行数据并发布到主题
    for i = 1:height(data)
        msg = jsonencode(table2struct(data(i,:)));
        try
            write(mqClient, topicToPublish, msg);
            fprintf('%s: Published message to %s: %s\n', clientName, topicToPublish, msg);
        catch ME
            fprintf('Error publishing message: %s\n', ME.message);
        end
        pause(1); % 暂停1秒以避免消息拥堵
    end

    % 打印发布成功的提示
    fprintf('%s: MQTT data from %s successfully published by client %s.\n', clientName, filename, clientID);

    % 清除MQTT客户端
    clear mqClient;
end

% Define the interaction times and corresponding filenames and client parameters
interactionTimes = [0.580, 5.800];
fileNames = {"Phase1TemporaryObject.csv", "Phase2TrafficControl.csv"};
clientParams = {...
    struct('clientID', 'Ow8KNSkiCikeJTYiMgwFBSU', 'userName', 'Ow8KNSkiCikeJTYiMgwFBSU', 'password', 'G/+bZDNJEdMCFkemTsEWnOHG', 'channelID', '2579802', 'field', 'field3', 'clientName', 'AD4'), ...
    struct('clientID', 'BwgrHhw6NC0fLx8TOicFCgs', 'userName', 'BwgrHhw6NC0fLx8TOicFCgs', 'password', 'I4JcfBQ84nyiWAJeIDmfNu1g', 'channelID', '2579802', 'field', 'field4', 'clientName', 'HDMCloud_2') ...
};
rootCert = "C:\Users\zyj\Desktop\DigiCert Global Root G2.crt";
brokerAddress = "ssl://mqtt3.thingspeak.com";
port = 8883;
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
        params = clientParams{interactionIndex};
        publishMQTTData(fileNames{interactionIndex}, brokerAddress, port, params.clientID, params.userName, params.password, rootCert, params.channelID, params.field, params.clientName);
        
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
    
    % Output the current simulation time
    simTime = get(rrSim, 'SimulationTime');
    fprintf('Current simulation time: %.3f seconds\n', simTime);
end

% Confirm end of simulation
fprintf('Simulation completed.\n');