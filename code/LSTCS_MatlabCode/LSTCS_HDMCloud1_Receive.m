% 设置MQTT客户端参数
clientID = "HxMJIAgQGyQYOBowJg0PNjM"; % HDMCloud_1的ClientID
userName = "HxMJIAgQGyQYOBowJg0PNjM"; % HDMCloud_1的Username
password = "t0PQEehHYsf60OsmgxSvwmMh"; % HDMCloud_1的Password
rootCert = "C:\Users\zyj\Desktop\DigiCert Global Root G2.crt";
brokerAddress = "ssl://mqtt3.thingspeak.com";
port = 8883;

try
    % 创建全局变量以在回调函数中使用
    global mqClientHDMCloud1;

    % 创建MQTT客户端并连接到broker
    mqClientHDMCloud1 = mqttclient(brokerAddress, Port = port, ClientID = clientID, Username = userName, Password = password, CARootCertificate = rootCert);

    % 检查连接状态
    if mqClientHDMCloud1.Connected
        fprintf('HDMCloud_1: Successfully connected to MQTT broker at %s\n', brokerAddress);
    else
        error('HDMCloud_1: Failed to connect to MQTT broker.');
    end

    % 订阅主题并设置回调函数
    channelID = "2579802";
    field = "field3";
    topicToSubscribe = sprintf('channels/%s/subscribe/fields/%s', channelID, field);
    subscribe(mqClientHDMCloud1, topicToSubscribe, 'Callback', @showmessageHDMCloud1);

    % 检查订阅状态
    subscribedTopics = mqClientHDMCloud1.Subscriptions;
    if any(strcmp(subscribedTopics.Topic, topicToSubscribe))
        fprintf('HDMCloud_1: Successfully subscribed to %s\n', topicToSubscribe);
    else
        error('HDMCloud_1: Failed to subscribe to %s', topicToSubscribe);
    end

    % 保持订阅状态
    fprintf('HDMCloud_1: Listening for messages...\n');
    while true
        pause(1); % 保持连接和订阅状态
    end

catch ME
    fprintf('HDMCloud_1: An error occurred: %s\n', ME.message);
end

% 清除MQTT客户端
clear mqClientHDMCloud1;

% 回调函数定义
function showmessageHDMCloud1(~, message)
    % 使用全局变量
    global mqClientHDMCloud1;

    fprintf('HDMCloud_1: Received message: %s\n', message);
    % 解析消息并反馈
    try
        data = jsondecode(message);
        disp(data);
        % 反馈逻辑，例如向另一个主题发布反馈消息
        feedbackTopic = "road/feedback";
        feedbackMsg = sprintf('Received object data at %s', datestr(now));
        write(mqClientHDMCloud1, feedbackTopic, feedbackMsg);
        fprintf('HDMCloud_1: Published feedback to %s: %s\n', feedbackTopic, feedbackMsg);
    catch decodeError
        fprintf('HDMCloud_1: Failed to decode message: %s\n', decodeError.message);
    end
end
