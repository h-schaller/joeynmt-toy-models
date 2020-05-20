#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

translations=$base/translations
translations_beam_sizes=$translations/translations_beam_sizes

num_threads=12
device=0

# measure time

SECONDS=0

mkdir -p $translations_beam_sizes

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 2 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 2 > beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 4 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 4 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 6 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 6 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 8 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 8 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 10 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 10 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 12 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 12 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 14 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 14 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 16 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 16 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 18 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 18 >> beam_size_results.txt

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 20 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 20 >> beam_size_results.txt

python3 scripts/beam_graph.py --infile beam_size_results.txt