require File.join(File.dirname(__FILE__), 'bloominsimple')
require 'digest/sha1'

class WhatLanguage
  VERSION = '1.0.7-mb'
  
  HASHERS = [ 
    lambda { |item| Digest::SHA1.digest(item.downcase.strip).unpack("VV") } ,
    lambda { |item| Digest::SHA2.digest(item.downcase.strip).unpack("xxxxVVVVVVV") }
  ]
  
  BITFIELD_WIDTH = 2_000_000
  
  @@data = {}
  
  def initialize(options = {})
    lang = hashType = nil
    if options == :large || (options.kind_of?(Hash) && options[:large])
      lang = "lang-lg"
    else
      lang = "lang"
    end
    languages_folder = File.join(File.dirname(__FILE__), "..", "lang")
    if options.is_a?(Hash) && options[:languages].is_a?(Enumerable)
      language_files = []
      options[:languages].each do |lang|
        file_name = "#{lang.to_s}.lang"
        language_files << file_name if File.exist?(File.join(languages_folder, file_name))
      end
    else
      language_files = Dir.entries(languages_folder).grep(/\.lang/)
    end
    language_files.each do |lang|
      @@data[lang[/\w+/].to_sym] ||= BloominSimple.from_dump(File.new(File.join(languages_folder, lang), 'rb').read, &HASHER)
    end
  end
  
  def reinit(options = {})
    @@data = {}
    initialize(options)
    return true
  end
  
  # Very inefficient method for now.. but still beats the non-Bloom alternatives.
  # Change to better bit comparison technique later..
  def process_text(text)
    results = Hash.new(0)
    it = 0
    text.split.collect {|a| a.downcase }.each do |word|
      it += 1
      @@data.keys.each do |lang|
        results[lang] += 1 if @@data[lang].includes?(word)
      end
      
      # Every now and then check to see if we have a really convincing result.. if so, exit early.
      if it % 4 == 0 && results.size > 1
        top_results = results.sort_by{|a,b| b}.reverse[0..1]
        
        # Next line may need some tweaking one day..
        break if top_results[0][1] > 4 && ((top_results[0][1] > top_results[1][1] * 2) || (top_results[0][1] - top_results[1][1] > 25))
      end
      
      #break if it > 100
    end
    results
  end
  
  def language(text)
    process_text(text).max { |a,b| a[1] <=> b[1] }.first rescue nil
  end
  
  def self.filter_from_dictionary(filename, outfilename, options = {})
    size = 0
    hasher = nil
    infile = File.open(filename)
    if options == :large || options[:large] 
      lines = 0
      infile.each {|word| lines += 1}
      size = 10*lines
      hasherId = 1
    else
      size = BITFIELD_WIDTH
      hasherId = 0
    end
    bf = BloominSimple.new(size, &HASHERS[hasherId])
    infile.rewind
    infile.each { |word| bf.add(word) }
    outfile = File.open(outfilename,"wb")
    outfile.write([hasherId].pack("I"))
    outfile.write(bf.dump)
    outfile.close
  end
  
end

class String
  def language
    WhatLanguage.new(:all).language(self)
  end
end