require 'set'

module TabuSearch
  class Context
    attr_accessor :best_genome, :best_fitness
    attr_accessor :tabu_list, :tabu_set, :tabu_size

    def initialize(tabu_size = 10)
      @tabu_list = []
      @tabu_set = Set.new
      @tabu_size = tabu_size

      @best_genome = nil
      @best_fitness = nil
    end

    def search(unit, times)
      @best_genome = unit.genome
      @best_fitness = unit.fitness

      times.times do
        data = search_best_neighbour(unit)
        unit.step(self, data)
      end
      unit.genome = best_genome
      unit
    end

    def update(id, genome, fitness)
      if fitness > best_fitness
        self.best_genome = genome.dup
        self.best_fitness = fitness
      end

      unless tabu_set.include?(id)
        tabu_set << id
        tabu_list << id
        tabu_set.delete(tabu_list.shift) if tabu_list.length > tabu_size
      end
    end


    private

    def search_best_neighbour(unit)
      actions = unit.search_neighbour(self)

      sorted_actions = actions.sort_by {|data| -data[-1] }
      return sorted_actions[0] if sorted_actions[0][-1] > best_fitness

      sorted_actions.each do |data|
        return data unless tabu_set.include?(data[0])
      end
      return sorted_actions.first
    end
  end
end
