# Kubernetes and Docker Demo Project

## 📋 About This Project

This project is a demo application that shows how **Kubernetes** works with **Docker** containers. The main goal is to demonstrate Kubernetes **load balancing** functionality.

## 🎯 What This Demo Shows

- **Load Balancing**: How Kubernetes distributes traffic between multiple pods
- **Container Management**: How Kubernetes manages Docker containers automatically
- **Scaling**: How to increase or decrease the number of pods
- **High Availability**: How multiple pods keep the service running

## 📦 Requirements

1. **Docker Desktop** (free download: https://www.docker.com/products/docker-desktop)
2. **kubectl** (comes with Docker Desktop)

### How to Enable Kubernetes:
1. Open Docker Desktop
2. Click on Settings (⚙️)
3. Select **Kubernetes** from the left menu
4. Check the **"Enable Kubernetes"** box
5. Click **"Apply & Restart"**
6. Wait 1-2 minutes for Kubernetes to start

### Check Kubernetes Status:
```bash
kubectl cluster-info
kubectl get nodes
```

## 🚀 How to Use

### Starting the Demo:

1. Open your terminal
2. Go to the project folder:
```bash
cd /path/to/DockerKubernetesDemo
```

3. Create the deployment:
```bash
kubectl apply -f deployment.yaml
```

4. Create the service:
```bash
kubectl apply -f service.yaml
```

5. Get the service URL:
```bash
kubectl get service demo-app
```

6. Open the URL in your browser (use private/incognito tabs)
7. Open multiple private tabs to see **load balancing** in action

### Testing the Demo:

Each private tab will show a different **hostname**. This proves that your requests are being sent to different pods.

**Test in terminal:**
```bash
curl http://localhost:PORT_NUMBER
```

### Increase the Number of Pods:

```bash
kubectl scale deployment demo-app --replicas=5
```

Now you have 5 pods and the traffic is distributed across all of them!

### Stop and Clean Up:

```bash
kubectl delete deployment demo-app
kubectl delete service demo-app
```

## 📊 Useful Commands

### View Pods:
```bash
kubectl get pods
kubectl get pods -o wide  # More detailed information
```

### View Logs:
```bash
kubectl logs -l app=demo-app --tail=50
```

### View Pod Details:
```bash
kubectl describe pod POD_NAME
```

### View Service:
```bash
kubectl get service demo-app
```

### Watch Pods in Real-time:
```bash
kubectl get pods -w
```

## 🎓 Why Kubernetes?

- **Automatic Management**: Containers start and stop automatically
- **Easy Scaling**: You can easily increase the number of pods
- **High Availability**: If one pod crashes, others continue working
- **Resource Management**: CPU and memory are distributed automatically

### When to Use Kubernetes?
✅ Microservice applications
✅ Web applications with high traffic
✅ Cloud-native applications
✅ Applications that need to scale
✅ Containerized services

### Kubernetes Components:
- **Deployments**: Application deployments
- **Services**: Network management
- **Pods**: Running containers
- **ReplicaSets**: Manages pod replicas

### Docker + Kubernetes:
- **Docker**: Creates and runs containers
- **Kubernetes**: Manages and scales containers

## 📝 Notes

- This demo uses Docker Desktop Kubernetes (single node cluster)
- In production environments, multi-node clusters are used
- Load balancing happens automatically when you have multiple pods

## 👥 Team

BartoooMuch & alihaktan35

---
**Project Date**: November 19, 2025

**Course**: SE 4458 - Software Architecture & Design of Modern Large Scale Systems
