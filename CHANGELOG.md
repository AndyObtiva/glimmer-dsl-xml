# Change Log

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
