# Copyright (c) 2020-2023 - Andy Maleh
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

require 'glimmer/xml/depth_first_search_iterator'
require 'glimmer/xml/xml_visitor'

module Glimmer
  module XML
    class Node
      include Glimmer

      # TODO change is_name_space to name_space?
      
      attr_accessor :children, :name, :contents, :attributes, :is_name_space, :is_attribute, :name_space, :parent
      
      def initialize(parent, name, attributes, &contents)
        @is_name_space = false
        @children = []
        @parent = parent
        if attributes.is_a?(Array)
          attributes = attributes.compact
          hash_attributes = attributes.last.is_a?(Hash) ? attributes.delete(attributes.last) : {}
          hash_attributes = attributes.reduce(hash_attributes) do |hash, attribute|
            hash.merge(attribute => nil)
          end
          attributes = hash_attributes
        end
        if (parent and parent.is_name_space)
          @name_space = parent
          @parent = @name_space.parent
        end
        @parent.children << self if @parent
        @name = name
        @contents = contents
        @attributes = attributes
        if @attributes
          @attributes.each_key do |attribute|
            if attribute.is_a?(Node)
              attribute.is_attribute = true
              attribute.parent.children.delete(attribute) if attribute.parent
              attribute.parent = nil #attributes do not usually have parents
            end
          end
#           Glimmer::Config.logger&.debug(attributes)
        end
      end

      def method_missing(symbol, *args, &block)
        @is_name_space = true
        parent.children.delete(self) if parent
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::XML::XmlExpression.new, name, attributes) {@tag = super}
        @tag
      end
      
      def name_space_context?
        attributes[:_name_space_context]
      end

      def to_xml
        xml_visitor = XmlVisitor.new
        DepthFirstSearchIterator.new(self, xml_visitor).iterate
        xml_visitor.document
      end
      alias to_s to_xml

      def text_command(text)
        "text \"#{text}\""
      end

      def rubyize(text)
        text = text.gsub(/[}]/, '"}')
        text = text.gsub(/[{]/, '{"')
        text = text.gsub(/[#]/, '')
      end

      #override Object default id method and route it to Glimmer engine
      def id
        method_missing(:id)
      end
    end
  end
end
