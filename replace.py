import argparse
import json
import subprocess


def parse_args():
    parser = argparse.ArgumentParser(
        description='---Replace---\n'
        'Find word within directory and replace all instances',
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('word', type=str, help='word to find')
    parser.add_argument('replace', type=str, help='word to replace')

    return parser.parse_args()


def escape_special_characters(word, replacement_word):
   escaped_word = word.replace('/', '\\/')
   escaped_replacement_word = replacement_word.replace('/', '\\/')
   return escaped_word, escaped_replacement_word


def main():
    args = parse_args()
    try:
        output = subprocess.run(['grep', '-rwlI', args.word, '.'],
                                capture_output=True)
        output.check_returncode()
    except subprocess.CalledProcessError as error:
        print('Failed to find files that contain: {}'.format(args.word))
        exit(1)

    files = output.stdout.decode('utf-8').strip().split('\n')
    word, replace = escape_special_characters(args.word, args.replace)

    sub_cmd = 's/{}/{}/g'.format(word, replace)
    for file in files:
        subprocess.run(['sed', '-i', '.bak', sub_cmd, file])



if __name__ == '__main__':
    main()
