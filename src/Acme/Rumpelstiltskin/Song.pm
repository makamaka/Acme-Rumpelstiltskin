package Acme::Rumpelstiltskin::Song;

use strict;

our $VERSION = '0.02';

sub new {
    my ( $class, $pat, $opts ) = @_;
    my $self  = {};

    $self->{ pat }     = $pat;
    $self->{ exclude } = $opts->{ exclude };

    bless $self, $class;
}


sub start {
    my $self = shift;
    my $func = shift;

    my $pat  = $self->{pat};

    $self->{end}  =  @$pat - 1;
    $self->{pto}  = 0;
    $self->{ptrs} = [ map { 0 } @$pat ];
    $self->{func} = $func;

    $self->inc($self->{pto}, $self->{ptrs});
}


sub inc {
    my ($self, $pt, $ps) = @_;

    my $pat = $self->{pat};
    my $end = $self->{end};
    my $max = @{$pat->[$pt]} - 1;

    while ( $ps->[$pt] <= $max ) {
        if ( $pt == $end ) {
            my $name;

            for ( my $i = 0; $i <= $end; $i++ ) {
                $name .= $pat->[ $i ]->[ $ps->[$i] ];
            }

            if (defined  $self->{ exclude } && $name eq $self->{ exclude } ) {
                $ps->[ $pt ]++;
                next;
            }
            $self->{func}->( $self, $name );
        }
        elsif ( defined $pat->[ $pt + 1 ] ) {
            $self->inc( $pt + 1, $ps );
        }

        $ps->[ $pt ]++;
    }

    $ps->[ $pt ] = 0;
}


1;
__END__

=head1 NAME

Acme::Rumpelstiltskin - a fairy tale - Rumpelstiltskin

=head1 SYNOPSIS

  use Acme::Rumpe...?;

  use Acme::Rumpelstiltskin;

=head1 DESCRIPTION

What is that moddule name?



=head1 SEE ALSO


=head1 AUTHOR

Makamaka HannyaharamituE<lt>makamaka[at]cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 Makamaka

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
