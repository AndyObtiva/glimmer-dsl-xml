# Copyright (c) 2020-2024 - Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

begin
  require 'nokogiri'
rescue LoadError
  puts 'Please install the `nokogiri` gem by running: gem install nokogiri'
  raise 'The `nokogiri` gem is not installed!'
end

module Glimmer
  module XML
    class HTMLToGlimmerConverter
      def convert(html)
        glimmer = ''
        glimmer += "require 'glimmer-dsl-xml'\n\n"
        glimmer += "include Glimmer\n\n"
        glimmer += "html_document = xml {\n"
        glimmer += indent_lines(convert_html(html))
        glimmer += "}\n\n"
        glimmer += "puts html_document.to_s\n"
      end
      
      private
      
      def convert_html(html)
        html_doc = Nokogiri::HTML(html)
        glimmer = ''
        html_doc.children.select(&:element?).each do |element|
          glimmer += convert_element(element)
        end
        glimmer
      end
      
      def convert_element(element)
        children_count = element.children.size
        glimmer = ''
        glimmer += "#{element.node_name}#{convert_attributes(element)}" if element.element?
        glimmer += " {\n" if element.element? && children_count > 0
        if element.children.size == 1 && element.children.first.text?
          glimmer += indent_lines(convert_text(element.children.first))
        else
          element.children.each do |child|
            if child.element?
              glimmer += indent_lines(convert_element(child))
            elsif child.text?
              glimmer += indent_lines(convert_span(child))
            end
          end
        end
        glimmer += "}\n" if element.element? && children_count > 0
        glimmer += "\n" if element.element? && children_count == 0
        glimmer
      end
      
      def convert_span(text_element)
        text_content = indent_lines(convert_text(text_element))
        return '' if text_content.strip.empty?
        glimmer = ''
        glimmer += "span {\n"
        glimmer += text_content
        glimmer += "}\n"
        glimmer
      end
      
      def convert_text(text_element)
        text_content = text_element.to_s
        if text_content.strip.empty?
          ''
        else
          "#{text_element.to_s.dump}\n"
        end
      end
      
      def convert_attributes(element)
        attributes_string = element.attributes.to_a.map do |attribute, value|
          "#{normalize_attribute(attribute)}: #{normalize_value(value)}"
        end.join(', ')
        return '' if attributes_string.strip.empty?
        glimmer = ''
        glimmer += '('
        glimmer += attributes_string
        glimmer += ')'
        glimmer
      end
      
      def normalize_attribute(attribute)
        if attribute.include?('-')
          "'#{attribute}'"
        else
          attribute
        end
      end
      
      def normalize_value(value)
        value = value.to_s
        if value.include?("'")
          "\"#{value}\""
        else
          "'#{value}'"
        end
      end
      
      def indent_lines(multi_line_string)
        multi_line_string.lines.map { |line| "  #{line}" }.join
      end
    end
  end
end
