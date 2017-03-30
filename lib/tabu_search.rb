require "tabu_search/version"
require "tabu_search/context"

module TabuSearch
  def self.included(cls)
    cls.extend(TabuSearch::ClassMethods)
  end

  module ClassMethods
    def new_ts_ctx(tabu_size)
      TabuSearch::Context.new(tabu_size)
    end

    def tabu_search(unit, times, tabu_size)
      new_ts_ctx(tabu_size).search(unit, times)
    end
  end
end
