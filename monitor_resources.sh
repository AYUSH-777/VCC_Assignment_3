#!/bin/bash

# Ensure proper locale settings for floating-point calculations
LC_NUMERIC="en_US.UTF-8"

# Configuration Variables
THRESHOLD=75                                # CPU usage threshold (%)
PROJECT_ID="vcc-assignment-2-452118"        # GCP Project ID
ZONE="asia-south2-c"                        # Preferred GCP Zone
NEW_INSTANCE_NAME="iitj-vcc-assignment-3-auto-vm-1"  # New VM Name
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
    gcloud compute instances create "$NEW_INSTANCE_NAME" \
        --project="$PROJECT_ID" \
        --zone="$ZONE" \
        --machine-type="$MACHINE_TYPE" \
        --image-family="$IMAGE_FAMILY" \
        --image-project="$IMAGE_PROJECT"

    echo "✅ New VM Instance '$NEW_INSTANCE_NAME' created successfully."
else
    echo "✅ CPU load is normal. No new instance required."
fi

# Exit after execution
exit 0
