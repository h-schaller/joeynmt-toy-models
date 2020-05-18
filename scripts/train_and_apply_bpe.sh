#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

preprocessed_data=$base/preprocessed_data
bpe=$base/bpe
tools=$base/tools
shared_models=$base/shared_models

src=de
trg=en

vocab_size_1=2000
vocab_size_2=3000

mkdir -p $bpe

# learn BPE model for vocabulary size of 2'000
subword-nmt learn-joint-bpe-and-vocab -i $preprocessed_data/train.tok.de-en.$src $preprocessed_data/train.tok.de-en.$trg --write-vocabulary $src-vocabulary_$vocab_size_1 $trg-vocabulary_$vocab_size_1 -s $vocab_size_1 --total-symbols -o $bpe/bpe-model_$vocab_size_1
mv $base/$src-vocabulary_$vocab_size_1 $bpe
mv $base/$trg-vocabulary_$vocab_size_1 $bpe

# apply BPE model for source and target training, development and test data
# src
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_1 --vocabulary $bpe/$src-vocabulary_$vocab_size_1 --vocabulary-threshold 10 < $preprocessed_data/test.tok.de-en.$src > $preprocessed_data/test.bpe_$vocab_size_1.de-en.$src
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_1 --vocabulary $bpe/$src-vocabulary_$vocab_size_1 --vocabulary-threshold 10 < $preprocessed_data/dev.tok.de-en.$src > $preprocessed_data/dev.bpe_$vocab_size_1.de-en.$src
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_1 --vocabulary $bpe/$src-vocabulary_$vocab_size_1 --vocabulary-threshold 10 < $preprocessed_data/train.tok.de-en.$src > $preprocessed_data/train.bpe_$vocab_size_1.de-en.$src

# trg
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_1 --vocabulary $bpe/$trg-vocabulary_$vocab_size_1 --vocabulary-threshold 10 < $preprocessed_data/test.tok.de-en.$trg > $preprocessed_data/test.bpe_$vocab_size_1.de-en.$trg
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_1 --vocabulary $bpe/$trg-vocabulary_$vocab_size_1 --vocabulary-threshold 10 < $preprocessed_data/dev.tok.de-en.$trg > $preprocessed_data/dev.bpe_$vocab_size_1.de-en.$trg
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_1 --vocabulary $bpe/$trg-vocabulary_$vocab_size_1 --vocabulary-threshold 10 < $preprocessed_data/train.tok.de-en.$trg > $preprocessed_data/train.bpe_$vocab_size_1.de-en.$trg

# build a joint vocabulary file for training
mkdir -p $shared_models
python3 $tools/joeynmt/scripts/build_vocab.py $preprocessed_data/train.bpe_$vocab_size_1.de-en.$src preprocessed_data/train.bpe_$vocab_size_1.de-en.$trg --output_path $shared_models/vocabulary_$vocab_size_1.$src-$trg

###

# Do the same steps for BPE model with vocabulary size of 3'000
subword-nmt learn-joint-bpe-and-vocab -i $preprocessed_data/train.tok.de-en.$src $preprocessed_data/train.tok.de-en.$trg --write-vocabulary $src-vocabulary_$vocab_size_2 $trg-vocabulary_$vocab_size_2 -s $vocab_size_2 --total-symbols -o $bpe/bpe-model_$vocab_size_2
mv $base/$src-vocabulary_$vocab_size_2 $bpe
mv $base/$trg-vocabulary_$vocab_size_2 $bpe

# apply BPE model for source and target training, development and test data
# src
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_2 --vocabulary $bpe/$src-vocabulary_$vocab_size_2 --vocabulary-threshold 10 < $preprocessed_data/test.tok.de-en.$src > $preprocessed_data/test.bpe_$vocab_size_2.de-en.$src
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_2 --vocabulary $bpe/$src-vocabulary_$vocab_size_2 --vocabulary-threshold 10 < $preprocessed_data/dev.tok.de-en.$src > $preprocessed_data/dev.bpe_$vocab_size_2.de-en.$src
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_2 --vocabulary $bpe/$src-vocabulary_$vocab_size_2 --vocabulary-threshold 10 < $preprocessed_data/train.tok.de-en.$src > $preprocessed_data/train.bpe_$vocab_size_2.de-en.$src

# trg
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_2 --vocabulary $bpe/$trg-vocabulary_$vocab_size_2 --vocabulary-threshold 10 < $preprocessed_data/test.tok.de-en.$trg > $preprocessed_data/test.bpe_$vocab_size_2.de-en.$trg
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_2 --vocabulary $bpe/$trg-vocabulary_$vocab_size_2 --vocabulary-threshold 10 < $preprocessed_data/dev.tok.de-en.$trg > $preprocessed_data/dev.bpe_$vocab_size_2.de-en.$trg
subword-nmt apply-bpe -c $bpe/bpe-model_$vocab_size_2 --vocabulary $bpe/$trg-vocabulary_$vocab_size_2 --vocabulary-threshold 10 < $preprocessed_data/train.tok.de-en.$trg > $preprocessed_data/train.bpe_$vocab_size_2.de-en.$trg

# build a joint vocabulary file for training
mkdir -p $shared_models
python3 $tools/joeynmt/scripts/build_vocab.py $preprocessed_data/train.bpe_$vocab_size_2.de-en.$src preprocessed_data/train.bpe_$vocab_size_2.de-en.$trg --output_path $shared_models/vocabulary_$vocab_size_2.$src-$trg