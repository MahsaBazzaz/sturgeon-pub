#!/bin/bash
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=200G
#SBATCH --time=00:10:00
#SBATCH --job-name=dependecies
#SBATCH --output=./log/output_%j.txt
#SBATCH --error=./log/error_%j.txt

module load python/3.8.1
pip install --user virtualenv

# Create a clean virtual environment
virtualenv ../../../scratch/bazzaz.ma/QEnv
source ../../../scratch/bazzaz.ma/QEnv/bin/activate

pip install --upgrade pip
# pip install -r requirements.txt
pip install qiskit qiskit-optimization
deactivate