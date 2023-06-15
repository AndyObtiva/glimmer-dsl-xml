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

require 'glimmer/dsl/static_expression'
require 'glimmer/dsl/top_level_expression'
require 'glimmer/dsl/parent_expression'
require 'glimmer/xml/node'
require 'glimmer/xml/depth_first_search_iterator'
require 'glimmer/xml/name_space_visitor'

module Glimmer
  module DSL
    module XML
      class NameSpaceExpression < StaticExpression
        include TopLevelExpression
        include ParentExpression

        def can_interpret?(parent, keyword, *args, &block)
          (parent == nil or parent.is_a?(Glimmer::XML::Node)) and
          (keyword.to_s == "name_space")
          (args.size == 1) and
          (args[0].is_a?(Symbol)) and
          block
        end

        def interpret(parent, keyword, *args, &block)
          # act like a top-level xml tag
          Glimmer::XML::Node.new(parent, args[0].to_s, :_name_space_context => true)
        end
        
        def add_content(parent, keyword, *args, &block)
          node = block.call(parent)
          unless node.is_a?(String)
            name_space_visitor = Glimmer::XML::NameSpaceVisitor.new(parent.name)
            Glimmer::XML::DepthFirstSearchIterator.new(node, name_space_visitor).iterate
#             def node.process_block(block)
#               Glimmer::Config.logger&.debug 'block'
#             end
          end
          parent.children << node if parent and !parent.children.include?(node)
          node
        end
              
      end
    end
  end
end
