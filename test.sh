#!/bin/bash
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=500G
#SBATCH --time=8:00:00
#SBATCH --job-name=test_solvers
#SBATCH --output=./log/output_%j.txt
#SBATCH --error=./log/error_%j.txt

module load python/3.8.1
pip install --user virtualenv

# Create a clean virtual environment
source ../../../scratch/bazzaz.ma/QEnv/bin/activate

pip install --upgrade pip

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <solver>"
  exit 1
fi
solver=$1

echo "Job started at $(date)" > ./log/test-solver-$solver-log.txt
echo "Job Parameters: Solver=$solver" >> ./log/test-solver-$solver-log.txt
python test_solvers.py $solver
echo "Job completed at $(date)" >> ./log/test-solver-$solver-log.txt
deactivate