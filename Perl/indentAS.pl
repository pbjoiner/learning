#!/usr/bin/perl
#
# indentAS.pl
#
# indents "as" clauses to lign up prettily
#

use warnings;
use English;
use strict;

print &indentAS(<stdin>);

exit;

sub indentAS {
	my @codeBlock = @_; # the block of SQL to examine
	my $endNL = 0;      # save whether the block of code ends in a newline
	                    #   character so we can return it without adding
	                    #   any extras
	if (chop($codeBlock[(scalar @codeBlock - 1)]) eq "\n") { $endNL = 1 }
	
	my $thisLine;       # the current line of SQL
	my $thisIndent;     # the indent level (tabs) at the start of the current line
	my $thisColumn;     # the column selector of the current line
	my $thisAs;         # the as clause of the current line
	my $asSpace = 0;    # the column to prettily indent the "as" clause
	my $thisSpace = 0;  # the space between the beginning of the current
	                    #   line and the start of the white space before
	                    #   the "as"
	my $tabWidth = 3;   # the amount of space to count for tab characters
	my $outBlock;       # the formatted block of code to return
	my $padSpace = 0;   # amount of space to padd a particular line
	my $padded;         # the line after padding
	
	# find the column that will allow all the "as"
	# clauses to line up
	foreach $thisLine (@codeBlock) {
		chomp($thisLine);

		# find instances of "as" following a column selector and
		# count the number of spaces to the rightmost instance of "as"
		# be sure to account for the visible width of tab characters
		if ($thisLine =~ /^(\t*)( *\S.+)\s+(as .*)/i) {
			$thisSpace = length($2) + 1 + length($1) * $tabWidth;
			
			if ($thisSpace > $asSpace) { $asSpace = $thisSpace }
		}
	}

	# now reformat it all
	foreach $thisLine (@codeBlock) {
		chomp($thisLine);

		# this time find all the instances of a line with "as"
		# and padd 
		if ($thisLine =~ /^(\t*)( *.+)\s(as .+)$/i) {
			$thisIndent = $1;
			$thisColumn = $2;
			$thisAs     = $3;
			# account for apparent width of tabs
			$padSpace = $asSpace - ($tabWidth * length($1));
			
			# if the "as" starts the line, just add space
			if ($thisLine =~ /^\s+as\s/) {
				$padded = ' ' x $padSpace;
			} else {
				$padded = pack("A$padSpace", $thisColumn);
			}
			$outBlock .= "$thisIndent$padded$thisAs\n";
			
		} else {
			$outBlock .= "$thisLine\n";
		}
	}
	
	# take back that last newline so
	# we don't add one to the string
	if (!$endNL) { chomp($outBlock) }
	return $outBlock;
} # end indentAS