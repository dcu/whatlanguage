# Use this to build new filters (for other languages, ideally) from /usr/share/dict/words style dictionaries..
#
# Call like so..
#   ruby build_filter.rb /usr/share/dict/words lang/english.lang
# (replace params as necessary)

require 'lib/whatlanguage'
unless ARGV.length >= 2
    puts <<-endUsage
usage:
  ruby build_filter.rb <word list> <language file> [large]
  The "large" is optional and causes larger, more accurate dictionaries
  to be used
endUsage
  exit
end
options = {}
options[:large] = true if ARGV[2] and ARGV[2].downcase == 'large'
WhatLanguage.filter_from_dictionary(ARGV[0],ARGV[1],options)
