#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models
trained_models=$base/trained_models
configs=$base/configs/
translations=$base/translations

mkdir -p $translations
mkdir -p $models
mkdir -p $trained_models

num_threads=12
device=0

# measure time

SECONDS=0

# train models:

# word-level
CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/word-level_de-en.yaml
source $base/scripts/evaluate_word-level.sh word-level_de-en
cp -r $models/word-level_de-en $trained_models/
rm -r $models/word-level_de-en

# BPE with vocabulary size 2'000
CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/bpe_de-en_2000.yaml
source $base/scripts/evaluate_bpe-level.sh bpe_de-en_2000 2000
cp -r $models/bpe_de-en_2000 $trained_models/
rm -r $models/bpe_de-en_2000

# BPE with vocabulary size 3'000
CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/bpe_de-en_3000.yaml
source $base/scripts/evaluate_bpe-level.sh bpe_de-en_3000 3000
cp -r $models/bpe_de-en_3000 $trained_models/
rm -r $models/bpe_de-en_3000
