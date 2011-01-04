#!/usr/bin/ruby -w
##
# Name: poster.rb
# Purpose: Manages blog posts for a tumblr blog
# Date: December 31, 2010
#
# Developer: Christopher Woodall <chris.j.woodall at gmail.com>
# Copyright: Apache License 2.0
##

# Gems and Libraries
require 'rubygems'
require 'date'
require 'ftools' 
require 'optparse'
require 'maruku' # For markdown parsing

# Poster Libraries
require 'poster_lib'

program_name = 'poster.rb'

# Parse the arguments
options = {}
optparse = OptionParser.new do |opts|
	opts.banner = "Usage: #{program_name} [options]"
	
	options[:create] = false
	opts.on( '-c', '--create', 'Flag to create a markdown post' ) do
		options[:create] = true
	end
	
	options[:format] = false
	opts.on( '-f', '--format FORMAT_TYPE', 'Creates a formatted file (Options: html or latex)') do |format|
		options[:format] = format
	end
	
	options[:post] = false
	opts.on( '-p', '--post POST_NAME', 'Sets the post name') do |post|
		options[:post] = post
	end
	
	options[:author] = 'Christopher Woodall'
	opts.on( '-a', '--author AUTHOR_NAME', 'Sets the author name (Default: Christopher Woodall)') do |author_name|
		options[:author] = author_name
	end
	
	opts.on( '-h', '--help', 'Display this screen' ) do
		puts opts
		exit
	end
end
optparse.parse!

date = DateTime.now

if options[:post]
	post_name = options[:post]
else
	puts 'Name of post? '
	post_name = gets.chomp
end

# Make the directory for organization and format the file name
dir_path = './' + date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s
file_path = dir_path + '/' + post_name
	
File.makedirs dir_path
if options[:create]
	# Make the directory and then make the file and fill it with starter information
	File.open(file_path + '.md', 'w') do |file|
		file.puts "# #{post_name}"
		file.puts 
		file.puts "Author: #{options[:author]}"
		file.puts
		file.puts '(content goes here)'
		file.puts 
		file.puts "(c) Happy Robot Labs #{date.year.to_s}"
	end
elsif options[:format]
	File.open(file_path + '.md', 'r') do |file|
		File.open(file_path + '.' + options[:format].downcase, 'w') do |wfile|
			# Read all of the blog post into md_string then close the blog post
			md_string = read_file file
			file.close

			# Format and write the blog post into HTML or a PDF
			case options[:format].downcase
			when 'html'
				wfile.puts Maruku.new(md_string).to_html
			when 'latex'
				wfile.puts Maruku.new(md_string).to_latex
			end
		end
	end
end