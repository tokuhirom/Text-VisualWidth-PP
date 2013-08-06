package Text::VisualWidth::PP;
use strict;
use warnings;
use 5.008001;
our $VERSION = '0.01';
use Unicode::EastAsianWidth;

our $EastAsian = $Unicode::EastAsianWidth::EastAsian;

sub InVWPP1Fullwidth() {
    InEastAsianFullwidth() . InEastAsianWide() . InEastAsianAmbiguous()
}
sub InVWPP0Fullwidth() {
    InEastAsianFullwidth() . InEastAsianWide()
}
sub InVWPP1Halfwidth() {
    InEastAsianHalfwidth().
    InEastAsianNarrow().
    InEastAsianNeutral()
}
sub InVWPP0Halfwidth() {
    InEastAsianHalfwidth().
    InEastAsianNarrow().
    InEastAsianNeutral().
    InEastAsianAmbiguous()
}

sub width {
    my $str = shift;

    my $ret = 0;
    if ($EastAsian) {
        while ($str =~ /(\p{InVWPP1Fullwidth}+)|(\p{InVWPP1Halfwidth}+)/g) {
            $ret += $1 ? length($1) * 2 : length($2)
        }
    } else {
        while ($str =~ /(\p{InVWPP0Fullwidth}+)|(\p{InVWPP0Halfwidth}+)/g) {
            $ret += $1 ? length($1) * 2 : length($2)
        }
    }
    $ret;
}

sub trim {
    my ($str, $limit) = @_;

    my $cnt = 0;
    my $ret = '';
    while ($str =~ /(\p{InFullwidth})|(\p{InHalfwidth})/g) {
        if ($1) {
            if ($cnt+2 <= $limit) {
                $ret .= $1;
                $cnt += 2;
            } else {
                last;
            }
        } else {
            if ($cnt+1 <= $limit) {
                $ret .= $2;
                $cnt += 1;
            } else {
                last;
            }
        }
    }
    $ret;
}

1;
__END__

=encoding utf8

=head1 NAME

Text::VisualWidth::PP - trimming text by the number of the column s of terminals and mobile phones.

=head1 SYNOPSIS

    use utf8;
    use Text::VisualWidth::PP;

    Text::VisualWidth::PP::width("あいうえおaiu"); # => 13
    Text::VisualWidth::PP::trim("あいうえおaiu", 7); # => "あいう"

=head1 DESCRIPTION

This module provides functions to treat half-width and full-width characters and display correct size of text in one line on terminals and mobile phones. You can know the visual width of any text and truncate text by the visual width. Now this module support flagged UTF-8 and tested only with Japanese.  

This module is pure perl version of L<Text::VisualWidth>. This is bit slow, but it's not require compiler.

=head1 Ambiguous Characters

This module treats ambiguous characters are half width by default.

And you can specify the behavior by the C<$Text::VisualWidth::PP::EastAsian> flag expressly.

Note: If C<$Unicode::EastAsianWidth::EastAsian> is true on compilation time, this module set C<$Text::VisualWidth::PP::EastAsian> as true for backward compatibility.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

L<Text::VisualWidth>

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
