# ArgoCD Sync Phases (PreSync, Sync, PostSync)

## 🧠 Overview

ArgoCD applies resources in **phases (stages)** instead of all at once:

```
PreSync → Sync → PostSync
```

---

## 🔄 Flow

```
1. PreSync   → runs BEFORE deployment
2. Sync      → deploys main application
3. PostSync  → runs AFTER deployment
```




---

## 🔵 1. PreSync (Before Deployment)

Used for:

* Database migrations
* Setup scripts
* Validations

### Example

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migrate
  annotations:
    argocd.argoproj.io/hook: PreSync
spec:
  template:
    spec:
      containers:
      - name: migrate
        image: busybox
        command: ["sh", "-c", "echo Running DB migration"]
      restartPolicy: Never
```

👉 Runs **before** application is deployed

---

## 🟢 2. Sync (Main Deployment)

This is your normal Kubernetes resources:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 1
```

👉 No special annotation needed

---

## 🟣 3. PostSync (After Deployment)

Used for:

* Health checks
* Smoke tests
* Notifications

### Example

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: health-check
  annotations:
    argocd.argoproj.io/hook: PostSync
spec:
  template:
    spec:
      containers:
      - name: check
        image: busybox
        command: ["sh", "-c", "echo Checking app health"]
      restartPolicy: Never
```

👉 Runs **after** application is deployed

---

## 🔥 Execution Timeline

```
PreSync Job → runs first
     ↓
Application Deployment
     ↓
PostSync Job → runs after success
```

---

## ⚠️ Important Behavior

* ❌ If **PreSync fails** → Deployment stops
* ❌ If **Sync fails** → PostSync will NOT run
* ❌ If **PostSync fails** → App shows degraded

---

## 🧠 When to Use What

| Phase    | Use Case                |
| -------- | ----------------------- |
| PreSync  | DB migration, setup     |
| Sync     | Main application deploy |
| PostSync | Testing, validation     |

---

## ⚡ Hook Delete Policy (Optional)

```yaml
annotations:
  argocd.argoproj.io/hook-delete-policy: HookSucceeded
```

👉 Deletes job after success

---

## 🚀 Real-World Example

```
PreSync  → Run DB migration
Sync     → Deploy backend + frontend
PostSync → Run API health checks
```

---







# ArgoCD Hooks & Hook Deletion Policies

## 🧠 What are ArgoCD Hooks?

ArgoCD **hooks** are special Kubernetes resources (usually Jobs) that run at specific stages of deployment.

They let you execute custom logic like:

* DB migrations
* validations
* tests
* notifications

---

## 🔄 Types of Hooks

You define hooks using annotation:

```yaml
argocd.argoproj.io/hook: 
<TYPE>
```

### Common Hook Types

| Hook Type | When it runs        |
| --------- | ------------------- |
| PreSync   | Before deployment   |
| Sync      | During deployment   |
| PostSync  | After deployment    |
| SyncFail  | If deployment fails |

---

## 🔵 Example: PreSync Hook (DB Migration)

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migrate
  annotations:
    argocd.argoproj.io/hook: PreSync
spec:
  template:
    spec:
      containers:
      - name: migrate
        image: busybox
        command: ["sh", "-c", "echo Running DB migration"]
      restartPolicy: Never
```

---

## 🟣 Example: PostSync Hook (Health Check)

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: health-check
  annotations:
    argocd.argoproj.io/hook: PostSync
spec:
  template:
    spec:
      containers:
      - name: check
        image: busybox
        command: ["sh", "-c", "echo Checking app health"]
      restartPolicy: Never
```

---

## ❌ Example: SyncFail Hook (On Failure)

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: notify-failure
  annotations:
    argocd.argoproj.io/hook: SyncFail
spec:
  template:
    spec:
      containers:
      - name: notify
        image: busybox
        command: ["sh", "-c", "echo Deployment failed!"]
      restartPolicy: Never
```

---

# 🧹 What are Hook Deletion Policies?

By default, hook resources (like Jobs) **stay in the cluster after execution**.

👉 Hook deletion policies control **when to delete them**

---

## 🔧 Define using annotation

```yaml
argocd.argoproj.io/hook-delete-policy: <POLICY>
```

---

## 📊 Common Policies

| Policy             | Meaning                                 |
| ------------------ | --------------------------------------- |
| HookSucceeded      | Delete after success                    |
| HookFailed         | Delete after failure                    |
| BeforeHookCreation | Delete old hook before creating new one |

---

## 🟢 Example: Delete after success

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migrate
  annotations:
    argocd.argoproj.io/hook: PreSync
    argocd.argoproj.io/hook-delete-policy: HookSucceeded
spec:
  template:
    spec:
      containers:
      - name: migrate
        image: busybox
        command: ["sh", "-c", "echo Running DB migration"]
      restartPolicy: Never
```

👉 Job is automatically deleted after success ✅

---

## 🔥 Example: BeforeHookCreation

```yaml
annotations:
  argocd.argoproj.io/hook: PreSync
  argocd.argoproj.io/hook-delete-policy: BeforeHookCreation
```

👉 Deletes old job before creating new one
(Prevents duplicate jobs)

---

# ⚠️ Why deletion policies matter

Without them:

* Jobs accumulate ❌
* Cluster gets cluttered ❌
* Debugging becomes messy ❌

---

# 🧠 Real-World Flow

```text
PreSync Job (DB migration)
    ↓ (deleted after success)
Deployment
    ↓
PostSync Job (health check)
    ↓ (deleted)
```





# SYNC WAVES
All RESOURCES HAVE  WAVE 0 BY DEFAULT
say we want   to deploy  serviceaccount 1 , then  deployment 2  then service 3 ,how to have this ordering 
lower number -10 have higher prioirty than -2  or +7  
sa -2 dep -1 svc 0 