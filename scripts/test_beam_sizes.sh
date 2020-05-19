#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

preprocessed_data=$base/preprocessed_data
data=$base/data
configs=$base/configs

translations=$base/translations

src=de
trg=en

beamsize="$1"

MOSES=$base/tools/moses-scripts/scripts

num_threads=12
device=0

# measure time

SECONDS2=0
echo "beam size $beamsize"
model_name_dir=bpe_de-en_3000_new_beam-size
for model_name in $model_name_dir; do

    echo "###############################################################################"
    echo "model_name $model_name"

    translations_sub=$translations/$model_name/beam_size_test

    mkdir -p $translations_sub

    # translations

    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < $preprocessed_data/test.tok.de-en.$src > $translations_sub/test.tok.$model_name.$beamsize.$trg

    # undo tokenization

    cat $translations_sub/test.tok.$model_name.$beamsize.$trg | $MOSES/tokenizer/detokenizer.perl -l $trg > $translations_sub/test.$model_name.$beamsize.$trg

    # compute case-sensitive BLEU on detokenized data

    cat $translations_sub/test.$model_name.$beamsize.$trg | sacrebleu $data/test.de-en.$trg

done

echo "time taken:"
echo "$SECONDS2 seconds"