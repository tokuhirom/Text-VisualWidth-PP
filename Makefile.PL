use inc::Module::Install;
name 'Text-VisualWidth-PP';
all_from 'lib/Text/VisualWidth/PP.pm';

# requires '';


readme_markdown_from 'lib/Text/VisualWidth/PP.pm';
tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
author_tests('xt');
# use_test_base;
auto_include;
WriteAll;
