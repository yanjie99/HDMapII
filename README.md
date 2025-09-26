# HDMapII
# <img src="figures/hdmapii.ico" alt="icon" style="width: 40px; height: 40px; vertical-align: middle;"> An <span style="color:#ff7e5f">Approach</span> of <span style="color:#ff7e5f">H</span>igh <span style="color:#ff7e5f">D</span>efintion <span style="color:#ff7e5f">M</span>ap <span style="color:#ff7e5f">I</span>nformation <span style="color:#ff7e5f">I</span>nteraction for <span style="color:#ff7e5f">C</span>onnected <span style="color:#ff7e5f">A</span>utonomous <span style="color:#ff7e5f">V</span>ehicle


[![Custom badge](https://img.shields.io/badge/Project-page-green?logo=document)](https://) [![GitHub license](https://img.shields.io/badge/License-Apache--2.0-red)](https://www.apache.org/licenses/LICENSE-2.0)

[**Yanjie Zhang**](https://metayj.github.io/) *&* [**Wei Huang**](https://huangweibuct.github.io/weihuang.github.io/)


<!-- Yanjie Zhang<sup>1,\*</sup>, Wei Huang<sup>1,2,3,\*,†</sup>, Akram Akbar<sup>2</sup>, Hangbin Wu<sup>1,2</sup>, Chun Liu<sup>1,2,\*,†</sup><br><-->
<!-- <sup>1</sup> Urban Mobility Institute, Tongji University, China <sup>2</sup> College of Surveying and Geo-Informatics, Tongji University, China <sup>3</sup> Department of Civil Engineering, Toronto Metropolitan University, Canada<br>
> <sup>\*</sup> Equal Contribution <sup>†</sup> Corresponding Authors-->

## 📖 News

- `[2025-6-19]` Our simulation experiment supports the work of _Framework of updating and interaction for high-definition maps with vehicle-road-cloud context_, which has published [here](https://doi.org/10.1080/17538947.2025.2552879).  
- `[2024-8-18]` We have completed the organization of the repository contents and will continue to update this work.
- `[2024-7-20]` We released our project website [here](https://github.com/yanjie99/HDMapII)

---

## 🎯 Overview
We introduce **<span style="color:#ff7e5f">HDMapII</span>**, a novel approach to information interaction for connected autonomous vehicles empowered by high-definition maps. HDMapII consists of five main components: the **database** for HD map information management, the **information interaction modes** between autonomous driving vehicle and HD map, the **communication methods** for various types of dynamic information within HD map information database, the information **communication protocol** applied at different interaction modes and the approach to achieving a complete HD map information interaction process.

<p align="center">
  <img src="figures/figure1.png" alt="pipeline" width="600">
</p>

In the RoadRunner <span style="color:#A680B8">simulator</span>, HDMapII utilizes open-source map data, such as OpenStreetMap(OSM), to <span style="color:#EA6B66">rebuild real road environment</span> (including lane markings, curbs, surrounding built environment, etc.) and <span style="color:#EA6B66">generate HD map data</span> for storage in HD map information database. These scenario data are then used in <span style="color:#009600">different information interaction modes</span> respectively and allocated to the corresponding communication methods based on the characteristics of the information itself. Finally, in autonomous driving scenarios, all information interactions between autonomous vehicles and HD maps are conducted based on the <span style="color:#B46504">MQTT protocol</span>. As the process progresses, newly generated HD map data can be updated to the HD map information database for potential future interactions.

## 📊 Dynamic Informarion
We systematically design the content and exchange format for dynamic information in HD Maps, focusing on two key components: **Road Real-time Information (RRTI)** and **Vehicle Dynamic Information (VDI)**. The following figure illustrates the primary components of this dynamic information. For additional details, please refer to this [Standard](https://www.csgpc.org/detail/23300.html) (English version will coming later).
<p align="center"><img src="figures/rrti.png" alt="pipeline" width="600"></p>
<p align="center"><img src="figures/vdi.png" alt="pipeline" width="600"></p>

## 〽️ Information Interaction Modes
We propose three information interaction modes tailored to the various data terminals within HD Maps: Vehicle-to-Cloud mode, Vehicle-to-Vehicle mode and Cloud-to-Vehicle mode.

<p align="center"><img src="figures/vcmode.png" alt="pipeline" width="600"></p>

In Vehicle-to-Cloud mode, the information exchanged from the vehicle terminal to the cloud is mainly the **VDI**, including vehicle status information, temporary traffic sign information, and temporary event information. Information sender is every autonomous vehicle and the reveiver is HD Map cloud databases terminals.

<p align="center"><img src="figures/vvmode.png" alt="pipeline" width="600"></p>

In Vehicle-to-Vehicle mode, the information exchanged from the vehicle end to the vehicle end is mainly the **VDI**, including vehicle status information and temporary road object information. The sender and receiver of the information are different autonomous vehilces.

<p align="center"><img src="figures/cvmode.png" alt="pipeline" width="600"></p>

In Cloud-to-Vehicle mode, the information exchanged from the cloud to the vehicle is mainly the **RRTI**, including traffic signal light information, traffic flow information, traffic control information, traffic event information, and road surface object information. The information sender is HD Map cloud database terminal, and the receivers are any autonomous vehicles that require the data.

## 🛜 Information Communication Protocol
The communication protocol used for information exchange in all modes is [MQTT](https://mqtt.org/). Refer to the diagram below for the communication specifications of each interaction mode.

Messaging Service Levels:
- QoS 0 (At most once): Messages are delivered at most once and are not guaranteed to reach the recipient.
- QoS 1 (At least once): Messages are delivered at least once, there may be duplicate messages, and each message requires an acknowledgement.
- QoS 2 (Exactly once): Messages are ensured to reach the receiver one and only once and are not delivered repeatedly, and uniqueness is guaranteed through a two-stage acknowledgement process.


<p align="center"><img src="figures/vcmode_mqtt.png" alt="pipeline" width="600"></p>



<p align="center"><img src="figures/vvmode_mqtt.png" alt="pipeline" width="600"></p>



<p align="center"><img src="figures/cvmode_mqtt.png" alt="pipeline" width="600"></p>




## 🧩 Scenario Design
To test our proposed information interaction methods, we designed three specific scenarios representing common traffic situations in the physical world to evaluate the effectiveness of the information exchange process. The scenarios are named **Pedestrian Ghost Probe**, **Unknown Object on the Road**, and **Lane-scale Traffic Control**, respectively. Each scenario includes the following components: autonomous vehicles (with communication capability), ordinary vehicles (without communication capability), dynamic objects (such as pedestrian), and static objects (such as unknown objects, traffic signs, etc.).

<p align="center"><img src="figures/pgps.png" alt="pipeline" width="600"></p>

**Pedestrian Ghost Probe Scenario**
- Participants: 3 Autonomous Vehilces, 2 Ordinary Vehicles, 1 Pedestrian
- Information interaction mode: Vehicle-to-Vehicle 
- Exchange information: VDI (Pavement Object) 

<p align="center"><img src="figures/uos.png" alt="pipeline" width="600"></p>

**Unknown Object Scenario**
- Participants: 3 Autonomous Vehicles, 2 Ordinary Vehicles, 1 Static Object
- Information interaction mode: Vehicle-to-Vehicle
- Exchange information: VDI (Pavement Object)

<p align="center"><img src="figures/lstcs.png" alt="pipeline" width="600"></p>

**Lane-scale Traffic Control Scenario**
- Participants: 4 Autonomous Vehicles, 3 Ordinary Vehicles, 1 Traffic Control Sign
- Information interaction mode: Vehicle-to-Vehicle, Vehicle-to-Cloud, Cloud-to-Vehicle
- Exchange information: VDI (Temporary Object), RRTI (Traffic Control)


## 🛣️ Demo Video in RoadRunner combined with MATLAB
The simulation code is available at [./code/PGPS_MatlabCode](https://github.com/yanjie99/HDMapII/tree/main/code/PGPS_MatlabCode), [./code/UOS_MatlabCode](https://github.com/yanjie99/HDMapII/tree/main/code/UOS_MatlabCode), [./code/LSTCS_MatlabCode](https://github.com/yanjie99/HDMapII/tree/main/code/LSTCS_MatlabCode) (Run at Matlab r2024a)

The scenario design code is available at [./code/Scenarios](https://github.com/yanjie99/HDMapII/tree/main/code/Scenes) (Built by [RoadRunner r2024a](https://ww2.mathworks.cn/en/products/roadrunner.html))

- Pedestrian Ghost Probe Scenario
[![Watch the video](https://img.youtube.com/vi/uWJD2UlZEeg/maxresdefault.jpg)](https://www.youtube.com/watch?v=uWJD2UlZEeg)

- Unkown of Object Scenario
[![Watch the video](https://img.youtube.com/vi/eML9u1wdsxs/maxresdefault.jpg)](https://www.youtube.com/watch?v=eML9u1wdsxs)


- Lane Scale Traffic Control Scenario
[![Watch the video](https://img.youtube.com/vi/b9_OAiUFXcs/maxresdefault.jpg)](https://www.youtube.com/watch?v=b9_OAiUFXcs)



We conduct closed-loop tests in MATLAB. It can be seen that HDMapII can provide the prior information for connected autonomous vehicles, enabling them to make timely decisions. In contrast, regular vehicles, lacking interactive support methods, may spend more time on their journeys due to the inability to respond promptly to unexpected situations. 

## 🔗 Dependencies
- Matlab r202Xa(Remain consistent with RoadRunner version. For example, Matlab r2024a with RoadRunner r2024a)
- [RoadRunner](https://ww2.mathworks.cn/en/products/roadrunner.html) r202Xa
- PostgreSQL 16
- roadrunner ([Connect MATLAB and RoadRunner to control and analyze simulations](https://ww2.mathworks.cn/help/driving/ug/connect-matlab-and-roadrunner.html))
- ThingSpeak ([An IoT analytics platform service that allows you to aggregate, visualize and analyze live data streams in the cloud](https://thingspeak.com/pages/learn_more))
- OpenStreetMap ([Static map data source](https://www.openstreetmap.org))
- Simulink (Optional, only for further analysis)

## ⚙️ Quick Start
#### Generating data
Static map data is downloaded from OpenStreetMap. The [experimental area](https://www.openstreetmap.org/search?query=%E4%B8%8A%E6%B5%B7%E7%AB%B9%E6%9E%97%E8%B7%AF#map=18/31.22541/121.52887) includes three roads in Shanghai, China: Zhulin Road, Xiangcheng Road, Fushan Road.

#### Data processing
Raw map data in OpenDRIVE format is collected from OpenStreetMap. The raw data is imported and preprocessed using MATLAB's Automated Driving Toolbox. Three major intersecting roads within the target area are extracted, and the road environment in that area is recreated. The processed data is then exported to RoadRunner for simulation modeling of realistic traffic scenarios.

#### Data storage
A high-definition map information management database is created in PostgreSQL to store the information. The database creation code is available at [here](https://github.com/yanjie99/HDMapII/tree/main/code/HDMapDB).

#### Scenario construction
In RoadRunner r2024a, the traffic elements in the area are simulated and recreated based on Baidu Street View Maps. Then, according to the design requirements of the three typical autonomous driving scenarios, all necessary elements are added to the simulation scene. The final scenarios are available at [here](https://github.com/yanjie99/HDMapII/tree/main/code/Scenarios)

#### Scenario simulation
- Configure the [connection with RoadRunner](https://ww2.mathworks.cn/help/driving/ug/connect-matlab-and-roadrunner.html) in MATLAB.
- Establish a secure [connection in MATLAB with an MQTT](https://ww2.mathworks.cn/help/icomm/ug/get-started-with-mqtt.html) broker and communicate with the MQTT broker.
- The code for each scenario ([PGPS](https://github.com/yanjie99/HDMapII/tree/main/code/PGPS_MatlabCode), [UOS](https://github.com/yanjie99/HDMapII/tree/main/code/UOS_MatlabCode), [LSTCS](https://github.com/yanjie99/HDMapII/tree/main/code/LSTCS_MatlabCode)) integrates the information interaction methods applied in the specific scenario.
- Run the simulation experiments after executing these codes in the following order (take PGPS simulation experiment for example).
- - 1 step1.m -> step2_2.m -> step2.m
- - 2 PGPS_AD1_V2V_Receive_final.m (Configure the information receiving port)
- - 3 PGPS_interaction_p1ad1_2476.m (Information interaction simulation)
- - 4 step4Velocity2Time_PGPS.m (Speed-time analysis of the actor)
- - 5 RouteOutput_PGPS.m & RouteOutputIndividually_PGPS.m (Path trajectory analysis of the actor)

## 📄 License

This project is released under the [Apache 2.0 license](LICENSE). 


