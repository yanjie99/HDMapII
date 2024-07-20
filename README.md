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
  <source src="https://private-user-images.githubusercontent.com/56749463/350668922-1325cb6f-3111-4100-8889-cbddf4f60a92.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjE0NTY5NjgsIm5iZiI6MTcyMTQ1NjY2OCwicGF0aCI6Ii81Njc0OTQ2My8zNTA2Njg5MjItMTMyNWNiNmYtMzExMS00MTAwLTg4ODktY2JkZGY0ZjYwYTkyLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA3MjAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNzIwVDA2MjQyOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTA3YzMxMWI1MTJlZmYxYTgxZDVjNDg2NjdjODVjMDdkYTUyNTI0MGM1ODVlZDNhYTU3M2QzNzhjN2RkMDk5ODAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.SlSBz5354EgHGRTXb587e_29m_mdvbAS4RgNk_yJd44" type="video/mp4">
</video>
https://private-user-images.githubusercontent.com/56749463/350668922-1325cb6f-3111-4100-8889-cbddf4f60a92.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjE0NTY5NjgsIm5iZiI6MTcyMTQ1NjY2OCwicGF0aCI6Ii81Njc0OTQ2My8zNTA2Njg5MjItMTMyNWNiNmYtMzExMS00MTAwLTg4ODktY2JkZGY0ZjYwYTkyLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA3MjAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNzIwVDA2MjQyOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTA3YzMxMWI1MTJlZmYxYTgxZDVjNDg2NjdjODVjMDdkYTUyNTI0MGM1ODVlZDNhYTU3M2QzNzhjN2RkMDk5ODAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.SlSBz5354EgHGRTXb587e_29m_mdvbAS4RgNk_yJd44


- Unkown of Object Scenario
<video width="800" controls>
  <source src="videos/UOS_Final.mp4" type="video/mp4">
</video>
https://private-user-images.githubusercontent.com/56749463/350669089-dfba7569-6d4f-46b3-84b4-fdfd45755ca8.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjE0NTY5ODYsIm5iZiI6MTcyMTQ1NjY4NiwicGF0aCI6Ii81Njc0OTQ2My8zNTA2NjkwODktZGZiYTc1NjktNmQ0Zi00NmIzLTg0YjQtZmRmZDQ1NzU1Y2E4Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA3MjAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNzIwVDA2MjQ0NlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWJhODExNTJlZDVlZGQyMGViZjI2NDIzZjBmZDcxMzE3YTM4MmM4OTNjZmVmZDIzZGZlMGZkYTI0MGZjNGUyOWMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.5Ze-kgHI9A7OFjhA7Sq5m58KluBb44K9MWU4igGPiSg

- Lane Scale Traffic Control Scenario
<video width="800" controls>
  <source src="videos/LSTCS_Final.mp4" type="video/mp4">
</video>
https://private-user-images.githubusercontent.com/56749463/350669160-51467e95-9bb8-4f7c-b93f-954cfe08a1e7.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjE0NTY5MTMsIm5iZiI6MTcyMTQ1NjYxMywicGF0aCI6Ii81Njc0OTQ2My8zNTA2NjkxNjAtNTE0NjdlOTUtOWJiOC00ZjdjLWI5M2YtOTU0Y2ZlMDhhMWU3Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA3MjAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNzIwVDA2MjMzM1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWQ4MTc1N2MyOGQzNWM5NDVmNGNlMmVhMDM4YWEwZGRlMmIwYWQwNTljYWM5NjdlYjQ0OTEwOTA2M2RlZTgxNzQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.4lJreKKfw5VP3DjC-zdsUZ-Y_iNhaGNioeHcyaYLcHs


We conduct closed-loop tests in MATLAB. It can be seen that XXX 


## 📄 License

This project is released under the [Apache 2.0 license](LICENSE). 
