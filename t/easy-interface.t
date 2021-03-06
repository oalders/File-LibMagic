use strict;
use warnings;

use lib 't/lib';

use Test::AnyOf;
use Test::More 0.88;

use File::LibMagic qw( :easy );

is( MagicBuffer("Hello World\n"),   'ASCII text' );
is( MagicFile('t/samples/foo.txt'), 'ASCII text' );
is_any_of(
    MagicFile('t/samples/foo.c'),
    [ 'ASCII C program text', 'C source, ASCII text' ]
);

# check the error handling
eval { MagicBuffer(undef) };
like( $@, qr{MagicBuffer requires defined content}, 'MagicBuffer(undef)' );

eval { MagicFile(undef) };
like( $@, qr{MagicFile requires a filename}, 'MagicFile(undef)' );

TODO: {
    local $TODO = 'check libmagic version';
    eval { MagicFile('t/samples/missing') };
    like( $@, qr{libmagic cannot open .+ at .+}, 'MagicFile: missing file' );
}

done_testing();
