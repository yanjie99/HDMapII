# HDMapII
# <img src="figures/hdmapii.ico" alt="icon" style="width: 40px; height: 40px; vertical-align: middle;"> An <span style="color:#ff7e5f">Approach</span> of <span style="color:#ff7e5f">H</span>igh <span style="color:#ff7e5f">D</span>efintion <span style="color:#ff7e5f">M</span>ap <span style="color:#ff7e5f">I</span>nformation <span style="color:#ff7e5f">I</span>nteraction for <span style="color:#ff7e5f">C</span>onnected <span style="color:#ff7e5f">A</span>utonomous <span style="color:#ff7e5f">V</span>ehicle


[![Custom badge](https://img.shields.io/badge/Arxiv-pdf-8A2BE2?logo=arxiv)](https://arxiv.org) [![Custom badge](https://img.shields.io/badge/Project-page-green?logo=document)](https://) [![GitHub license](https://img.shields.io/badge/License-Apache--2.0-red)](https://www.apache.org/licenses/LICENSE-2.0)




> Yanjie Zhang<sup>1</sup>, Wei Huang<sup>1,2,†</sup>, Chun Liu<sup>2,\*</sup>, Hangbin Wu<sup>2</sup>, Akcram<sup>2</sup><br>
> <sup>1</sup> Urban Mobility Institute, Tongji University, China <sup>2</sup> College of Surveying and Geo-Informatics, Tongji University, China <sup>3</sup> Department of Civil Engineering, Toronto Metropolitan University, Canada<br>
> <sup>\*</sup> Equal Contribution <sup>†</sup> Corresponding Authors

## 📖 News

- `[2024-7-20]` We released our project website [here](https://github.com/yanjie99/HDMapII)

---

## 🎯 Overview
We introduce **<span style="color:#ff7e5f">HDMapII</span>**, a novel approach to information interaction for connected autonomous vehicles empowered by high-definition maps. HDMapII consists of five main components: the **database** for HD map information management, the **information interaction modes** between autonomous driving vehicle and HD map, the **communication methods** for various types of dynamic information within HD map information database, the information **communication protocol** applied at different interaction modes and the approach to achieving a complete HD map information interaction process.

<div style="text-align:center;">
  <img src="figures/figure1.png" alt="pipeline" width="600">
</div>

In the RoadRunner <span style="color:#A680B8">simulator</span>, HDMapII utilizes open-source map data, such as OpenStreetMap(OSM), to <span style="color:#EA6B66">rebuild real road environment</span> (including lane markings, curbs, surrounding built environment, etc.) and <span style="color:#EA6B66">generate HD map data</span> for storage in HD map information database. These scenario data are then used in <span style="color:#009600">different information interaction modes</span> respectively and allocated to the corresponding communication methods based on the characteristics of the information itself. Finally, in autonomous driving scenarios, all information interactions between autonomous vehicles and HD maps are conducted based on the <span style="color:#B46504">MQTT protocol</span>. As the process progresses, newly generated HD map data can be updated to the HD map information database for potential future interactions.


## 🛣️ Demo Video in RoadRunner combined with MATLAB
- Pedestrian Ghost Probe Scenario
<video width="800" controls>
  <source src="videos/PGPS_Final.mp4" type="video/mp4">
</video>

https://www.youtube.com/watch?v=uWJD2UlZEeg

- Unkown of Object Scenario
<video width="800" controls>
  <source src="videos/UOS_Final.mp4" type="video/mp4">
</video>

- Lane Scale Traffic Control Scenario
<video width="800" controls>
  <source src="videos/LSTCS_Final.mp4" type="video/mp4">
</video>


We conduct closed-loop tests in MATLAB. It can be seen that XXX 


## 📄 License

This project is released under the [Apache 2.0 license](LICENSE). 
