requires 'Unicode::EastAsianWidth', '1.3';
requires 'perl', '5.008001';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.59';
    requires 'Test::More';
};
