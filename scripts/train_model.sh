#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models
trained_models=$base/trained_models
configs=$base/configs/
translations=$base/translations

mkdir -p $translations
mkdir -p $models
mkdir -p trained_models

num_threads=4
device=5

# measure time

SECONDS=0

# train factor models:
CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/word-level_de-en.yaml