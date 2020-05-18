#! /bin/bash

# This script subsamples 100'000 lines from source and target language files and tokenises the sampled lines.

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
preprocessed_data=$base/preprocessed_data
tools=$base/tools

src=de
trg=en

num_lines=100000

mkdir -p $preprocessed_data

#################################################################

python3 $scripts/subsample.py --infile $data/train.de-en.$src --seed 1 --lines $num_lines --outfile prep.train.de-en.$src
sacremoses tokenize -l $src < prep.train.de-en.$src > train.tok.de-en.$src
rm $base/prep.train.de-en.$src
mv $base/train.tok.de-en.$src $preprocessed_data

python3 $scripts/subsample.py --infile $data/train.de-en.$trg --seed 1 --lines $num_lines --outfile prep.train.de-en.$trg
sacremoses tokenize -l $trg < prep.train.de-en.$trg > train.tok.de-en.$trg
rm $base/prep.train.de-en.$trg
mv $base/train.tok.de-en.$trg $preprocessed_data
