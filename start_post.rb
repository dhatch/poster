#!/usr/bin/ruby -w
##
# Name: start_post.rb
# Purpose: initiates a post for Happy Robot Labs
# Date: December 31, 2010
#
# Developer: Christopher Woodall <chris.j.woodall at gmail.com>
# Copyright: Apache License 2.0
##

require 'date'
require 'ftools'
require 'optparse'

program_name = 'start_post.rb'

# Parse the arguments
options = {}

optparse = OptionParser.new do |opts|
	opts.banner = "Usage: #{program_name} [options]"
	
	options[:verbose] = false
	opts.on( '-v', '--verbose', 'Output more information' ) do
		options[:verbose] = true
	end
	
	options[:post_name] = ''
	opts.on( '-p', '--post POST', 'Make post POST') do |post|
		options[:post_name] = post
	end
	
	opts.on( '-h', '--help', 'Display this screen' ) do
		puts opts
		exit
	end
end
optparse.parse!

author = 'Christopher Woodall'

date = DateTime.now

if options[:post_name] == ''
	puts 'Name of post? '
	post_name = gets.chomp
else
	post_name = options[:post_name]
end

# Make the directory for organization and format the file name
dir_path = './' + date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s
file_path = dir_path + '/' + post_name + '.md'

# Make the directory and then make the file and fill it with starter information
File.makedirs dir_path
File.open(file_path, 'w') do |file|
	title_string = 'Title: ' + post_name
	file.puts title_string
	title_string.length.times { file.print '=' }
	2.times { file.puts '' }
	file.puts '<content goes here>'
	file.puts ''
	file.puts '(c) Happy Robot Labs ' + date.year.to_s
end