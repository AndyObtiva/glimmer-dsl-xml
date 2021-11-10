# Copyright (c) 2020 - Andy Maleh
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

require "glimmer/xml/node_visitor"
require "glimmer/xml/node"

module Glimmer
  module XML
    class XmlVisitor < NodeVisitor

      attr_reader :document

      def initialize
        @document = ""
      end

      def process_before_children(node)
        if (!node.is_a?(Glimmer::XML::Node))
          @document += node.to_s
          return
        end
        begin_open_tag(node)
        append_attributes(node) if node.attributes
        end_open_tag(node)
      end

      def process_after_children(node)
        return if (!node.is_a?(Glimmer::XML::Node))
        append_close_tag(node)
      end

      def begin_open_tag(node)
        return if node.name == 'xml' || node.name_space_context?
        @document += "<"
        @document += "#{node.name_space.name}:" if node.name_space
        @document += node.name
      end

      def end_open_tag(node)
        return if node.name == 'xml' || node.name_space_context?
        if (node.contents)
          @document += ">"
        else
          @document += " " if node.attributes.keys.size > 0
          @document += " />"
        end
      end

      def append_close_tag(node)
        return if node.name == 'xml' || node.name_space_context?
        if (node.contents)
          @document += "</"
          @document += "#{node.name_space.name}:" if node.name_space
          @document += "#{node.name}>"
        end
      end

      def append_attributes(node)
        return if node.name == 'xml' || node.name_space_context?
#         Glimmer::Config.logger&.debug "Append Attributes"
#         Glimmer::Config.logger&.debug(node.attributes)
        node.attributes.each do |attribute, value|
          attribute_name = attribute
          attribute_name = "#{attribute.name_space.name}:#{attribute.name}" if attribute.is_a?(Node)
          attribute_name = attribute_name.to_s.gsub('_', Glimmer::Config.xml_attribute_underscore) if attribute_name.is_a?(Symbol)
          @document += " #{attribute_name}"
          @document += "=\"#{value}\"" unless value.nil?
        end
      end

    end
  end
end
