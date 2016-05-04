require 'rubygems'
require 'irb/ext/save-history'
require 'irb/completion'
IRB.conf[:SAVE_HISTORY] = 100000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

