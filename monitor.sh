!/bin/bash
THRESHOLD=75

# Get CPU and Memory usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')

# Display usage
echo "CPU: $CPU%, Memory: $MEM%"

# Check if CPU exceeds threshold
if (( $(echo "$CPU > $THRESHOLD" | bc -l) )); then
    echo "CPU threshold exceeded! Triggering scaling..."
    ./deploy_to_cloud.sh
fi

# Exit after execution
exit 0
