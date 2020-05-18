#! /bin/bash

# This script subsamples 100'000 lines from source and target language training files and tokenises the sampled lines.
# Tokenisation also of test and dev text files.

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

sacremoses tokenize -l $src < $data/dev.de-en.$src > dev.tok.de-en.$src
mv dev.tok.de-en.$src $preprocessed_data

sacremoses tokenize -l $src < $data/test.de-en.$src > test.tok.de-en.$src
mv test.tok.de-en.$src $preprocessed_data

sacremoses tokenize -l $trg < $data/dev.de-en.$trg > dev.tok.de-en.$trg
mv dev.tok.de-en.$trg $preprocessed_data

sacremoses tokenize -l $trg < $data/test.de-en.$trg > test.tok.de-en.$trg
mv test.tok.de-en.$trg $preprocessed_data
