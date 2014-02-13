# base file for global requirements
require 'rubygems' 
require 'bundler/setup'
Dir["#{File.expand_path(File.dirname(__FILE__))}/util/*.rb"].each {|file| require file }