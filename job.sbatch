#!/bin/bash
#SBATCH -n 10
#SBATCH -t 48:00:00
#SBATCH -p nvidia
#SBATCH --gres=gpu:1
#SBATCH --output=log.out
#SBATCH --error=log.err
#Other SBATCH commands go here

#Activating conda
source ~/.bashrc
echo "... loading module"
# module load miniconda

echo "... activating conda env ..."
conda activate tf-gpu

# Your appication commands go here
echo " ... running script ..."

# Script running in background to check GPU usage, 
# Runs nvidia-smi command in background 

NUM_PINGS=20 # number of times to check if gpu is in usage
WAIT_SECS=5  # wait time between pings
nohup python check-gpu-state.py $NUM_PINGS $WAIT_SECS &

# Run training script
python keras-script.py
