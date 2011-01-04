#!/usr/bin/ruby -w
##
# Name: start_post.rb
# Purpose: initiates a post for Happy Robot Labs
# Date: December 29, 2010
#
# Developer: Christopher Woodall <chris.j.woodall at gmail.com>
# Copyright: Apache License 2.0
##
require 'rubygems'
require 'date'
require 'ftools'
require 'maruku'

author = 'Christopher Woodall'
# Get the date
date = DateTime.now
# Get the name of the post
puts 'Name of post? '
post_name = gets.chomp
# Make the directory for organization and format the file name
dir_path = './' + date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s
file_path = dir_path + '/' + post_name

# Make the directory and then make the file and fill it with starter information
File.makedirs dir_path
File.open(file_path + '.md', 'r') do |file|
	File.open(file_path + '.html', 'w') do |wfile|
		md_string = ''
		while (line = file.gets)
			md_string += line
		end
		wfile.puts Maruku.new(md_string).to_html
	end
