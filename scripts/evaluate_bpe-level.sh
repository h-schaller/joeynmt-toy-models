#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

preprocessed_data=$base/preprocessed_data
data=$base/data
configs=$base/configs

translations=$base/translations

src=de
trg=en

MOSES=$base/tools/moses-scripts/scripts

num_threads=12
device=0

# measure time

SECONDS2=0
echo $1
model_name_dir="$1"
vocab_size="$2"
for model_name in $model_name_dir; do

    echo "###############################################################################"
    echo "model_name $model_name"

    translations_sub=$translations/$model_name

    mkdir -p $translations_sub

    # translations

    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < $preprocessed_data/test.bpe_$vocab_size.de-en.$src > $translations_sub/test.bpe.$model_name.$trg

    # undo BPE

    cat $translations_sub/test.bpe.$model_name.$trg | sed 's/\@\@ //g' > $translations_sub/test.tok.$model_name.$trg

    # undo tokenization

    cat $translations_sub/test.tok.$model_name.$trg | $MOSES/tokenizer/detokenizer.perl -l $trg > $translations_sub/test.$model_name.$trg

    # compute case-sensitive BLEU on detokenized data

    cat $translations_sub/test.$model_name.$trg | sacrebleu $data/test.de-en.$trg

done

echo "time taken:"
echo "$SECONDS2 seconds"
