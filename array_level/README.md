# Array Flatten Method Code Challenge
## Description
The challenge presented is as follows:

1. Write an algorithm to flatten an arbitrarily nested array of values.

## Proposed Solution
Given Ruby has `flatten` defined on instances of `Array`, a new method `level` will be implemented.
 
 As Ruby classes are completely open the method will be added to the `Array` class to be available on instances of `Array`.

## Usage
To include the solution in your project please include the gem in your Gemfile:

```ruby
gem 'array_level', source: 'https://gem.fury.io/morbidslug'
```

or add the gem repository to your local gem sources:

```bash
gem sources -a https://gem.fury.io/morbidslug/
```

and install:

```bash
gem install array_level
```

The commit history has not been squashed to retain example of workflow.

## Files
- specs for the new method are included in the `specs` folder
- implementation is found in `lib`

