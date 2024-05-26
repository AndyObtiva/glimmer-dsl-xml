# Change Log

## 1.4.0

- `html_to_glimmer` converter command for automatically converting HTML to Glimmer DSL Ruby code
- Support `p` keyword directly (without having to use the custom `tag` keyword like `tag(:_name => "p")`)

## 1.3.2

- Relaxed glimmer dependency to between 2.4.1 and 3.0.0
- Fix issue with `Glimmer::Config.xml_attribute_underscore` not available due to a conflict with other Glimmer gems having `ext` directory, by renaming this gem's `ext` directory to `glimmer-dsl-xml-ext`

## 1.3.1

- Support `Glimmer::Config.xml_attribute_underscore = '-'` to auto convert xml attribute underscores to dashes (or any character) only in symbols, but not strings

## 1.3.0

- Upgrade to Glimmer 2.4.1 (automatically gets rid of `invalid log level:` output without needing v1.2.1's fix)

## 1.2.1

- Get rid of `invalid log level:` output by setting `GLIMMER_LOGGER_LEVEL` env var before requiring `glimmer`

## 1.2.0

- Upgraded to Glimmer 2

## 1.1.0

- Support `xml` keyword to produce partial xml/html without the html tag in output
- Update `html` keyword to add a doctype (`<!DOCTYPE html>`) at the top of rendered content
- Make `html` keyword automatically not include a doctype or html tag if content does not have HEAD or BODY
- Make name_space act like an alternative to `xml` keyword, not requiring `xml` or `html` underneath
- Upgraded to glimmer 1.0.1

## 1.0.0

- Upgraded to Glimmer 1.0.0

## 0.2.0

- Relaxed dependency on glimmer

## 0.1.0

- Extracted Glimmer DSL for SWT (glimmer-dsl-swt gem) from Glimmer
