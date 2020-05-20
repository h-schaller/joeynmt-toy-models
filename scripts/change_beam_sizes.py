#! /usr/bin/python3

import ruamel.yaml
import argparse
import sys


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument('--infile', type=str, help='path of YAML file to read from', required=True)
    parser.add_argument('--beamsize', type=int, help='beam size to insert in config file', required=True)
    parser.add_argument('--outfile', type=str, help='new YAML outfile', required=True)

    args = parser.parse_args()
    return args


def main():
    args = parse_args()
    yaml = ruamel.yaml.YAML()

    with open(args.infile, 'r') as infile, open(args.outfile, 'w') as outfile:
        file = yaml.load(infile)

        if file['testing']['beam_size']:
            file['testing']['beam_size'] = args.beamsize
        else:
            sys.exit('There is no beam size specified in the YAML file.')

        if file['training']['model_dir']:
            file['training']['model_dir'] = "trained_models/bpe_de-en_3000"

        if file['name']:
            file['name'] = "bpe_de-en_3000_new_beam-size"

        yaml.dump(file, outfile)


if __name__ == main():
    main()





