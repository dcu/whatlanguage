
require File.join(File.dirname(__FILE__), "..", "lib", "whatlanguage")
require "WEBrick"

trials = 10000
@wl = WhatLanguage.new(:large)
falsies = {}
trials.times {
  wd = WEBrick::Utils.random_string(10)
  result = @wl.process_text(wd)
  next if !result
  result.each_pair {|lang,cnt|
    falsies[lang] ||= 0
    falsies[lang] += cnt
  }
}
falsies.each_pair {|lang,cnt|
  puts lang.to_s + " : " + (cnt*100.0/trials).to_s + "% false positives"
}
  
  
