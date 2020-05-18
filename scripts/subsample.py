import random
import argparse


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument('--infile', type=str, help='file to subsample from', required=True)
    parser.add_argument('--seed', type=int, help='random seed', default=1)
    parser.add_argument('--lines', type=int, help='number of lines', default=100000)
    parser.add_argument('--outfile', type=str, help='output file', required=True)

    args = parser.parse_args()
    return args


def main():
    args = parse_args()
    if args.seed:
        random.seed(args.seed)

    with open(args.infile, 'r') as infile, open(args.outfile, 'w') as outfile:
        lines = infile.readlines()
        sampled_lines = random.sample(lines, args.lines)

        for line in sampled_lines:
            outfile.write(line)


if __name__ == main():
    main()
