-- 创建Road表
CREATE TABLE Road (
    RoadID varchar(255) PRIMARY KEY NOT NULL,
    AdminCode char(50) NOT NULL,
    RoadType int NOT NULL,
    StartNodeID char(50) NOT NULL,
    EndNodeID char(50) NOT NULL,
    RoadLength float NOT NULL,
    Direction int NOT NULL,
    IntersectionFlag int NOT NULL
);

-- 创建Lane表
CREATE TABLE Lane (
    LaneID varchar(255) PRIMARY KEY NOT NULL,
    RoadID varchar(255) NOT NULL,
    LaneWidth float NOT NULL,
    LanePitch float NOT NULL,
    LaneRoll float NOT NULL,
    MaxSpeed int NOT NULL,
    MinLaneSpeed int NOT NULL,
    LaneOrientation int NOT NULL,
    LaneTime timestamp NOT NULL,
    FOREIGN KEY (RoadID) REFERENCES Road(RoadID)
);

-- 创建Events表
CREATE TABLE Events (
    AccidentType int PRIMARY KEY NOT NULL,
    RoadID varchar(255) NOT NULL,
    LaneID varchar(255) NOT NULL,
    AccidentLocation int NOT NULL,
    EventConfidence int NOT NULL,
    HappenedTime timestamp NOT NULL,
    LastTime float NOT NULL,
    ImpactDegree int NOT NULL,
    LanePassable int NOT NULL,
    Classification int NOT NULL,
    FOREIGN KEY (RoadID) REFERENCES Road(RoadID),
    FOREIGN KEY (LaneID) REFERENCES Lane(LaneID)
);

-- 创建TrafficLight表
CREATE TABLE TrafficLight (
    LightID varchar(255) PRIMARY KEY NOT NULL,
    RoadID varchar(255) NOT NULL,
    LaneID varchar(255) NOT NULL,
    LightDirection char(5) NOT NULL,
    LightStay int NOT NULL,
    LightStatus int NOT NULL,
    LightRow int NOT NULL,
    LightColumn int NOT NULL,
    LeftTime int NOT NULL,
    RightTime int NOT NULL,
    LightEast int NOT NULL,
    LightWest int NOT NULL,
    LightNorth int NOT NULL,
    LightSouth int NOT NULL,
    SignalCycle int NOT NULL,
    FOREIGN KEY (RoadID) REFERENCES Road(RoadID),
    FOREIGN KEY (LaneID) REFERENCES Lane(LaneID)
);

-- 创建TrafficFlow表
CREATE TABLE TrafficFlow (
    TrafficStatus int PRIMARY KEY NOT NULL,
    LaneID varchar(255) NOT NULL,
    Flow int NOT NULL,
    Volume int NOT NULL,
    Density int NOT NULL,
    Speed int NOT NULL,
    TravelTime int NOT NULL,
    SpaceOccupancy float NOT NULL,
    QueuingLength int NOT NULL,
    QueuingTime int NOT NULL,
    FOREIGN KEY (LaneID) REFERENCES Lane(LaneID)
);

-- 创建RoadSurface表
CREATE TABLE RoadSurface (
    CoveringType int PRIMARY KEY NOT NULL,
    RoadID varchar(255) NOT NULL,
    LaneID varchar(255) NOT NULL,
    CoveringDepth int NOT NULL,
    FrictionFactor float NOT NULL,
    PavementTemp float NOT NULL,
    FOREIGN KEY (RoadID) REFERENCES Road(RoadID),
    FOREIGN KEY (LaneID) REFERENCES Lane(LaneID)
);

-- 创建Weather表
CREATE TABLE Weather (
    ModID varchar(255) PRIMARY KEY NOT NULL,
    RoadID varchar(255) NOT NULL,
    RealtimeWeather int NOT NULL,
    WeatherWarning int NOT NULL,
    WarningType int NOT NULL,
    WarningDate timestamp NOT NULL,
    EstimatedDuration float NULL
);

-- 创建Extensible表
CREATE TABLE Extensible (
    PersonalizedObject varchar(255) PRIMARY KEY NOT NULL,
    RoadID varchar(255) NULL,
    LaneID varchar(255) NULL,
    ...
);

-- 创建TrafficControl表
CREATE TABLE TrafficControl (
    ControlType int PRIMARY KEY NOT NULL,
    RoadID varchar(255) NOT NULL,
    LaneID varchar(255) NOT NULL,
    StartTime timestamp NOT NULL,
    EstimatedEndTime timestamp NOT NULL,
    VehicleLimit int NOT NULL,
    OrientationLimit int NOT NULL,
    SpeedLimit int NOT NULL,
    HeightLimit int NOT NULL,
    ControlReason int NOT NULL,
    FOREIGN KEY (RoadID) REFERENCES Road(RoadID),
    FOREIGN KEY (LaneID) REFERENCES Lane(LaneID)
);

-- 创建VehicleStatus表
CREATE TABLE VehicleStatus (
    VehicleID varchar(255) PRIMARY KEY NOT NULL,
    LaneID varchar(255) NOT NULL,
    VehiclePosition float NOT NULL,
    VehicleLength float NOT NULL,
    VehicleHeight float NOT NULL,
    VehicleWidth float NOT NULL,
    VehicleSpeed float NOT NULL,
    VehicleAcceleration float NOT NULL,
    VehicleOrientation int NULL,
    VehicleEnergy int NULL,
    VehicleType int NOT NULL,
    FOREIGN KEY (LaneID) REFERENCES Lane(LaneID)
);

-- 创建TrafficSign表
CREATE TABLE TrafficSign (
    SignboardType int PRIMARY KEY NOT NULL,
    VehicleID varchar(255) NOT NULL,
    SignboardLocation float NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES VehicleStatus(VehicleID)
);

-- 创建TemporaryObject表
CREATE TABLE TemporaryObject (
    StaticObjectType int PRIMARY KEY NOT NULL,
    VehicleID varchar(255) NOT NULL,
    StillObjectLocation int NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES VehicleStatus(VehicleID)
);

-- 创建PavementObject表
CREATE TABLE PavementObject (
    ObjectType int PRIMARY KEY NOT NULL,
    VehicleID varchar(255) NOT NULL,
    ObjectLocation float NOT NULL,
    V2ODistance float NULL,
    OMaxLength float NOT NULL,
    OMaxWidth float NOT NULL,
    OMaxHeight float NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES VehicleStatus(VehicleID)
);

-- 创建Emergencies表
CREATE TABLE Emergencies (
    AccidentType int PRIMARY KEY NOT NULL,
    VehicleID varchar(255) NOT NULL,
    VAccidentLocation float NOT NULL,
    VAccidentDegree int NOT NULL,
    VPassableLane varchar(255) NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES VehicleStatus(VehicleID)
);