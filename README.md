# RPlate

Rplate is an opinionated template generator for ruby entities.

In particular in order to take full advantage of rplate features your naming conventions must follow the [zeitwerk filestructure](https://github.com/fxn/zeitwerk#file-structure).

Good news to be mentioned is that from rails 6 [zeitwerk gem](https://github.com/fxn/zeitwerk) is the default require engine and you are probably good to go :-)

## Installation

Install it yourself as:

```console
  $ gem install rplate
```

## Usage

```console
rplate generate MyClass
```

will place:
- a Myclass class in `lib/my_class.rb`
- the related spec file in `spec/lib/my_class_spec.rb`

Once those files have been generated `rplate` will run rubocop on them according to the styleguide in `.rubocop.yml`.

###### Note
Currently it is not supported the use of a custom rubocop styleguide.

#### Allowed arguments

Rplate accepts some arguments. Check that by calling the help:

```console
rplate help generate
```

That will result in:

```console
Usage:
  rplate generate CLASS_NAME

Options:
  -t, [--type=TYPE]                       # `class` or `module`
                                          # Default: class
  -m, [--required-methods=one two three]  # the class methods
  -r, [--root=ROOT]                       # example: `app/controllers`
                                          # Default: lib

generate a ruby entity with the given name
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/nic-lan/rplate](https://github.com/nic-lan/rplate).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
