# Steps
(adapted from the repo of bricksdont)

Clone this repository in the desired place and check out the correct branch:

```sh
git clone https://github.com/h-schaller/joeynmt-toy-models.git
cd joeynmt-toy-models
checkout ex5
```

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

```sh
./scripts/make_virtualenv.sh
```

Activate the env by executing the `source` command that is output by the shell script above:

```sh
source ./venvs/torch3/bin/activate
```

Download and install required software:

```sh
./scripts/download_install_packages.sh
```

Download data:
```sh
./scripts/download_data.sh
```

Preprocess data:

```sh
./scripts/preprocess_data.sh
```

Then finally train a model:

```sh
./scripts/train.sh
```

Evaluate a trained model with

```sh
./scripts/evaluate.sh
```
