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
source $base/scripts/test_beam_sizes.sh 2

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 4 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 4

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 6 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 6

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 8 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 8

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 10 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 10

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 12 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 12

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 14 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 14

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 16 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 16

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 18 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 18

python3 scripts/change_beam_sizes.py --infile configs/bpe_de-en_3000.yaml --beamsize 20 --outfile configs/'bpe_de-en_3000_new_beam-size.yaml'
source $base/scripts/test_beam_sizes.sh 20