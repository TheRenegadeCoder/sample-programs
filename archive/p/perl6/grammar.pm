# This is taken from the Raku homepage as an exemplar
# to Raku's Grammar parsing.

use v6;

grammar Parser
{
    rule TOP    { I <love> <lang> }
    token love  { '<3' | love }
    token lang  { < Raku Perl Rust Go Python Ruby > }
}

say Parser.parse: 'I <3 Raku';
say Parser.parse: 'I love Perl';