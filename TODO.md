# TODO

Here is a list of tasks to do (moved to CHANGELOG.md once done).

## Next

- Support script-local glimmer config option to auto convert xml attribute underscores to dashes (e.g. `html(attribute_underscore: '-') { div(data_bind: 'name') {"Sean"} }` ) (similar to global glimmer config option `Glimmer::Config.xml_attribute_underscore = '-'`, but applies locally only )
- Fix issue with declaring two sibling divs with unopen empty content (no `{}`) ending up with the latter one nested under the former one

## Future

- Support Rails with Glimmer DSL for XML as a server-side templating language alternative to ERB (e.g. file extension .glmr or .html.rb). This is in response to: https://github.com/AndyObtiva/glimmer/issues/11
- Support `p` keyword without exceptional custom tag by temporarily removing the `p` implementation from Glimmer when under a top-level keyword
- Consider supporting building a string right away (without need for to_s or to_html)
- Build a tool called glimmerize that takes HTML and transforms it to Glimmer XML syntax
- handle/encode special characters such as #, {, }, and .
- CDATA support

## Maybe

