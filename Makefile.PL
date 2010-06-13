use inc::Module::Install;
use 5.008001;

name 'Text-VisualWidth-PP';
all_from 'lib/Text/VisualWidth/PP.pm';

requires 'Unicode::EastAsianWidth' => 1.30;

readme_markdown_from 'lib/Text/VisualWidth/PP.pm';
tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
author_tests('xt');
auto_include;
WriteAll;
