#! /c/ruby/bin/ruby
# Builds all of the word lists in ./wordlists/ into filter files in ./lang/

require 'lib/whatlanguage'

puts ARGV[0]
if ARGV[0] && ARGV[0].downcase == "large"
  options = { :large => true }
  langDir = "lang-lg"
else
  options = {}
  langDir = "lang"
end

languages_folder = File.join(File.dirname(__FILE__), langDir)
wordlists_folder = File.join(File.dirname(__FILE__), "wordlists")

Dir.entries(wordlists_folder).grep(/\w/).each do |lang|
  next if lang == 'generators'
  puts "Doing #{lang} with options #{options.inspect} "
  filter = WhatLanguage.filter_from_dictionary(File.join(wordlists_folder, lang), File.join(languages_folder, lang + ".lang"),options)
end
