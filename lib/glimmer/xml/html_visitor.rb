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

require 'glimmer/xml/xml_visitor'

module Glimmer
  module XML
    class HtmlVisitor < XmlVisitor
    
      def render_html_tag?(node)
        if node.name == 'html'
          node_children = node.children.select {|node_or_text| node_or_text.is_a?(Glimmer::XML::Node)}
          if !node_children.empty?
            children_names = node_children.map(&:name)
            return false unless children_names.include?('head') || children_names.include?('body')
          end
        end
        true
      end

      def begin_open_tag(node)
        return unless render_html_tag?(node)
        @document += "<!DOCTYPE html>" if node.name == 'html'
        super(node)
      end
      
      def end_open_tag(node)
        return unless render_html_tag?(node)
        super(node)
      end
      
      def append_close_tag(node)
        return unless render_html_tag?(node)
        super(node)
      end
      
      def append_attributes(node)
        return unless render_html_tag?(node)
        super(node)
      end
    end
  end
end
