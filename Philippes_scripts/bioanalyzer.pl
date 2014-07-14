#!/usr/bin/perl -w
# prints a quality control score of Good, Ok, or Bad for Bioanalyzer data
# must be run on the command line with a target file like:
# perl bioanalyzer.pl Bioanalyzer_Summary.txt

use strict; use warnings; use Regexp::Common;

# the first line doesn't have useful values, get rid of it
my $first_line = <>;
chomp($first_line);

while(<>) {
	
	my @f = split("\t");

	my $sample_number = $f[0];
	my $sample_name = $f[1];
	my $replicate = $f[2];
	my $concentration = $f[3];
	my $RIN = $f[4];
	my $ratio = $f[5];
	my $RIN_flag = '';

	my $QC = '';

	# If $RIN is not a real number (it could be N/A) then change it
	# to 1 so that it can still be evaluated
	unless ($RIN =~ /$RE{num}{real}/) { 
		$RIN = 1;
		$RIN_flag = 'RIN is N/A';
	}

	if (($concentration >= 10) && ($RIN >= 8) && ($ratio >= 1)) {
		$QC = 'Good';
	} elsif (($concentration >= 10) & (($RIN < 8) || ($ratio < 1))) {
		$QC = 'Ok';
	} elsif ( ($concentration < 10) || (($RIN < 8) && ($ratio < 1))) {
		$QC = 'Bad';
	} else {
		$QC = 'N/A';
	}

	print "Sample"."\t".$sample_number."\t".$sample_name."\t".$QC."\t".$RIN_flag."\n";
}

exit;