<div align="center">
  <p><strong>Designed & Documented by Mertugral</strong></p>
  <p>© 2025 Mertugral. All rights reserved.</p>
  <p><a href="https://github.com/ertugralmert">GitHub</a> | <a href="https://linkedin.com/in/mertertugral">LinkedIn</a></p>
</div>  

---
# Liberty WAR Files & Installer

This repository contains WAR files and a shell script for installing IBM WebSphere Liberty. All files are available via GitHub Releases and can be downloaded individually either via browser or command-line.

---

## 📥 Download Links

You can download files using your browser or terminal:

| File | Browser | Terminal |
|------|---------|----------|
| form-demo.war | [Download](https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/form-demo.war) | `curl -LO https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/form-demo.war` |
| formula.war | [Download](https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/formula.war) | `curl -LO https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/formula.war` |
| liberty-demo.war | [Download](https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/liberty-demo.war) | `curl -LO https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/liberty-demo.war` |
| memoryleak.war | [Download](https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/memoryleak.war) | `curl -LO https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/memoryleak.war` |
| install_liberty_root.sh | [Download](https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/install_liberty_root.sh) | `curl -LO https://github.com/ertugralmert/liberty-warfiles/releases/download/v1.0.0/install_liberty_root.sh` |

---

## 🔧 Running the Shell Script

To install Liberty using the script:

```bash
chmod +x install_liberty_root.sh
./install_liberty_root.sh

---
WAR Deployment to Liberty

After downloading the WAR files, copy them to your Liberty server’s `dropins` directory:

```bash
cp *.war /opt/ibm/wlp/usr/servers/<serverName>/dropins/
```

### 🌐 Context Roots:

|WAR File|Context Root|PATH|
|---|---|---|
|form-demo.war|`/form-demo`|` `,/date`|
|formula.war|`/formula`|`/constructor-standings`, `/driver-standings`, `/race-calendar`|
|liberty-demo.war|`/liberty-demo`|
|memoryleak.war|`/memoryleak`|`/leak`|

---

---

## 🧠 Memory Leak Demonstration

The `memoryleak.war` file contains a basic Spring Boot application that demonstrates a memory leak through a static map that continuously grows with each HTTP request.

### 🔍 How It Works

- Each call to the `/leak` endpoint allocates **1 MB of heap memory** and stores it in a static `Map`.
- This simulates a memory leak scenario where the application keeps consuming more memory with no release.
- Over time, if requests continue, the application will trigger **OutOfMemoryError (OOM)**.

### 📁 Log Monitoring

To observe this behavior, you can monitor the Liberty server logs:

```bash
tail -f /opt/ibm/wlp/usr/servers/<serverName>/logs/messages.log
```

You will see memory usage increasing with each call to `/leak`.

### 🧪 Endpoint Details

- **URL**: `/memoryleak/leak`
- **Behavior**: Allocates 1 MB per call
- **Response**: Simple HTML indicating the current size of the leak

---

> ⚠️ **Warning**: This demo should only be used in development/test environments.  
It is intentionally designed to simulate a memory leak and will eventually cause the server to crash if used repeatedly.

---

---

## 🧠 Memory Leak Demonstration

The `memoryleak.war` file contains a basic Spring Boot 2.7.18 application (running with Java 1.8) that demonstrates a memory leak through a static map that continuously grows with each HTTP request.

### 🔍 How It Works

- Each request to the `/memoryleak/leak` endpoint allocates **1 MB** of memory.
- Allocated memory is never released, causing the JVM heap to grow.
- Over time, repeated calls to `/leak` will eventually cause an **OutOfMemoryError (OOM)**.

### 📁 Log Monitoring

You can observe memory behavior and errors by monitoring the Liberty server logs:

```bash
tail -f /opt/ibm/wlp/usr/servers/defaultServer/logs/messages.log
```

Heap usage will increase after every `/leak` request.


### 🧪 Stress Testing the Memory Leak

You can quickly fill up the memory and simulate a server crash by making multiple requests using tools like `ab` (Apache Benchmark) or a simple `for` loop:

**Using Apache Benchmark (ab):**

```bash
ab -n 5000 -c 100 http:<IP_or_Hostname>:9080/memoryleak/leak
```
- `-n 5000` → Total 5000 requests
- `-c 100` → 100 concurrent requests

**Using a Bash for loop:**

```bash
for i in {1..1000}; do curl -s http://<IP_or_Hostname>:9080/memoryleak/leak; done
```
- Sends 1000 sequential requests to `/leak`.
- Heap usage will grow with each request.

---

> ⚠️ **Warning**: This demo is intended for educational or development use only. It will intentionally cause an OutOfMemoryError if stress tested.  
> Always use it in isolated or disposable environments.

---


<div align="center">
  <p><strong>Designed & Documented by Mertugral</strong></p>
  <p>© 2025 Mertugral. All rights reserved.</p>
  <p><a href="https://github.com/ertugralmert">GitHub</a> | <a href="https://linkedin.com/in/mertertugral">LinkedIn</a></p>
</div>
