% 设置MQTT客户端参数
clientID = "Bi0iNw8CDSMzCQEmKQkLKxE"; % AD3的ClientID
userName = "Bi0iNw8CDSMzCQEmKQkLKxE"; % AD3的Username
password = "KKfCbwroy6Hdc7bztSpFqSCw"; % AD3的Password
rootCert = "C:\Users\zyj\Desktop\DigiCert Global Root G2.crt";
brokerAddress = "ssl://mqtt3.thingspeak.com";
port = 8883;

try
    % 创建全局变量以在回调函数中使用
    global mqClientAD3;

    % 创建MQTT客户端并连接到broker
    mqClientAD3 = mqttclient(brokerAddress, Port = port, ClientID = clientID, Username = userName, Password = password, CARootCertificate = rootCert);

    % 检查连接状态
    if mqClientAD3.Connected
        fprintf('AD3: Successfully connected to MQTT broker at %s\n', brokerAddress);
    else
        error('AD3: Failed to connect to MQTT broker.');
    end

    % 订阅主题并设置回调函数
    channelID = "2579802";
    field = "field4";
    topicToSubscribe = sprintf('channels/%s/subscribe/fields/%s', channelID, field);
    subscribe(mqClientAD3, topicToSubscribe, 'Callback', @showmessageAD3);

    % 检查订阅状态
    subscribedTopics = mqClientAD3.Subscriptions;
    if any(strcmp(subscribedTopics.Topic, topicToSubscribe))
        fprintf('AD3: Successfully subscribed to %s\n', topicToSubscribe);
    else
        error('AD3: Failed to subscribe to %s', topicToSubscribe);
    end

    % 保持订阅状态
    fprintf('AD3: Listening for messages...\n');
    while true
        pause(1); % 保持连接和订阅状态
    end

catch ME
    fprintf('AD3: An error occurred: %s\n', ME.message);
end

% 清除MQTT客户端
clear mqClientAD3;

% 回调函数定义
function showmessageAD3(~, message)
    % 使用全局变量
    global mqClientAD3;

    fprintf('AD3: Received message: %s\n', message);
    % 解析消息并反馈
    try
        data = jsondecode(message);
        disp(data);
        % 反馈逻辑，例如向另一个主题发布反馈消息
        feedbackTopic = "road/feedback";
        feedbackMsg = sprintf('Received object data at %s', datestr(now));
        write(mqClientAD3, feedbackTopic, feedbackMsg);
        fprintf('AD3: Published feedback to %s: %s\n', feedbackTopic, feedbackMsg);
    catch decodeError
        fprintf('AD3: Failed to decode message: %s\n', decodeError.message);
    end
end
