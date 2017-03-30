class TestUnit
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

