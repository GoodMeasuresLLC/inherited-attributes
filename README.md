# Inherited::Attributes

Extends [ancestry](https://github.com/stefankroes/ancestry) to allow attributes to be inherited from ancestors.

When you want nodes in your tree to be able to get default values for their
attributes from their parent.

## Usage

### Tell your model that it has inherited attributes

```ruby
class Node < ActiveRecord::Base
  has_ancestry

  inherited_attribute :value

  # If the root node has a nil location, use this as the default value instead.
  # Note the special syntax - the default value is evaluated.
  # strings: '"<the default>"'
  # booleans: '<true|false>'
  # integers: '<number>'
  # enumerations: '"<name of the enum>"'
  inherited_attribute :location, :default => '"Saint Louis"'
end
```

### Accessing Inherited Attributes

```
root       = Node.create!
child      = Node.create!(:parent => root, :value => 12, :location => "Boston")
grandchild = Node.create!(:parent => child)

# ------------------------------------------------------------------------------
# The value of the node, without ancestry
# ------------------------------------------------------------------------------
root.value       # nil
child.value      # 12
grandchild.value # nil

root.location       #
child.location      # 'Boston'
grandchild.location # nil

# ------------------------------------------------------------------------------
# The value of the node, or the inherited value if its not set
# ------------------------------------------------------------------------------
root.effective_value       # nil
child.effective_value      # 12
grandchild.effective_value # 12 -- inherited from child

root.effective_location       # 'Saint Louis' -- using the default value
child.effective_location      # 'Boston'      -- Using the node's value
grandchild.effective_location # 'Boston'      -- Inherited from child

# ------------------------------------------------------------------------------
# The inherited value of the node or the default, ignoring the node's value
# ------------------------------------------------------------------------------
root.inherited_value        # nil
child.inherited_value       # nil
grandchild.inherited_value  # 12 -- inherited from child

root.inherited_location       # 'Saint Louis' -- using the default value
child.inherited_location      # 'Saint Louis' -- Inherited from root
grandchild.inherited_location # 'Boston'      -- Inherited from child

```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'inherited-attributes'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install inherited-attributes
```

## Contributing

1. Fork the repo.

2. Run the tests (appraisal rake spec). We only take pull requests with passing tests, and it's great
to know that you have a clean slate: `bundle && rake`

3. Add a test for your change. Only refactoring and documentation changes
require no new tests. If you are adding functionality or fixing a bug, we need
a test!

4. Make the test pass.

5. Push to your fork and submit a pull request.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
