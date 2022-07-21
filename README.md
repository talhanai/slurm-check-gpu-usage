# slurm-check-gpu-usage
This repo contains scripts to check gpu usage when deploying slurm sbatch script for neural network training. If you deploy a neural network training job (that uses keras, tensorflow, pytorch, etc.) you cannot srun into the same machine to check GPU usage outside of the job itself. That is, your second job (srun) will not see the GPU allocated to your first job. Therefore, you have to check GPU usage within the _same_ job you deployed to train the model. This behavior is specific to jubail.nyu.edu.

### Files
- __job.sbatch__: deploys parallel python scripts with the `nohup` bash command. The first script (__check-gpu-usage.py__) runs the bash command `nvidia-smi` to print the GPU usage to the log file. The second script is an example CNN model training using MNIST with keras / tensorflow.

### To run the job:
```
sbatch job.sbatch
```
Then check the output files (in __log.out__) to see if the GPU is being used. The resulting log files have been included in this directory.

### To control how often GPU is checked:
You can change the variables in the __job.sbatch__ to define how often the GPU is checked during your job, and the wait time between checks. You do not want to ping continuously because it will clutter your log file.

### Environment Setup

This will install a shared conda environment setup for keras/tensorflow into your personal conda environment.
```
module load miniconda
conda create -n tf-gpu --clone tensorflow-2.4.1
echo "export CONDA_ENVS_PATH=$SCRATCH/conda-envs" >> ~/.bashrc
echo "export CONDA_PKGS_DIRS=$SCRATCH/conda-envs/pkgs" >> ~/.bashrc
source ~/.bashrc
conda activate tf-gpu
```

### Interactive Shell
To call an interactive shell into a specific GPU machine at jubail, you will need to run:
```
srun -n 1 -p nvidia --gres=gpu:3 --mem=1G --nodelist=dn003 --pty /bin/bash
```
