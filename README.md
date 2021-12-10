# Solargraph::DeadEnd

This gem is a plugin for the Solargraph language server, to report missing do(s) and end(s) using [DeadEnd](https://github.com/zombocom/dead_end) inside your editor!

The pitch for DeadEnd is that Ruby is currently bad at identifying why your blocks are broken:

```ruby
# test_simple_de.rb
class MyClass
  def missing_end_method
end
```

```
 ⚡  ruby test_simple_de.rb
test_simple_de.rb:3: syntax error, unexpected end-of-input, expecting `end'

```

... DeadEnd improves on that:

```
 ⚡ dead_end test_simple_de.rb
--> ~/test_simple_de.rb
```

```
Unmatched keyword, missing `end' ?

  1  class MyClass
❯ 2    def missing_end_method
  3  end
```

Now you can get this feedback in your editor!

## Installation
`gem install solargraph-dead_end`

And don't forget to add it to your .solargraph.yml:

```
reporters:
- dead_end
...
plugins:
- solargraph-dead_end
```
