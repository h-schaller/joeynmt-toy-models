# joeynmt-toy-models

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), preprocess
data, train and evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place and check out the correct branch:

    git clone https://github.com/bricksdont/joeynmt-toy-models
    cd joeynmt-toy-models
    checkout ex4

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

Download and split data:

    ./scripts/download_split_data.sh

Preprocess data:

    ./scripts/preprocess.sh

Then finally train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh

-------------------------------------------------------------------------
# Changes and Findings of Exercise 4
## What needs to be done to recreate set-up
- Fork and clone this repository: <https://github.com/h-schaller/joeynmt>

- Change the branch:
```sh
git checkout factors
```

- Set up virtual environment
```sh
./scripts/toy_model_scripts/make_virtualenv.sh
source venvs/torch3/bin/activate
```

- Download packages
```sh
./scripts/toy_model_scripts/download_install_packages.sh
```

- Download prepared data
```sh
./scripts/toy_model_scripts/download_preprocessed_data.sh
```

## Train models with source factors
I trained six models with different embedding sizes for the source, factor and decoder embedding sizes (since I wasn't sure what would be optimal).
To train and evaluate these six models, run the script `train.sh`. This will train and evaluate (by calling the script `evaluate.sh` inside of `train.sh`) all six models automatically and save the models with its translations in the folder `trained_models`:
```sh
./scripts/toy_model_scripts/train.sh
```

These are the models with their embedding sizes and BLEU scores:

Model | Factor embedding size | Source embedding size | Decoder embedding size | BLUE score
--- | --- | --- | --- | ---
rnn_wmt16_deen (baseline model) | - | 512 | 512 | 8.8
rnn_wmt16_factors_concatenate_deen1 | 10 | 490 | 500 | 3.0
rnn_wmt16_factors_concatenate_deen2 | 512 | 512 | 512 | 5.2
rnn_wmt16_factors_concatenate_deen3 | 2048 | 2048 | 2048 | 12.2
rnn_wmt16_factors_add_deen1 | 500 | 500 | 500 | 6.0
rnn_wmt16_factors_add_deen2 | 2048 | 2048 | 1024 | 11.0
rnn_wmt16_factors_add_deen2 | 2048 | 2048 | 2048 | 11.0

The BLEU scores were better for the models including source factors when embedding sizes of 2048 were chosen (both by adding and concatenating source and factor embeddings).
However, maybe even better BLEU scores could be achieved by using more adequate embedding sizes or increasing the number of training epochs. In this case, 2 epochs were trained for each model.

## Changes made in `model.py`
When the model is built in `build_model()` and `add` is given for the parameter `factor_combine`, it is now checked whether source and factor embedding dimensions are compatible. A `ConfigurationError` is raised if they're not.
The function `encode()` now checks for the parameter `factor_combine` in the configuration file. Depending on the given method of including source factors,
the factor and source embeddings are either added or concatenated by calling the new functions `concatenate_embeddings` or `add_embeddings`.
