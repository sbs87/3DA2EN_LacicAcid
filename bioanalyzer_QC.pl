#!/usr/bin/perl -w
use strict;

my $bioanalyzer_file_name=$ARGV[0];
my %code_to_call=(
	0=>"Bad",
	1=>"Ok concentration",
	2=>"Ok RIN",
	3=>"Ok concentration & RIN",
	4=>"Ok Ratio",
	5=>"Ok concentration & ratio",
	6=>"Good RIN & ratio",
	7=>"Good"
	);
open(my $bioanalyzer_file,$bioanalyzer_file_name);

while(<$bioanalyzer_file>){
	chomp;
	my @line=split("\t");
	my $sample_number=$line[0];
	if($sample_number eq "Sample_Number"){
		next;
	}
	my $sample_name=$line[1];
	my $replicate=$line[2];
    my $concentration=$line[3];
    my $RIN=$line[4];
    if($RIN eq "NA"){
    	$RIN=0;
    }
    my $ratio=$line[5];
    my $call_num=1*($concentration>10)+2*($RIN>7)+4*($ratio>1);
    print $sample_number."\t".$sample_name."\t".$replicate."\t".$call_num."\t".$code_to_call{$call_num}."\n";
    ## Make a call
    ##Print & save
}
close($bioanalyzer_file);
