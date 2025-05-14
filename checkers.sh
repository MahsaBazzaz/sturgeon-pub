#!/bin/bash
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=500G
#SBATCH --time=8:00:00
#SBATCH --job-name=qiskit
#SBATCH --output=./log/output_%j.txt
#SBATCH --error=./log/error_%j.txt

module load python/3.8.1
pip install --user virtualenv

# Create a clean virtual environment
source ../../../scratch/bazzaz.ma/QEnv/bin/activate

pip install --upgrade pip

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <scheme> <width> <height> <solver>"
  exit 1
fi
scheme=$1
width=$2
height=$3
solver=$4
out="../../../scratch/bazzaz.ma/quantum_sturgeon/$scheme-$width-$height-$solver"
mkdir -p "$out"
# Log start of the job
echo "Job started at $(date)" > ./log/$scheme-$width-$height-$solver-log.txt
echo "Job Parameters: Scheme=$scheme, Width=$width, Height=$height, Solver=$solver" >> ./log/job_log.txt

for ((i=0; i<100; i++))
do
    rand_num=$RANDOM
    echo "Number: $i"
    # Use /usr/bin/time -v to log resource usage (time, memory, etc.)
    # --reach-start-goal l-r 6 --reach-connect "--src { --dst } --move platform --open Eo-" 
    /usr/bin/time -v python scheme2output.py --outfile $out/$rand_num --schemefile ./levels/schemes/checkers-$scheme.scheme --size $width $height --pattern-hard --count-hard --out-tlvl-none --out-result-none --randomize $rand_num --solver $solver
    # Log memory usage and time taken for the iteration
    echo "Iteration $i completed at $(date)" >> ./log/$scheme-$width-$height-$solver-log.txt
done
# Log end of the job
echo "Job completed at $(date)" >> ./log/$scheme-$width-$height-$solver-log.txt
deactivate