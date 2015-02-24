require_relative '../models/computer_player'
require_relative '../models/game'

describe ComputerPlayer do
  subject { ComputerPlayer.new }

  context '#initialize' do
    it { expect(subject.win_count).to eq(0) }
  end

  context '#name' do
    it { expect(subject.name).to eq('Computer') }
  end

  context '#pick' do
    before { subject.pick }

    it 'sets selection' do
      expect(subject.selection).not_to be_nil
    end

    it 'gets random value from Game::CHOICES' do
      expect(Game::CHOICES).to include(subject.selection.to_sym)
    end
  end

  context '#selection_detail' do
    before{ subject.pick }

    it { expect(subject.selection_detail).to eq(Game::CHOICES[subject.selection.to_sym]) }
  end

  context '#selection_name' do
    before { subject.pick }

    it { expect(subject.selection_name).to eq(Game::CHOICES[subject.selection.to_sym][:name]) }
  end

end
