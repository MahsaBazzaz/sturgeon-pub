#!/bin/bash
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=3
#SBATCH --mem=200G
#SBATCH --time=8:00:00
#SBATCH --job-name=mario
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
out="../../../scratch/bazzaz.ma/quantum_sturgeon/$solver"
mkdir -p "$out"

for ((i=0; i<100; i++))
do
    rand_num=$RANDOM
    echo "Number: $i"
    python scheme2output.py --outfile $out/$rand_num --schemefile ./levels/schemes/mario-$scheme.scheme --size $width $height --pattern-hard --count-hard --out-tlvl-none --out-result-none --randomize $rand_num --reach-start-goal l-r 6 --reach-connect "--src { --dst } --move platform --open Eo-" --solver $solver
done
deactivate