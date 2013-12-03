# -*- coding: utf-8 -*-
require "xmindoc/version"

require "optparse"
require 'pp'

# my libraries
require "xmindoc/exporter"
require "xmindoc/parser"


module Xmindoc
  DEBUG = false

  class Core
    attr_reader :result

    def initialize(option)
      @option = option
      @parser = Parser.new(option[:file_input])
      @exporter = Exporter.new(option)
      @result = ""
    end

    # Parse and transform: XML -> HTML
    def xml_to_html()
      @parser.parse()
      @exporter.html = @parser.html_output
      return @exporter.html
    end

    # Export with Pandoc: HTML -> Markdown, Org, ...
    def html_to_pandoc()
      @exporter.export()
      @result = @exporter.result
      return @result
    end

    # Convert and process XML with Pandoc at once
    def convert()
      xml_to_html()
      html_to_pandoc()


      if @option[:file_output] == ""
        # Without -o option
        puts @result
      else
        # Using option: -o filename
        File.open(@option[:file_output],"w") do |f|
          f.write(@result)
        end
      end

      return @result
    end
  end

  class Command
    attr_reader :option, :argv

    def initialize(argv)
      @argv = argv
      @option = { }
      @option[:format_from] = 'html' # fixed
      @option[:format_to] = 'markdown' # default
      @option[:file_input] = '' # XMind file (.xmind)
      @option[:file_output] = '' # [option]
    end

    # Parse command line options
    def parse()
      # Option Parser of optparse
      opt = OptionParser.new
      script_name = File.basename($0)
      opt.banner = "Usage: ruby #{script_name} [options] input.xmind"

      #
      # Option Settings
      #

      # Output
      opt.on('-o FILE','--output FILE','Output Filename') {|v| @option[:file_output] = v }

      # Format(Output)
      output_formats_short = %w(markdown org html latex rst plain)
      output_formats_long = %w(native json html html5 html+lhs html5+lhs s5 slidy slideous dzslides docbook opendocument latex latex+lhs beamer beamer+lhs context texinfo man markdown markdown+lhs plain rst rst+lhs mediawiki textile rtf org asciidoc odt docx epub)
      str_output_formats = "Output formats: " + output_formats_short.join(', ') + ", ... \n\t\t\t\t\t(for other formats: see \"pandoc --help\")"

      opt.on('-t FORMAT','--to=FORMAT',str_output_formats) {|v| @option[:format_to] = v }
      opt.on('-w FORMAT','--write=FORMAT',str_output_formats) {|v| @option[:format_to] = v }

      # Other options for Pandoc
      str_pandoc_options = "Pandoc options (Use double quotes like \"--atx-headers\")\n\t\t\t\t\t(for other options: see \"pandoc --help\")"
      opt.on('--pandoc-options=OPTIONS',str_pandoc_options) {|v| @option[:pandoc_options] = v }

      # Help
      opt.on( '-h', '--help', 'Display this screen' ) do
        puts opt
        exit
      end


      # Do parsing
      begin
        pp @argv if DEBUG
        opt.permute!(@argv)
      rescue => e
        # Catch exception when an option is wrong
        puts opt
        abort(e)
      end

      ## Check whether ARGV is null
      if @argv.length == 0
        # Show help
        puts opt
        exit
      end

      print "argv: " if DEBUG
      pp @argv if DEBUG

      @option[:file_input] = @argv.pop

      ## Check whether the filename ends with ".xmind"
      if not (@option[:file_input] =~ /^.*\.xmind$/)
        puts opt
        abort("ERROR: filename should end with \".xmind\"")
      end

      # Check format
      if not output_formats_long.include?(@option[:format_to])
        puts opt
        abort("ERROR: wrong output format: "+ @option[:format_to])
      end

    end # def parse()
  end

  class Exec
    def initialize(argv)
      @argv = argv
    end

    def self.run(argv)
      new(argv).execute
    end

    def execute
      command = Xmindoc::Command.new(@argv)
      command.parse()

      core = Xmindoc::Core.new(command.option)
      core.convert()

      # (debug) Confirm options
      if Xmindoc::DEBUG
        print 'option: '
        pp command.option
      end
    end
  end
end
