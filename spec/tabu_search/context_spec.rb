RSpec.describe TabuSearch::Context do
  let(:unit) { TestUnit.new([1, 1, 0, 1, 1]) }


  describe '#search' do
    it 'should not change best unit' do
      ctx = TabuSearch::Context.new(10)
      unit = TestUnit.new([0, 1, 0, 1, 0])
      expect {
        ctx.search(unit, 5)
      }.to_not change(unit, :fitness)
    end

    describe 'tabu > times' do
      let(:ctx) { TabuSearch::Context.new(10) }

      it 'should return better result' do
        expect {
          ctx.search(unit, 5)
        }.to change { unit.fitness }.by(170)

        u2 = TestUnit.new([1, 0, 1, 0, 0])
        expect {
          ctx.search(u2, 5)
        }.to change { u2.fitness }.by(98)
      end
    end

    describe 'tabu <= times' do
      let(:ctx) { TabuSearch::Context.new(5) }

      it 'should return better result' do
        expect {
          ctx.search(unit, 10)
        }.to change { unit.fitness }.by(170)

        u2 = TestUnit.new([1, 0, 1, 0, 0])
        expect {
          ctx.search(u2, 10)
        }.to change { u2.fitness }.by(170)

        u3 = TestUnit.new([0, 0, 1, 0, 0])
        expect {
          ctx.search(u3, 5)
        }.to change { u3.fitness }.by(54)
      end
    end
  end

  describe 'search_best_neighbour' do
    let(:ctx) { TabuSearch::Context.new(5) }

    it 'should return best data if tabu list is empty' do
      ctx.best_fitness = 0
      allow(unit).to receive(:search_neighbour).and_return([['a', 1], ['b', 5], ['c', 3]])
      expect(ctx.search_best_neighbour(unit)).to eql(['b', 5])
    end

    it 'should return best data and except tabu list' do
      ctx.best_fitness = 0
      ctx.update('b', [], 5)
      allow(unit).to receive(:search_neighbour).and_return([['a', 1], ['b', 5], ['c', 3]])
      expect(ctx.search_best_neighbour(unit)).to eql(['c', 3])
    end

    it 'should return best data and ignore tabu list if fitness > hope-fitness' do
      ctx.best_fitness = 0
      ctx.update('b', [], 3)
      allow(unit).to receive(:search_neighbour).and_return([['a', 1], ['b', 5], ['c', 3]])
      expect(ctx.search_best_neighbour(unit)).to eql(['b', 5])
    end

    it 'should return best data and ignore tabu list if all units in tabu list' do
      ctx.best_fitness = 0
      ctx.update('a', [], 4)
      ctx.update('b', [], 3)
      ctx.update('c', [], 3)
      allow(unit).to receive(:search_neighbour).and_return([['a', 1], ['b', 4], ['c', 3]])
      expect(ctx.search_best_neighbour(unit)).to eql(['b', 4])
    end
  end
end
