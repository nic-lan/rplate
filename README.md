# RPlate

Rplate is an opinionated template generator for ruby entities.

It is tested to work on ruby 2.4+ in ubuntu and macosx platforms.

###### Note

To take full advantage of rplate features your naming conventions must follow the [zeitwerk filestructure](https://github.com/fxn/zeitwerk#file-structure).

Good news to be mentioned is that from rails 6 [zeitwerk gem](https://github.com/fxn/zeitwerk) is the default require engine and you are probably good to go :-)

## Usage

The cli interface of `rplate` expects a list of underscored entities

```console
rplate generate my_module my_class
```

will:
- place the `Myclass` class in `lib/my_module/my_class.rb`
- place the related spec file in `spec/lib/my_module/my_class_spec.rb`
- scope `MyClass` inside the `MyNamespace` module

Once those files have been generated `rplate` will run rubocop on them according to the styleguide in `.rubocop.yml`.

###### Note
Currently it is not supported the use of a custom rubocop styleguide but this does not mean that you cannot run your local styleguide by your own ;-)

#### Allowed arguments

Rplate accepts some arguments. Check that by calling the help:

```console
rplate help generate
```

That will result in:

```console
Usage:
  rplate generate [ENTITIES]

Options:
  -t, [--type=TYPE]                       # `class` or `module`
                                          # Default: class
  -m, [--required-methods=one two three]  # the class methods
  -r, [--root=ROOT]                       # example: `app/controllers`
                                          # Default: lib
  -i, [--inflections=one two three]       # example: -i rplate:RPlate api:API

generate a ruby entity with the given name
```

#### Type

You can define what kind of type your new entity should be: class or module

#### Required Methods

`rplate` allows you to pass the list of desired methods you would like the new entity be provided.

For example:

```console
rplate generate my_class -m self.perform perform
```

will declare the 2 methods in the result entity and spec.
To be noted that when `?` method wants to be added, it needs to be passed within `''`.
For example.

```console
rplate generate my_class -m 'valid?'
```

#### Root Dir

Sometime you want to place a new entity in a root dir which is not expected to be the root for an another entity.
This can be the case for example of `app/controllers` for a rails application.
`rplate` allows you to pass this root dir via `-r` option.

#### Inflections

Sometime you want to place an entity `api http_client` and you want the result entities to inflect `api` with `API` and `http` with `HTTP`.
`rplate` allows you to do that with the inflections:

```console
rplate generate api http_client -i api:API http_client:HTTPClient
```

Enjoy !!!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/nic-lan/rplate](https://github.com/nic-lan/rplate).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
