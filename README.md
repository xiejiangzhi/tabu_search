# TabuSearch

A simple Tabu Search framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tabu_search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tabu_search

## Usage

Require methods: 

* `Class#genome` Support dup
* `Class#genome=`
* `Class#fitness` Current unit fitness, the bigger than better
* `Class#search_neighbour(ts)` Search some neighbour units
* `Class#step(ts, data)` Update unit and TS context

Example:

```
class Unit
  include TabuSearch

  LEN = 5

  attr_accessor :genome

  def initialize(genome)
    @genome = genome.dup
  end

  def fitness
    val = genome.join.to_i(2)
    return 0 if val > 10
    10 * val - val * 3 + val ** 2
  end

  def step(ts, data)
    id, index, val, new_fitness = data
    genome[index] = val
    ts.update(id, genome, new_fitness)
  end

  def search_neighbour(ts)
    LEN.times.map do |i|
      origin = genome[i]
      new_val = 1 - origin
      genome[i] = new_val
      new_fitness = fitness
      genome[i] = origin
      ["#{i}-#{new_val}", i, new_val, new_fitness]
    end
  end
end

# Class.tabu_search(instance, times, tabu_size)
Unit.tabu_search(Unit.new([1,2,3]), 10, 10)
# or
Unit.new_ts_ctx(10).search(Unit.new([1,2,3]), 10)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xjz19901211]/tabu_search.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

