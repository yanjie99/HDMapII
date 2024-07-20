% 设置MQTT客户端参数
clientID = "LDYtCDElJxUFFyEfHzINBwY"; % AD2的ClientID
userName = "LDYtCDElJxUFFyEfHzINBwY"; % AD2的Username
password = "O7aFgvMULWvfGGCLFTapxMrd"; % AD2的Password
rootCert = "C:\Users\zyj\Desktop\DigiCert Global Root G2.crt";
brokerAddress = "ssl://mqtt3.thingspeak.com";
port = 8883;

try
    % 创建全局变量以在回调函数中使用
    global mqClientAD2;

    % 创建MQTT客户端并连接到broker
    mqClientAD2 = mqttclient(brokerAddress, Port = port, ClientID = clientID, Username = userName, Password = password, CARootCertificate = rootCert);

    % 检查连接状态
    if mqClientAD2.Connected
        fprintf('AD2: Successfully connected to MQTT broker at %s\n', brokerAddress);
    else
        error('AD2: Failed to connect to MQTT broker.');
    end

    % 订阅主题并设置回调函数
    channelID = "2579802";
    field = "field3";
    topicToSubscribe = sprintf('channels/%s/subscribe/fields/%s', channelID, field);
    subscribe(mqClientAD2, topicToSubscribe, 'Callback', @showmessageAD2);

    % 检查订阅状态
    subscribedTopics = mqClientAD2.Subscriptions;
    if any(strcmp(subscribedTopics.Topic, topicToSubscribe))
        fprintf('AD2: Successfully subscribed to %s\n', topicToSubscribe);
    else
        error('AD2: Failed to subscribe to %s', topicToSubscribe);
    end

    % 保持订阅状态
    fprintf('AD2: Listening for messages...\n');
    while true
        pause(1); % 保持连接和订阅状态
    end

catch ME
    fprintf('AD2: An error occurred: %s\n', ME.message);
end

% 清除MQTT客户端
clear mqClientAD2;

% 回调函数定义
function showmessageAD2(~, message)
    % 使用全局变量
    global mqClientAD2;

    fprintf('AD2: Received message: %s\n', message);
    % 解析消息并反馈
    try
        data = jsondecode(message);
        disp(data);
        % 反馈逻辑，例如向另一个主题发布反馈消息
        feedbackTopic = "road/feedback";
        feedbackMsg = sprintf('Received object data at %s', datestr(now));
        write(mqClientAD2, feedbackTopic, feedbackMsg);
        fprintf('AD2: Published feedback to %s: %s\n', feedbackTopic, feedbackMsg);
    catch decodeError
        fprintf('AD2: Failed to decode message: %s\n', decodeError.message);
    end
end
