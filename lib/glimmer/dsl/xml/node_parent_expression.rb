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

require 'glimmer'
require 'glimmer/dsl/parent_expression'
require 'glimmer/xml/node'

module Glimmer
  module DSL
    module XML
      module NodeParentExpression
        include ParentExpression
        include Glimmer

        def add_content(parent, &block)
          return_value = block.call(parent)      
          if !return_value.is_a?(Glimmer::XML::Node) and !parent.children.include?(return_value)
            text = return_value.to_s
            first_match = text.match(/[#][^{]+[{][^}]+[}]/)
            match = first_match
            while (match)
              instance_eval(parent.text_command(match.pre_match))
              tag_text = match.to_s
              instance_eval(parent.rubyize(tag_text))
              text = tag_text
              post_match = match.post_match
              match = text.match(/[#]\w+[{]\w+[}]/)
            end
            instance_eval(parent.text_command(post_match)) if post_match
            parent.children << return_value unless first_match
          end
        end
      end
    end
  end
end
