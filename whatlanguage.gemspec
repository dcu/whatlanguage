Gem::Specification.new do |s|
  s.name     = "kenwaln-whatlanguage"
  s.version  = "1.0.6"
  s.date     = "2009-11-02"
  s.summary  = "Natural language detection for text samples"
  s.email    = "kenwaln@pacbell.net"
  s.homepage = "http://github.com/kenwaln/whatlanguage"
  s.description = "WhatLanguage rapidly detects the language of a sample of text"
  s.has_rdoc = true
  s.authors  = ["Peter Cooper", "Ken Waln", "Artiom Lunev", "Matthias Bauer"]
  s.files    = [
"build_filter.rb",
"build_lang_from_wordlists.rb",
"example.rb",
"History.txt",
"lang/dutch.lang",
"lang/english.lang",
"lang/farsi.lang",
"lang/french.lang",
"lang/german.lang",
"lang/pinyin.lang",
"lang/portuguese.lang",
"lang/russian.lang",
"lang/spanish.lang",
"lang/hebrew.lang",
"lang/swedish.lang",
"lang-lg/dutch.lang",
"lang-lg/english.lang",
"lang-lg/farsi.lang",
"lang-lg/french.lang",
"lang-lg/german.lang",
"lang-lg/pinyin.lang",
"lang-lg/portuguese.lang",
"lang-lg/russian.lang",
"lang-lg/spanish.lang",
"lang-lg/swedish.lang",
"lib/bitfield.rb",
"lib/bloominsimple.rb",
"lib/whatlanguage.rb",
"Manifest.txt",
"Rakefile",
"README",
"README.txt",
"test/test_whatlanguage.rb",
"test/test_whatlanguage_lg.rb",
"whatlanguage.gemspec"]

  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
end
