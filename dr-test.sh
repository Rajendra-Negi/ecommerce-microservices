#!/bin/bash

# Namespace and deployment name
NS="ingress-nginx"
DEPLOY="ingress-nginx-controller"
TM_ENDPOINT="ecommerce-global.trafficmanager.net"
TEST_PATH="/products"

echo "=== Starting DR Drill ==="

# Step 1: Scale down ingress controller
echo "[1] Scaling down $DEPLOY to 0 replicas..."
kubectl scale deploy $DEPLOY -n $NS --replicas=0

# Step 2: Wait for Traffic Manager to detect failure
echo "[2] Waiting 90 seconds for Traffic Manager failover..."
sleep 90

# Step 3: Test Traffic Manager resolution
echo "[3] Checking Traffic Manager DNS resolution..."
nslookup $TM_ENDPOINT

echo "[3] Curling Traffic Manager endpoint..."
curl -s http://$TM_ENDPOINT$TEST_PATH

# Step 4: Scale ingress controller back up
echo "[4] Restoring $DEPLOY to 1 replica..."
kubectl scale deploy $DEPLOY -n $NS --replicas=1

# Step 5: Wait for recovery
echo "[5] Waiting 60 seconds for recovery..."
sleep 60

# Step 6: Test again
echo "[6] Curling Traffic Manager endpoint after recovery..."
curl -s http://$TM_ENDPOINT$TEST_PATH

echo "=== DR Drill Complete ==="
