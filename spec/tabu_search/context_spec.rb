RSpec.describe TabuSearch::Context do
  let(:unit) { TestUnit.new([1, 1, 0, 1, 1]) }

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
