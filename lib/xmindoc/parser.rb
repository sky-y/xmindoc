#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Add current path to load path
# https://github.com/komagata/lokka/blob/master/init.rb
$:.unshift File.dirname(__FILE__)

require 'pp'
require 'zipruby'
require 'nokogiri'

SRC_DIR = File.dirname(__FILE__)

module Xmindoc

  class Parser
    attr_accessor :file_xmind
    attr_reader :xml_content, :html_output
    CONTENT_XML_FILE = "content.xml"
    XSLT_FILE = "#{SRC_DIR}/content.xsl"

    def initialize(file_xmind)
      Dir::chdir(".")
      @file_xmind = file_xmind
      @xslt = File.read(XSLT_FILE)
      @nokogiri_xslt = Nokogiri::XSLT(@xslt)
      @xml_content = ''
      @html_output = ''
    end

    ## Parse a XMind XML and convert it to html
    def parse()
      ## Read XMind file as a zip file
      Zip::Archive.open(@file_xmind) do |ar|
        ar.fopen(CONTENT_XML_FILE) do |f|
          @xml_content = f.read
        end
      end

      ## Parse XMind XML with Nokogiri and XSLT
      nokogiri_xml = Nokogiri::XML(@xml_content)
      @html_output = @nokogiri_xslt.apply_to(nokogiri_xml).to_s
    end



  end

end


# ## main
# if __FILE__ == $PROGRAM_NAME
#   ## for test
#   file_xmind = "/Users/yuki/Dropbox/Projects/app_dev/MOrgDown/data/12.07.16_MOrgDown_idea.xmind"
#   parser = XMorgDown::Parser.new(file_xmind)
#   parser.parse()
#
#
# end
