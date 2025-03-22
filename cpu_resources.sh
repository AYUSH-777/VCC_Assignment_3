#!/bin/bash

# Ensure proper locale settings for floating-point calculations
LC_NUMERIC="en_US.UTF-8"

# Configuration Variables
THRESHOLD=75                                # CPU usage threshold (%)
PROJECT_ID="vcc-assignment-2-452118"        # GCP Project ID
ZONE="asia-south2-c"                        # Preferred GCP Zone
NEW_INSTANCE_NAME="iitj-vcc-assignment-3-auto-vm-4"  # New VM Name
MACHINE_TYPE="e2-medium"                    # Machine type for new VM
IMAGE_FAMILY="debian-11"                    # OS Image Family
IMAGE_PROJECT="debian-cloud"                 # OS Image Project

# Get CPU and Memory usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')

# Display usage
echo "CPU Usage: $CPU%, Memory Usage: $MEM%"

# Check if CPU exceeds threshold
if (( $(echo "$CPU > $THRESHOLD" | bc -l) )); then
    echo "🚨 CPU threshold ($THRESHOLD%) exceeded! Creating a new GCP VM instance..."

    # Create a new VM instance in GCP
    echo "Creating a new GCP VM instance..."
    gcloud compute instances create iitj-vcc-assignment-3-auto-vm-4 \
        --project=vcc-assignment-2-452118 \
        --zone=asia-south2-c \
        --machine-type=e2-medium \
        --image-family=debian-11 \
        --image-project=debian-cloud \
        --service-account=vcc-assignment-3@vcc-assignment-2-452118.iam.gserviceaccount.com

    echo "Copying high-load tasks to GCP VM..."
    gcloud compute scp high_load_tasks.py iitj-vcc-assignment-3-auto-vm-4:~/

    echo "Starting high-load tasks on GCP VM..."
    gcloud compute ssh iitj-vcc-assignment-3-auto-vm-4 --command "python3 ~/high_load_tasks.py &"

    echo "✅ New VM Instance '$NEW_INSTANCE_NAME' created successfully."
else
    echo "✅ CPU load is normal. No new instance required."
fi

# Exit after execution
exit 0
