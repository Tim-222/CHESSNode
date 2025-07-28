CHESS deployment overview
-------------------------

CHESS assets are deployed and registered with their corresponding Digital twins using adapters, which provide a common set of abstractions of CHESS assets. This is supported using the RabbitMQ broker, UUDEX and AAS Server as well as the core network API functions as shown below.  These are deployed in a CHESS node K3S environment which exposes a secure API gateway to access the AAS Server, UUDEX and core APIs.

![Alt text](CHESSNode/deploy/images/CHESSNode.png)

The UUDEX is used to support the control and data planes with the Flex Platform using a message bus that exposes REST APIs that utilise the RabbitMQ server to provide the data  handling functions. The corresponding backing queues  are configured for fan out of data to different recipients which are CHESS nodes and the Flex platform services. Each adapter has two queues created - one for data (from CHESS to digitial twin environment) and the other for control (from the Flex platform or AAS Server to the CHESS). In the case of MQTT adapters  an additional MQTT client connection and associated queue is used to handle the forwarding of telemetry data from the local CHESS node.

![Alt text](CHESSNode/deploy/images/UUDEX.png)


1) Create DTDL definition of the CHESS
--------------------------------------

The DTDL editor extension within Visual Studio Code can be used to create the CHESS description using the template in  chess.json. However, adapters can also directly create the digital twin instances on the fly.
The DTDL uses the AAS submodels to describe the different views of the CHESS asset, such as EnergyEntity, PowerEntity, VoltageEntity and StateOfBatteryEntity.

![Alt text](CHESSNode/deploy/images/visualstudio.png)

The DTDL consists of the digital twin model which defines the data semantic structure and graphs that are the instances of the models using the AAS based data submodel templates.

2) Import DTDL into Azure environment
-------------------------------------

The DT explorer (https://preprodapim.umbrellaiot.com:9096) can be used to import the CHESS into the DT environemnt in Azure if the CHESS adapters do not support on the fly creation of digital twin instances.

![Alt text](CHESSNode/deploy/images/upload.png)

3) Register CHESS with DT 
-------------------------
The CHESS node CoreAPI is used to register the CHESS with a CHESS node using the CHESS adapter provided as a container image. 

The sequence for CHESS registration and handling of data is shown in the following  diagram.

![Alt text](CHESSNode/deploy/images/sequence.png)

The register operation takes the following JSON example payload.

```
{"adapter":{
   "Identifier":"venusadapter",				
   "Location":"CHESS node 2",		
   "Standard":"Victron",	
   "Version":"1.0",
   "Id":"venusadapter",					    
   "Wireless":"test",
   "Container":"timfa/venus:latest",
   "Credentials":"default",
   "EnvConf":"saFlexibilityProvideraaa-bbb-ccc-ddd",
   "ExposedPort":80,
   "VolumeMount":""
  },
 "chess":[{
   "Identifier":"venusadapter",
   "Location":"lat lon",					
   "Standard":"MQTT",					 
   "Version":"3.1.1",
   "Id":"fr-bess-lab1-chess1-sim"
   }
]}
```

4) Explore data
---------------
The data relating to the digital twin can be explored using the DT explorer (https://preprodapim.umbrellaiot.com:9096) and the corresponding AAS Server provided APIs through the CHESS node.

![Alt text](CHESSNode/deploy/images/history.png)

The AAS Server APIs permit the retrieval of the status and capabilities including submodels provided for a CHESS by the adapter. Also, the viewing of the CHESS status and power profile information.
![Alt text](CHESSNode/deploy/images/AASServer1.png)

![Alt text](CHESSNode/deploy/images/AASServer2.png)

![Alt text](CHESSNode/deploy/images/AASServer3.png)


Example status structure for the request to control CHESS operation are invoked thorugh the CHESS API /status operations:
```
{
    "identifier":"simbessadapter",
    "currentStatus":"available",
    "status":[{
      "status":"ForceCharge",
      "service":"all",
      "starttime":"12:15",
      "endtime":"18:15",
      "capacity":"10000",
      "recurrence":"weekdays"
     },
     {
      "status":"ForceDischarge",
      "service":"all",
      "starttime":"18:15",
      "endtime":"22:15",
      "capacity":"10000",
      "recurrence":"weekdays"
    }]
}

```
