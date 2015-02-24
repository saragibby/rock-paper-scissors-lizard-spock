require_relative '../models/game'

describe Game do
  subject { Game.new('Kirk') }

  context '#initialize' do
    it { expect(subject.player1.name).to eq('Kirk') }
    it { expect(subject.player2.class.name).to eq('ComputerPlayer')}
  end

  context '#result' do
    it 'returns tie if both players picked same choice' do
      subject.player1.selection = 'r'
      allow(subject.player2).to receive(:selection) { 'r' }
      expect(subject.result).to eq('It was a tie! No winner')
    end

    it 'returns player1 name if he/she beats player2 choice' do
      subject.player2.pick
      subject.player1.selection = get_choice_that_beats(subject.player2.selection)
      expect(subject.result).to eq("WINNER is: #{subject.player1.name} - #{subject.player1.selection_name} #{winner_choice_action(subject.player1.selection, subject.player2.selection)} #{subject.player2.selection_name}")
    end

    it 'returns player2 name if he/she beats player1 choice' do
      subject.player2.pick
      subject.player1.selection = get_choice_that_loses(subject.player2.selection)
      expect(subject.result).to eq("WINNER is: #{subject.player2.name} - #{subject.player2.selection_name} #{winner_choice_action(subject.player2.selection, subject.player1.selection)} #{subject.player1.selection_name}")
    end
  end

  context '#champion' do
    it 'returns tie if matching win counts' do
      subject.player1.win_count = 1
      subject.player2.win_count = 1
      expect(subject.champion).to eq('TIE!!!')
    end

    it 'returns player1 name if he/she has more wins' do
      subject.player1.win_count = 1
      subject.player2.win_count = 0
      expect(subject.champion).to eq(subject.player1.name)
    end

    it 'returns player2 name if he/she has more wins' do
      subject.player1.win_count = 0
      subject.player2.win_count = 1
      expect(subject.champion).to eq(subject.player2.name)
    end
  end
end

def get_choice_that_beats(choice)
  Game::CHOICES.select{ |k,v| v[:beats].include?(choice.to_sym) }.first[0].to_s
end

def get_choice_that_loses(choice)
  Game::CHOICES[choice.to_sym][:beats].first[0].to_s
end

def winner_choice_action(choice, losing_action)
  Game::CHOICES[choice.to_sym][:beats][losing_action.to_sym]
end
