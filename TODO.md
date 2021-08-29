# TODO

Here is a list of tasks to do (moved to CHANGELOG.md once done).

## Next

- Fix issue with declaring two sibling divs with unopen empty content (no `{}`) ending up with the latter one nested under the former one

## Tasks

- Support `p` keyword without exceptional custom tag by temporarily removing the `p` implementation from Glimmer when under a top-level keyword
- Consider supporting building a string right away (without need for to_s or to_html)
- Build a tool called glimmerize that takes HTML and transforms it to Glimmer XML syntax
- handle/encode special characters such as #, {, }, and .
- CDATA support
