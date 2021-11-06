# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for XML 1.2.0 (& HTML)
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-xml.svg)](http://badge.fury.io/rb/glimmer-dsl-xml)
[![Travis CI](https://travis-ci.com/AndyObtiva/glimmer-dsl-xml.svg?branch=master)](https://travis-ci.com/github/AndyObtiva/glimmer-dsl-xml)
[![Coverage Status](https://coveralls.io/repos/github/AndyObtiva/glimmer-dsl-xml/badge.svg?branch=master)](https://coveralls.io/github/AndyObtiva/glimmer-dsl-xml?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/65f487b8807f7126b803/maintainability)](https://codeclimate.com/github/AndyObtiva/glimmer-dsl-xml/maintainability)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for XML provides Ruby syntax for building XML (eXtensible Markup Language) and HTML documents.

Within the context of desktop development, Glimmer DSL for XML is useful in providing XML data for the [SWT Browser widget](https://github.com/AndyObtiva/glimmer-dsl-swt/tree/master#browser-widget).

Other [Glimmer](https://github.com/AndyObtiva/glimmer) DSL gems:
- [glimmer-dsl-swt](https://github.com/AndyObtiva/glimmer-dsl-swt): Glimmer DSL for SWT (JRuby Desktop Development GUI Library)
- [glimmer-dsl-tk](https://github.com/AndyObtiva/glimmer-dsl-tk): Glimmer DSL for Tk (Ruby Desktop Development GUI Library)
- [glimmer-dsl-libui](https://github.com/AndyObtiva/glimmer-dsl-libui): Glimmer DSL for LibUI (Prerequisite-Free Ruby Desktop Development GUI Library)
- [glimmer-dsl-gtk](https://github.com/AndyObtiva/glimmer-dsl-gtk): Ruby-GNOME Desktop Development GUI Library
- [glimmer-dsl-opal](https://github.com/AndyObtiva/glimmer-dsl-opal): Glimmer DSL for Opal (Web GUI Adapter for Desktop Apps)
- [glimmer-dsl-css](https://github.com/AndyObtiva/glimmer-dsl-css): Glimmer DSL for CSS (Cascading Style Sheets)

## Setup

Please follow these instructions to make the `glimmer` command available on your system.

### Option 1: Direct Install

Run this command to install directly:
```
gem install glimmer-dsl-xml -v 1.2.0
```

Note: When using JRuby, `jgem` is JRuby's version of `gem` command. RVM allows running `gem` as an alias in JRuby. Otherwise, you may also run `jruby -S gem install ...`

Add `require 'glimmer-dsl-xml'` to your code.

When using with [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) or [Glimmer DSL for Opal](https://github.com/AndyObtiva/glimmer-dsl-opal), make sure it is added after `require glimmer-dsl-swt` and `require glimmer-dsl-opal` to give it a lower precedence than them when processed by the Glimmer DSL engine.

That's it! Requiring the gem activates the Glimmer XML DSL automatically.

### Option 2: Bundler

Add the following to `Gemfile` (after `glimmer-dsl-swt` and/or `glimmer-dsl-opal` if included too):
```
gem 'glimmer-dsl-xml', '~> 1.2.0'
```

And, then run:
```
bundle install
```

Note: When using JRuby, prefix with `jruby -S`

Require in your code via Bundler (e.g. `require 'bundler'; Bundler.require`) or add `require 'glimmer-dsl-xml'` to your code.

When using with [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) or [Glimmer DSL for Opal](https://github.com/AndyObtiva/glimmer-dsl-opal), make sure it is loaded after `glimmer-dsl-swt` and `glimmer-dsl-opal` to give it a lower precedence than them when processed by the Glimmer DSL engine.

That's it! Requiring the gem activates the Glimmer XML DSL automatically.

## XML DSL

Simply start with the `html`, `xml`, `name_space`, or `tag` keyword and add XML/HTML inside its block using Glimmer DSL for XML syntax.
Once done, you may call `to_s`, `to_xml`, or `to_html` to get the formatted XML/HTML output.

Here are all the Glimmer XML DSL top-level keywords:
- `html`: renders partial HTML just like `xml` (not having body/head) or full HTML document (having body/head), automatically including doctype (`<!DOCTYPE html>`) and surrounding content by the `<html></html>` tag
- `xml`: renders XML/XHTML content (e.g. `xml {span {'Hello'}; br}.to_s` renders `<span>Hello</span><br />`)
- `name_space`: enables namespacing html tags
- `tag`: enables custom tag creation for exceptional cases (e.g. `p` as reserved Ruby keyword) by passing tag name as '_name' attribute

Element properties are typically passed as a key/value hash (e.g. `section(id: 'main', class: 'accordion')`) . However, for properties like "selected" or "checked", you must leave value `nil` or otherwise pass in front of the hash (e.g. `input(:checked, type: 'checkbox')` )

You may try the following examples in IRB after installing the [glimmer-dsl-xml](https://rubygems.org/gems/glimmer-dsl-xml) gem.

Just make sure to require the library and include Glimmer first:

```ruby
require 'glimmer-dsl-xml'

include Glimmer
```

Example (full HTML document):

```ruby
@html = html {
  head {
    meta(name: "viewport", content: "width=device-width, initial-scale=2.0")
  }
  body {
    h1 { "Hello, World!" }
  }
}

puts @html
```

Output:

```
<!DOCTYPE html><html><head><meta name="viewport" content="width=device-width, initial-scale=2.0" /></head><body><h1>Hello, World!</h1></body></html>
```

Example (partial HTML fragment):

```ruby
@html = html {
  h1 { "Hello, World!" }
}

puts @html
```

Output:

```
<h1>Hello, World!</h1>
```

Example (basic XML):

```ruby
@xml = xml {
  greeting { "Hello, World!" }
}

puts @xml
```

Output:

```
<greeting>Hello, World!</greeting>
```

Example (XML namespaces using `name_space` keyword):

```ruby
@xml = name_space(:acme) {
  product(:id => "thesis", :class => "document") {
    component(:id => "main") {
    }
  }
}

puts @xml
```

Output:

```
<acme:product id="thesis" class="document"><acme:component id="main"></acme:component></acme:product>
```

Example (XML namespaces using dot operator):

```ruby
  @xml = xml {
    document.body(document.id => "main") {
    }
  }
  
  puts @xml
```

Output:

```
<document:body document:id="main"></document:body>
```

Example (custom tag):

```ruby
puts tag(:_name => "p") {"p is a reserved keyword in Ruby"}
```

Output:

```
<p>p is a reserved keyword in Ruby</p>
```

## Multi-DSL Support

Learn more about how to use this DSL alongside other Glimmer DSLs:

[Glimmer Multi-DSL Support](https://github.com/AndyObtiva/glimmer/tree/master#multi-dsl-support)

## Help

### Issues

You may submit [issues](https://github.com/AndyObtiva/glimmer-dsl-xml/issues) on [GitHub](https://github.com/AndyObtiva/glimmer-dsl-xml/issues).

[Click here to submit an issue.](https://github.com/AndyObtiva/glimmer-dsl-xml/issues)

### Chat

If you need live help, try to [![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Feature Suggestions

These features have been suggested. You might see them in a future version of Glimmer. You are welcome to contribute more feature suggestions.

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing

[CONTRIBUTING.md](CONTRIBUTING.md)

## Contributors

* [Andy Maleh](https://github.com/AndyObtiva) (Founder)

[Click here to view contributor commits.](https://github.com/AndyObtiva/glimmer-dsl-xml/graphs/contributors)

## License

[MIT](LICENSE.txt)

Copyright (c) 2020 - Andy Maleh.

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (Ruby Desktop Development GUI Library).
