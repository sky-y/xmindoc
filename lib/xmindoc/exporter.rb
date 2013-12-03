#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'pp'
require 'open3'

module Xmindoc

  # Export a HTML to any filetypes with Pandoc
  # Original Source: pandoc-ruby
  # https://github.com/alphabetum/pandoc-ruby/blob/master/lib/pandoc-ruby.rb
  class Exporter
    attr_reader :result
    attr_accessor :html

    @@bin_path = nil

    EXECUTABLES = %W[
      pandoc
      markdown2pdf
      html2markdown
      hsmarkdown
    ]

    def self.bin_path=(path)
      @@bin_path = path
    end

    def initialize(option, html='')
      @html = html
      @option = option
      @result = ''
      @executable = 'pandoc'
      print @target
    end

    def export()
      @target = @html
      executable = @@bin_path ? File.join(@@bin_path, @executable) : @executable
      options = "--standalone --from #{@option[:format_from]} --to #{@option[:format_to]} #{@option[:pandoc_options]}"
      command = executable + " " + options
      puts command if DEBUG
      @result = execute(command)

      # @converter = PandocRuby.new(@html,
      #                             :standalone,
      #                             :from => @option[:format_from],
      #                             :to => @option[:format_to])
      # @result = @converter.convert

      return @result
    end


    def execute(command)
      output = ''
      Open3::popen3(command) do |stdin, stdout, stderr|
        stdin.puts @target
        stdin.close
        output = stdout.read.strip
      end
      output
    end

  end # class Exporter


end

# ## main
# if __FILE__ == $PROGRAM_NAME
#   option = { }
#   option[:format_from] = 'html' # fixed
#   option[:format_to] = 'markdown' # default

#   File.open("data/12.07.16_MOrgDown_idea/content.html") do |f|
#     exporter = XMorgDown::Exporter.new(option, f.read)
#     exporter.export()
#     puts exporter.result

#   end

# end
