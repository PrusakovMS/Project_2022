#!/bin/bash
#SBATCH -N 1
###SBATCH --cpus-per-task=4 # OpenMP threads
#SBATCH --ntasks-per-node=4 # MPI process
#SBATCH --partition=RT
#SBATCH --job-name=example_test
#SBATCH --comment="commnet for example"

TOKEN='5393517484:AAHE8cvXA25p-JlehVENxgtu1K5RJ00-AzA'
CHATID='752707286'
mkdir -p log/
mkdir -p png/
mkdir -p rdf/

curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="Poiseuille flow starting!
"
for temp in 0.5 1.0 1.5 2.0 2.5 3.0
do
	sed "s/YYYYTEMP/$temp/g" ./in.flow.pois > ./in.flow.pois_for_run
	srun -N 1 -p RT --ntasks-per-node=4 ~/bin/lmp_mpi -in in.flow.pois_for_run > log/log.lammps_$temp
	python get_rdf.py $temp
	echo "Temp: $temp finished"
	curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendPhoto -F chat_id=${CHATID} -F photo="@png/temp_${temp}.png" -F caption="Temp: $temp finished"
done
curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendDocument -F chat_id=${CHATID} -F document=@'dump.flow' -F caption="Dumpfile attached"
