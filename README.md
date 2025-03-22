# Auto-Scaling and Web Application Deployment on GCP  

## Overview  
This project automates resource monitoring and scales high-load tasks to **Google Cloud Platform (GCP)** when CPU usage exceeds a predefined threshold (**75%**). It ensures seamless task migration while keeping the web application running efficiently.  

## Features  
- **Real-time CPU and Memory Monitoring** – Detects system resource usage and initiates scaling.  
- **Auto-Scaling Mechanism** – Automatically launches a new **GCP VM** when CPU usage exceeds the threshold.  
- **Task Migration** – High-load tasks (`Task 2` and `Task 4`) are moved to the new GCP instance.  
- **Flask Web Application Deployment** – Runs a Flask-based web app inside the GCP VM to manage tasks.  

## Repository Structure  
```sh
📂 auto-scaling-gcp
├── cpu_resources.sh        # Monitors CPU/memory and triggers auto-scaling
├── monitor.sh              # Secondary script for system resource tracking
├── monitor_resources.sh    # Logs system resource usage
├── app.py                  # Flask-based web application
└── README.md               # Project documentation

Prerequisites
* Google Cloud SDK installed and authenticated
* GCP project with Compute Engine enabled
* gcloud CLI configured
* Python 3.9+ installed

Deployment Steps
1️⃣ Clone the Repository
git clone https://github.com/your-repo/auto-scaling-gcp.git  
cd auto-scaling-gcp
 
2️⃣ Run the Monitoring Script
chmod +x cpu_resources.sh  
./cpu_resources.sh  
This will monitor CPU usage and automatically create a new GCP VM when the threshold is exceeded.

3️⃣ SSH into the New GCP Instance
gcloud compute ssh iitj-vcc-assignment-3-auto-vm-4 --zone=asia-south2-c

4️⃣ Install Flask in the GCP VM
pip3 install flask  
export PATH=$HOME/.local/bin:$PATH  
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc  
source ~/.bashrc

5️⃣ Run the Flask Web App
export FLASK_APP=app.py  
flask run --host=0.0.0.0 --port=5000 &

6️⃣ Access the Web Application
* Open a browser and go to: cpp CopyEdit   http://<GCP_VM_EXTERNAL_IP>:5000  
* The web app should now be running and handling high-load tasks seamlessly.
* Flask command not found? Run: sh CopyEdit   export PATH=$HOME/.local/bin:$PATH
* VM Creation Warning? GCP might display warnings about global DNS; you can use zonal DNS instead.
