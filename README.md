### Overview
The application is a webserver that serves a simple web page where  the first time is accessed it shows the string "Hello" and next time "World"  and then flips between then each time it is visited 

#### web-server-hello-world
web-server-hello-world

### Prerequisites
- Docker: Ensure that Docker is installed and running on your machine.
- Kubernetes Cluster: Set up a Kubernetes cluster or use a managed Kubernetes service like Google Kubernetes Engine (GKE) or Amazon Elastic Kubernetes Service (EKS).
- Helm Chart: To execute this deployment make sure you have `helm` command running at least minimal version v3.8.X. [see more](https://helm.sh/docs/intro/install/)
- kubectl: To execute this deployment make sure you have `kubectl` command running. [see more info](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)


### Directory structure
```bash
.
├── README.md                   # Readme file 
├── build       
│   └── build_image.sh          # Build script to help build docker file and send to docker hub 
├── k8s
│   └── helm                    # helm Chart Template do deploy aplication on kubernetes 
│       ├── Chart.yaml
│       ├── templates
│       │   ├── NOTES.txt
│       │   ├── RoleBinding.yaml
│       │   ├── ServiceAccount.yaml
│       │   ├── ServiceRole.yaml
│       │   ├── _helpers.tpl
│       │   ├── configmap.yaml
│       │   ├── deployment.yaml
│       │   ├── hpa.yaml
│       │   ├── quota.yaml
│       │   ├── secret.yaml
│       │   └── service.yaml
│       └── values.yaml
└── web-app                         
    └── app                         ### Application Folder 
        ├── Dockerfile              # Docker file 
        ├── app.py                  # Application file 
        ├── gunicorn.sh             # Entrypoint start up script 
        └── requirements.txt        # python packages 

6 directories, 19 files

```  


#### docker  local build image 

```
docker build -t web-app -f web-app/app/Dockerfile web-app/app
```

#### local run 

```
 docker run -ti -d -p 8080:80 web-app
 
```
#### Test 
```
curl -vvvv http://localhost:8080
```
Test link from Browser: [web-app]( http://localhost:8080) 

Run on Kubernetes  clusters 

## Use helm chart to deploy
```
 helm upgrade --namespace web-app  --create-namespace=true --wait --timeout=300s --install --values  k8s/helm/values.yaml web-app  k8s/helm/
```

## export service to test application 
```
kubectl port-forward -n web-app service/web-app 8000:80

```

### Test application Open the the address from browser


[web-app](http://localhost:8000)

