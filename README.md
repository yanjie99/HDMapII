# HDMapII
# <img src="figures/hdmapii.ico" alt="icon" style="width: 40px; height: 40px; vertical-align: middle;"> An <span style="color:#ff7e5f">Approach</span> of <span style="color:#ff7e5f">H</span>igh <span style="color:#ff7e5f">D</span>efintion <span style="color:#ff7e5f">M</span>ap <span style="color:#ff7e5f">I</span>nformation <span style="color:#ff7e5f">I</span>nteraction for <span style="color:#ff7e5f">C</span>onnected <span style="color:#ff7e5f">A</span>utonomous <span style="color:#ff7e5f">V</span>ehicle


[![Custom badge](https://img.shields.io/badge/Project-page-green?logo=document)](https://) [![GitHub license](https://img.shields.io/badge/License-Apache--2.0-red)](https://www.apache.org/licenses/LICENSE-2.0)

[**Yanjie Zhang**](https://yanjie99.github.io/) *&* [**Wei Huang**](https://huangweibuct.github.io/weihuang.github.io/)


<!-- Yanjie Zhang<sup>1,\*</sup>, Wei Huang<sup>1,2,3,\*,†</sup>, Akram Akbar<sup>2</sup>, Hangbin Wu<sup>1,2</sup>, Chun Liu<sup>1,2,\*,†</sup><br><-->
<!-- <sup>1</sup> Urban Mobility Institute, Tongji University, China <sup>2</sup> College of Surveying and Geo-Informatics, Tongji University, China <sup>3</sup> Department of Civil Engineering, Toronto Metropolitan University, Canada<br>
> <sup>\*</sup> Equal Contribution <sup>†</sup> Corresponding Authors-->

## 📖 News

- `[2024-7-20]` We released our project website [here](https://github.com/yanjie99/HDMapII)

---

## 🎯 Overview
We introduce **<span style="color:#ff7e5f">HDMapII</span>**, a novel approach to information interaction for connected autonomous vehicles empowered by high-definition maps. HDMapII consists of five main components: the **database** for HD map information management, the **information interaction modes** between autonomous driving vehicle and HD map, the **communication methods** for various types of dynamic information within HD map information database, the information **communication protocol** applied at different interaction modes and the approach to achieving a complete HD map information interaction process.

<p align="center">
  <img src="figures/figure1.png" alt="pipeline" width="600">
</p>

In the RoadRunner <span style="color:#A680B8">simulator</span>, HDMapII utilizes open-source map data, such as OpenStreetMap(OSM), to <span style="color:#EA6B66">rebuild real road environment</span> (including lane markings, curbs, surrounding built environment, etc.) and <span style="color:#EA6B66">generate HD map data</span> for storage in HD map information database. These scenario data are then used in <span style="color:#009600">different information interaction modes</span> respectively and allocated to the corresponding communication methods based on the characteristics of the information itself. Finally, in autonomous driving scenarios, all information interactions between autonomous vehicles and HD maps are conducted based on the <span style="color:#B46504">MQTT protocol</span>. As the process progresses, newly generated HD map data can be updated to the HD map information database for potential future interactions.

## 📊 Dynamic Informarion
We systematically design the content and exchange format for dynamic information in HD Maps, focusing on two key components: **Road Real-time Information (RRTI)** and **Vehicle Dynamic Information (VDI)**. The following figure illustrates the primary components of this dynamic information. For additional details, please refer to the DynamicInfo.xlsx file.
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
The simulation code is available at [./code/PGPS_MatlabCode](), [./code/UOS_MatlabCode](), [./code/LSTCS_MatlabCode]() (Run at Matlab 2024a)

The scenario design code is available at [./code/Scenarios]() (Built by RoadRunner r2024a)

- Pedestrian Ghost Probe Scenario
[![Watch the video](https://img.youtube.com/vi/uWJD2UlZEeg/maxresdefault.jpg)](https://www.youtube.com/watch?v=uWJD2UlZEeg)

- Unkown of Object Scenario
[![Watch the video](https://img.youtube.com/vi/eML9u1wdsxs/maxresdefault.jpg)](https://www.youtube.com/watch?v=eML9u1wdsxs)


- Lane Scale Traffic Control Scenario
[![Watch the video](https://img.youtube.com/vi/b9_OAiUFXcs/maxresdefault.jpg)](https://www.youtube.com/watch?v=b9_OAiUFXcs)



We conduct closed-loop tests in MATLAB. It can be seen that HDMapII can provide the prior information for connected autonomous vehicles, enabling them to make timely decisions. In contrast, regular vehicles, lacking interactive support methods, may spend more time on their journeys due to the inability to respond promptly to unexpected situations. 


## 📄 License

This project is released under the [Apache 2.0 license](LICENSE). 


