#!/usr/software/bin/perl5.14.0

use 5.014;
use warnings;
use feature 'say';

use Data::Dumper;
use Params::Validate qw(:all);
use Scalar::Util;


my %key_words = ();
my $stop = '';
my $delete;
while(lc($stop) ne 'quit') {
    say "Enter string you are looking for: ";
    my $key = <STDIN>;
    chomp($key);
    #$key_words{$key};

    while(not defined($delete)) {
        say "Do you want to delete the whole line where the string is located? (y/n)";
        my $input = <STDIN>;
        chomp($input);
        if( lc($input) eq 'y' || lc($input) eq 'yes' ) {
            $delete = 1;
            $key_words{$key}{sub} = '';
        }
        if ( lc($input) eq 'n' || lc($input) eq 'no') {
            $delete = 0;

            say "Enter string you would like to sub for $key: ";
            $key_words{$key}{sub} = <STDIN>;
                chomp($key_words{$key});
            }
    }

    $key_words{$key}{del} = $delete;

    say "Type 'quit' to search and replace or Enter to add more substitutions: ";
    my $x = <STDIN>;
    chomp($x);
    $stop = $x;
}

my %openfiles;

my $grep_output;
foreach my $search (keys %key_words){

    say "Looking for $search.......";
    #my $cmd = "grep -rwl $search .";
    my $cmd = "grep -rl '$search' .";
    $grep_output = `$cmd`;
    chomp($grep_output);
    my @array = split('\n', $grep_output);

    #found something
    if(scalar(@array) > 0) {
        foreach my $file(@array) {
            print $file . "\n";
            my $cmd = "px -c default edit " . $file;
            say "Opening File $file.......";
            system($cmd);

            say "Subbing words out $search for $key_words{$search}->{sub}";

            #sub out every instance in the file
            if ( ! $key_words{$search}->{del} ) {
                $cmd = "sed -i -e 's/$search/$key_words{$search}/g' $file";
                system($cmd);
            }else {
                $cmd = "sed -i -e '/$search/d' $file";
                system($cmd);
            }
        }

    } else {
        say "Didnt find anything matching key given";
    }
}
