use strict;
use Test::More;
use lib qw(./src);
use Acme::Rumpelstiltskin::Song;

BEGIN {

my $obj = Acme::Rumpelstiltskin::Song->new( [
    [qw/R L/],
    [qw/u a/],
    [qw/m n/],
    [qw/pe/],
    [qw/l lu ru/],
    [qw/ste sti/],
    [qw/l lu ru/],
    [qw/s ts st/],
    [qw/kin/],
], { exclude => 'Rumpelstiltskin' } );

$obj->start(sub {
    my ($self, $name) = @_;
    use_ok("Acme::$name");
});


eval q/ require Acme::Rumpelstiltskin /;

ok( $@ );

}

done_testing;
