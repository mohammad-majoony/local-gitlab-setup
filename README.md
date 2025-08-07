
# 🦊 GitLab Local Dev with CI/CD and Container Registry

This repository sets up a **self-contained GitLab environment** using Docker Compose. It includes:

- ✅ GitLab CE Server
- 🏃 GitLab Runner (Docker executor with DinD)
- 📦 GitLab Container Registry
- 🧪 Sample `.gitlab-ci.yml` pipeline with Python build, test, and Docker image stages

---

## 📁 Project Structure

```text
.
├── .gitlab-ci.yml             # CI/CD pipeline
├── docker-compose.yml         # GitLab + Runner setup
├── register-runner.sh         # Auto-register the GitLab Runner
````

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/mohammad-majoony/local-gitlab-setup.git
cd local-gitlab-setup
```

### 2. Start GitLab and GitLab Runner

```bash
docker compose up -d
```

GitLab will be available at: [http://localhost:80](http://localhost:80)

---

### 3. Register the GitLab Runner

Edit `register-runner.sh` if needed (e.g. update token), then run:

```bash
chmod +x register-runner.sh
./register-runner.sh
```

The runner will be registered using Docker executor, connected to the internal Docker network.

---

## 🧪 Sample CI/CD Pipeline

The `.gitlab-ci.yml` file defines the following stages:

### 🔨 Build

* Creates a Python virtual environment and installs dependencies.
* Uses `python:3.9-alpine`.

### ✅ Test

* Runs `test.py` using the virtual environment created in the build stage.

### 🐳 Image Build & Push

* Builds a Docker image and pushes it to GitLab Container Registry (`gitlab-server:5001`).
* Uses Docker-in-Docker (`docker:dind`).

---

## 🔐 GitLab Server Credentials (Default)

> These are for **local development only** — change them in production!

* **Email / Username**: `admin@gmail.com`
* **Password**: `admin@gmail.com`

---

## 🧰 GitLab Container Registry

Your registry is available at:

```
http://gitlab-server:5001
```

You can login using:

```bash
docker login -u <your-username> -p <your-password> http://gitlab-server:5001
```

And push images like:

```bash
docker tag my-image gitlab-server:5001/namespace/project:latest
docker push gitlab-server:5001/namespace/project:latest
```

---

## 🧹 Cleanup

To stop and remove all containers, networks, and volumes:

```bash
docker compose down -v
```

---

## 📝 Notes

* Uses a custom Docker network (`gitlab-in-docker`) to allow services to communicate.
* DIND runner allows Docker builds within CI pipelines.
* The registry is enabled and runs alongside GitLab on port `5001`.
