CHESS Node
----------
Connected Hybrid Energy Storage System (CHESS) Nodes facilitate distributed energy management to support Flexibility Services such as load shifting and peak shaving using flexible energy assets, such as EV chargers, HVAC and battery storage systems.

CHESS nodes support adapters (containers),  which in turn connect with the virtual storage assets and interface with the Azure digital twin environment to permit cooperation between multiple asset types and distributed deployment across CHESS nodes. 

The CHESS node is composed of the AAS Server, Core API (for adapter deployment and status update) and CHESS adapters.

In addition, the Universal Utility Data Exchange (UUDEX) server permits control coordination between CHESS nodes using status messages encapsulated in the message bus protocol.  

The CHESS node can be deployed to any cloud VM or physical server, but requires an Azure digital twin environment with the necessary remote access through a service principal.

Deployment uses a Kubernetes based  environment (such as K3S) using yaml files found in /deploy.

Contents
--------
- [1.1 Repository layout](#11-repository-layout)
- [1.2 Building and running a component locally](#12-building-and-running-a-component-locally)
- [1.3 Prerequisites checklist](#13-prerequisites-checklist)
- [1.4 Prerequisite installation from scratch](#14-prerequisite-installation-from-scratch)
  - [1.4.1 AAS server / core API Deployment](#141-aas-server--core-api-deployment)
  - [1.4.2 Postgres for both API manager and UUDEX server](#142-postgres-for-both-api-manager-and-uudex-server)
  - [1.4.3 RabbitMQ for UUDEX server](#143-rabbitmq-for-uudex-server)
- [1.5 Adapter installation](#15-adapter-installation)


1.1 Repository layout
---------------------

| Path | Description |
|------|-------------|
| `/AASServer` | Asset Administration Shell (AAS) server. Implements the [AAS Part 2](http://industrialdigitaltwin.org/en/content-hub) REST API, exposing CHESS status, capabilities and submodels. ASP.NET Core (`IO.Swagger`). |
| `/CoreAPI` | Core network API. Handles adapter `/register`, `/init`, `/status` and `/update` operations, deploys adapter containers into the node's K3S cluster, and brokers digital-twin access. ASP.NET Core (`IO.Swagger`). |
| `/avevaadapter` | Adapter receiving HVAC/PV telemetry from an Aveva PI historian. |
| `/emsadapter` | Energy Management System (EMS) adapter — estimates cost/priority of assets for flexibility services such as peak shaving and load shifting. |
| `/evcsadapter` | EV Charging Station (CSMS) monitoring and control adapter. |
| `/foxBESSadapter` | Adapter for Fox battery energy storage systems (BESS). |
| `/huaweiBESSadapter` | Adapter for Huawei BESS, including a Modbus-to-MQTT bridge (`huawei2mqtt.py`). |
| `/smaBESSadapter` | Adapter for SMA BESS, built on SBFspot. |
| `/hvacadapter` | Simulated HVAC/building adapter, emulating HVAC as virtual energy storage. |
| `/deploy` | Kubernetes/K3S manifests (`*.yaml`) for AAS Server, Core API, UUDEX, RabbitMQ and Postgres, plus an example DTDL graph (`ExportedGraph.json`) and a deployment walkthrough ([deploy/README.md](deploy/README.md)). |
| `/doc` | Background documentation: flexibility/digital-twin concepts ([doc/Readme.md](doc/Readme.md)), the AAS Server design doc, and a digital-twin paper (PDFs). |

Each adapter directory contains its own `README.md` with adapter-specific build steps and an example `/register` payload — see the links in the table above.

1.2 Building and running a component locally
---------------------------------------------

Every component (`AASServer`, `CoreAPI`, and each `*adapter`) is a standalone .NET (ASP.NET Core) project generated from a Swagger/OpenAPI spec, and can be built either natively or as a Docker image.

Native build (from within the component directory):

```
sh build.sh          # Linux/macOS
build.bat             # Windows
```

This runs `dotnet restore` and `dotnet build` against `src/IO.Swagger/`, then prints the `dotnet run` command to start the project.

Docker build (from within the component directory, where a `Dockerfile` is present):

```
docker build -t <component>:latest .
docker run -p 5000:5000 <component>:latest
```

Adapters are not run standalone in production — they are deployed into a CHESS node's K3S cluster via the Core API `/register` operation (see [1.2 Adapter installation](#12-adapter-installation)), which pulls the container image named in the `Container` field of the register payload and invokes the adapter's `/init` endpoint.

1.3 Prerequisites checklist
----------------------------

Before deploying a CHESS node, the following must already be available (see [1.1 Prerequisite installation from scratch](#11-prerequisite-installation-from-scratch) for full setup steps):

- A Kubernetes-compatible cluster, e.g. K3S ([1.1.1](#111-aas-server--core-api-deployment))
- [WSO2 API Manager](https://github.com/wso2/product-apim) instance, used to issue the application key (participant ID) and auth token for the node
- [UUDEX server](https://github.com/pnnl/UUDEX/tree/main/server), backed by:
  - Postgres ([1.1.2](#112-postgres-for-both-api-manager-and-uudex-server))
  - RabbitMQ, deployed via the [RabbitMQ Cluster Operator](https://www.rabbitmq.com/kubernetes/operator/install-operator) ([1.1.3](#113-rabbitmq-for-uudex-server))
- An Azure Digital Twins instance, reachable via a service principal (`adtServiceUrl`, `adtClientId`, `adtClientSecret`, `adtTenantId`)
- .NET SDK and Docker, for building/packaging AAS Server, Core API and adapter images locally

1.4 Prerequisite installation from scratch
-------------------------------------------

The CHESS node requires an API manager instance (https://github.com/wso2/product-apim) and UUDEX server (https://github.com/pnnl/UUDEX/tree/main/server) to connect to and manage the participants / client endpoints.

The application key (participant ID) for the CHESS node installation is obtained by registering a new application in the API manager (https://github.com/wso2/product-apim)  and obtaining the corresponding application key,  from the /devportal of the API manager or associated key manager (https://www.keycloak.org/).  The token is passed in the yaml file for the CHESS node core API deployment. 

The  UUDEX server is deployed using the yaml file:

```
 apiVersion: v1
 kind: ServiceAccount
 metadata:
  name: uudexserver
 ---
 apiVersion: v1
 kind: Service
 metadata:
  name: uudexserver
  labels:
    app: uudexserver
 spec:
  type: LoadBalancer
  ports:
  - port: 3546
    targetPort: 3546
    name: http
    protocol: TCP
  selector:
    app: uudexserver
 ---
 apiVersion: apps/v1
 kind: Deployment
 metadata:
  name: uudexserver-v1
  labels:
    version: v4
 spec:
  replicas: 1
  selector:
    matchLabels:
      app: uudexserver
  template:
    metadata:
      labels:
        app: uudexserver
        version: v1
    spec:
      containers:
      - name: uudexserver
        image: timfa/uudex:latest
        resources:
          requests:
            cpu: 10m
        imagePullPolicy: Always
        ports:
        - containerPort: 3546
      nodeSelector:
         kubernetes.io/arch: amd64
```

Note that the UUDEX server requires the postgres database and RabbitMQ to be installed first.


1.4.1 AAS server / core API Deployment
---------------------------------------

The AAS server and core API are deployed once the other prerequisites have been setup using :

kubectl apply -f aasserver.yaml

kubectl apply -f coreapi.yaml



Core API yaml file:
```
 apiVersion: v1
 kind: ServiceAccount
 metadata:
  name: coreapi
 ---
 apiVersion: v1
 kind: Service
 metadata:
  name: coreapi
  labels:
    app: coreapi
 spec:
  ports:
  - port: 80
    targetPort: 80
    name: http
    protocol: TCP
  selector:
    app: coreapi
 ---
 apiVersion: apps/v1
 kind: Deployment
 metadata:
  name: coreapi
  labels:
    version: v1
 spec:
  replicas: 1
  selector:
    matchLabels:
      app: coreapi
  template:
    metadata:
      labels:
        app: coreapi
        version: v1
    spec:
      containers:
      - name: coreapi
        image: timfa/coreapi:latest
        resources:
          requests:
            cpu: 10m
        imagePullPolicy: Always
        ports:
        - containerPort: 80
        env:
        - name: "PFX_CERT_PATH"
          value: "uudex.pfx"
        - name: "PFX_CERT_PASS"
          value: "flexchess1234"
        - name: "CHESS_NODE"
          value: "<Participant ID>"
        - name: "CHESS_PREFIX"
          value: "it-"
        - name: "AUTH_TOKEN"
          value: "<Token>"
        - name: "adtServiceUrl"
          value: "<ADT URL>"
        - name: "adtClientId"
          value: "<adtClientId>"
        - name: "adtClientSecret"
          value: "<adtClientSecret>"
        - name: "adtTenantId"
          value: "<adtTenantId>"
      nodeSelector:
         kubernetes.io/arch: amd64
```

Note that if the CoreAPI is used to create adapter deployments then the K3S kube config in /etc/rancher/k3s/k3s.yaml are copied into /app/dcconfig.txt (if it is not already up to date within the container)
kubectl cp /etc/rancher/k3s/k3s.yaml coreapi-<ID>:/app/dcconfig.txt
The IP address for the K3S server is obtained from the node IP using:
kubectl get nodes -o wide





1.4.2	Postgres for both API manager and UUDEX server
------------------------------------------------------
Postgres is installed using three yaml files. The first creates a persistent storage volume that is used for storing the data.
```
 kind: PersistentVolume
 apiVersion: v1
 metadata:
  name: postgres-pv-volume
  labels:
    type: local
    app: postgres
 spec:
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/data"
 ---
 kind: PersistentVolumeClaim
 apiVersion: v1
 metadata:
  name: postgres-pv-claim
  labels:
    app: postgres
 spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```
The second part is the configuration map with necessary user/password secrets :
```
 apiVersion: v1
 kind: ConfigMap
 metadata:
  name: postgres-config
  labels:
    app: postgres
 data:
  POSTGRES_DB: postgres
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: gollum
```
The third part is the deployment :
```
 apiVersion: apps/v1
 kind: Deployment
 metadata:
  name: postgisdb
 spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgisdb
  template:
    metadata:
      labels:
        app: postgisdb
    spec:
      containers:
      - name: postgisdb
        image: timfa/apimpostgres:4.0.0
        readinessProbe:
         tcpSocket:
          port: 5432
         initialDelaySeconds: 5
         periodSeconds: 10
        livenessProbe:
         tcpSocket:
          port: 5432
         initialDelaySeconds: 15
         periodSeconds: 20
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 5432
        envFrom:
            - configMapRef:
                name: postgres-config
        volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgres
      volumes:
      - name: postgres
        persistentVolumeClaim:
          claimName: postgres-pv-claim
 ---
 apiVersion: v1
 kind: Service
 metadata:
  name: beacon
 spec:
  ports:
  - port: 5432
  selector:
    app: postgisdb
```
The database uudex is created for the UUDEX server.
```
 kubectl cp uudex_dump.sql <postgisdb pod>:/tmp
 kubectl exec -it <postgisdb pod> -- bash
 createdb -U postgres uudex
 createuser uudex_user
 psql -U uudex_user uudex
 \i /tmp/uudex_dump.sql
 alter role uudex_user with password ‘password’;
```

1.4.3	RabbitMQ for UUDEX server
---------------------------------

The RabbitMQ broker is setup using the Kubernetes  operator which is installed as follows (https://www.rabbitmq.com/kubernetes/operator/install-operator):
```
 kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
```

Then the UUDEX RabbitMQ broker is deployed using the yaml file :
```
 apiVersion: rabbitmq.com/v1beta1
 kind: RabbitmqCluster
 metadata:
  name: uudex
```
Once deployed the RabbitMQ MQTT broker plugin capabilities can be enabled if they are required by using the following console commands:
```
	rabbitmq-plugins enable rabbitmq_mqtt
	rabbitmqctl enable_feature_flag mqtt_v5 
	rabbitmqctl enable_feature_flag rabbit_mqtt_qos0_queue
```

The RabbitMQ UI is accessible on port 15672 and permits admin login using the credentials that are automatically generated on installation (see Figure 4). These are stored in a secret called uudex-default-user. This can be viewed using:
kubectl get secrets uudex-default-user -o yaml

The user uudex-user needs to be created with password umbrella2021 and management tag and permission to access the /* virtual host.
The MQTT port is enabled by applying the service modifier:
 kubectl apply -f rabbitmq_modify.yaml
where the rabbitmq_modify.yaml contains:
```
 apiVersion: rabbitmq.com/v1beta1
 kind: RabbitmqCluster
 metadata:
  name: uudex
 spec:
  replicas: 1
  override:
    service:
      spec:
        ports:
          - name: mqtt # adds an additional port on the service
            protocol: TCP
            port: 1883
    statefulSet:
      spec:
        template:
          spec:
            containers:
              - name: rabbitmq
                ports:
                  - containerPort: 1883 # opens an additional port on the rabbitmq server container
                    name: mqtt
                    protocol: TCP
```


1.5	Adapter installation
-------------------------

The CHESS adapters are installed using the Network core API /register operation with the appropriate Authorization bearer token.  

The CHESS core API /register operation creates the adapter pods and deploy the necessary docker images and then invoke the adapter /init API operations to configure the adapter and associate it with the corresponding CHESS (digital twin). The adapters have access to the CHESS network core APIs to retrieve updates and CHESS status. 

An example register payload is:

```
{"adapter":{
   "Identifier":"venusadapter",
   "Location":"CHESS node 2",
   "Standard":"Victron",
   "Version":"1.0",
   "Id":"simbessadapter",
   "Wireless":"test",
   "Container":"timfa/venus:latest",
   "Credentials":"default",
   "EnvConf":"test",
   "ExposedPort":80,
   "VolumeMount":""
  },
 "chess":[{
   "Identifier":"venusadapter",
   "Location":"<location>",
   "Standard":"MQTT",
   "Version":"1.0",
   "Id":"fr-bess-lab1-chess2-sim"
   }
]}
```

The UUDEX protocol encapsulates the asynchronous messages to selectively permit retrieval over the CHESS network core REST API. The adapter implementation does not need to be directly aware of the remote status updating mechanism via the control plane.

The control plane status handling subjects support asynchronous distribution of status updates (including setting of schedules) to the various CHESS through the corresponding adapters and are given by exchanges in the form:

```
CHESSNode_2_<CHESS id>_<uid>
```
For the data plane the messages are passed either through the UUDEX REST APIs, which can encapsulate the telemetry messages,or a separate local MQTT broker or proxy and the Flex Platform MQTT broker is directly accessible then the telemetry messages can be proxied directly to the corresponding MQTT/RabbitMQ broker of the Flex Platform.  In both cases the telemetry is forwarded to the RabbitMQ server on the Flex Platform, which can bridge between the different protocols. The data plane telemetry subjects are of the form :
```
CHESSNode_2_<CHESS id>telemetry_<uid>
```

Subjects are created on registration of the adapter along with the necessary permissions to access corresponding CHESS digital twin data. Note that the CHESS digital twin names are unique and follow a convention:
```
<country prefix>-<asset owner or operator>-<asset id>[-sim]<name>
```


ACKNOWLEDGEMENT
---------------

The FlexCHESS project has received funding from the
European Union’s Horizon Europe research and innovation
programme under the grant agreement No 101096946. This
work was supported by UK Research and Innovation [grant
number 10048785]. 

For further information see the project website: https://flexchess.eu/

