require_relative '../models/player'
require_relative '../models/game'

describe Player do
  subject { Player.new('Kirk') }

  context '#initialize' do
    it { expect(subject.win_count).to eq(0) }
  end

  context '#name' do
    it { expect(subject.name).to eq('Kirk') }
  end

  context '#valid?' do
    it 'true for valid selection' do
      subject.selection = 'r'
      expect(subject).to be_valid
    end

    it 'false for invalid selection' do
      subject.selection = 'f'
      expect(subject).not_to be_valid
    end
  end

  context '#selection_detail' do
    before{ subject.selection = 'r' }

    it { expect(subject.selection_detail).to eq(Game::CHOICES[subject.selection.to_sym]) }
  end

  context '#selection_name' do
    before { subject.selection = 'r' }

    it { expect(subject.selection_name).to eq(Game::CHOICES[subject.selection.to_sym][:name]) }
  end

  context '#beat?' do
    before { subject.selection = 'r' }

    it 'true if selection does not beat opponent' do
      expect(subject).to be_beat('l')
    end

    it 'false if selection does beat opponent' do
      expect(subject).not_to be_beat('p')
    end
  end

end
