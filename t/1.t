use strict;
use Test::More;
use lib qw(./src);
use Acme::Rumpelstiltskin::Song;

BEGIN {

my $obj = Acme::Rumpelstiltskin::Song->new( [
    [qw/Rumpelstil/],
    [qw/tskin skin/],
], { exclude => 'Rumpelstiltskin' } );

$obj->start(sub {
    my ($self, $name) = @_;
    use_ok("Acme::$name");
});


eval q/ require Acme::Rumpelstiltskin /;

ok( $@ );

}

done_testing;
