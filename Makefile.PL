use 5.006;
use ExtUtils::MakeMaker;

use lib qw(./src);
use Acme::Rumpelstiltskin::Song;


open(FILE, "src/Acme/Rumpelstiltskin.pm") or die $!;
my $ORG_CONTENT = join('', <FILE>);
close(FILE);

=pod

    [qw/R L/],
    [qw/u a/],
    [qw/m n/],
    [qw/pe/],
    [qw/l lu ru/],
    [qw/ste sti/],
    [qw/l lu ru/],
    [qw/s ts st/],
    [qw/kin/],

=cut

my $obj = Acme::Rumpelstiltskin::Song->new( [
    [qw/Rumpelstil/],
    [qw/tskin skin/],
] );

$obj->start(\&make_file);


WriteMakefile(
    NAME              => 'Acme::Rumpelstiltskin',
    VERSION_FROM      => 'src/Acme/Rumpelstiltskin.pm', # finds $VERSION
    PREREQ_PM         => {
        'Test::More'  => '0.96',
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'src/Acme/Rumpelstiltskin.pm', # retrieve abstract from module
       AUTHOR         => 'Makamaka <makamaka[at]cpan.org>') : ()),
    clean             => { FILES => 'lib/Acme/*' },
);



sub make_file {
    my ($self, $name) = @_;
    my $content = $ORG_CONTENT;

    $content =~ s/package Acme::Rumpelstiltskin;/package Acme::$name;/;
    $name .= '.pm';

    mkdir 'lib'      unless -d 'lib';
    mkdir 'lib/Acme' unless -d 'lib/Acme';

    open(FILE, ">lib/Acme/$name") or die "$! $name";
    print FILE $content;
    close(FILE);
}

