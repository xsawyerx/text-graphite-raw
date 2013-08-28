package Text::Graphite::Raw;
# ABSTRACT: Parse raw Graphite output

use strict;
use warnings;

use parent 'Exporter';
our @EXPORT = 'parse_raw_graphite';

sub parse_raw_graphite {
    my $string  = shift;
    my @metrics = ();

    foreach my $metric ( split /\n/, $string ) {
        # set the PV offset in the SV
        $metric =~ /^[^\|]+\|/g;

        # separate using positions
        my $header = substr( $metric, 0, pos($metric), '' );

        # cut off the separator
        $header =~ s/\|$//;

        # parse the header data
        my @header_data = split ',', $header;
        my @metric_data = split ',', $metric;
        push @metrics, [ @header_data, \@metric_data ];
    }

    return \@metrics;
}

1;

