use strict;
use warnings;

my %styleMap = (
	qr/\@widgetBackground\b/ => '#1C1F26',
	qr/\@mainBackgroun\b/ => '#f8f6f6',
	qr/\@dialogBackground\b/ => '#fff',
	qr/\@inputBackground\b/ => '#e7e7e7',
);

my @styleMapKeys = keys %styleMap;

my $inFileName = 'default.tpl.css';
my $outFileName = 'default.css';

open FH, '<' . $inFileName or die "Can't read from $inFileName.\n";
my @lines = <FH>;
close FH;

my @outLines = ();
foreach my $line (@lines) {
	my $text = $line;
	foreach my $key (@styleMapKeys) {
		my $r = $styleMap{$key};
		$text =~ s/$key/$r/g;
	}
	push @outLines, $text;
}

open FH, '<' . $outFileName or die "Can't read from $outFileName.\n";
@lines = <FH>;
close FH;

if(join('', @lines) eq join('', @outLines)) {
	print "Nothing changed.\n";
}
else {
	open FH, '>' . $outFileName or die "Can't write to $outFileName.\n";
	print FH @outLines;
	close FH;

	print "Done.\n";
}

