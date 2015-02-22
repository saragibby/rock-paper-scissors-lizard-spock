class Game
  CHOICES = { r:  { name: 'rock', beats: { l: 'crushes', sc: 'crushes' } },
              p:  { name: 'paper', beats: { r: 'covers', sp: 'disproves' } },
              sc: { name: 'scissors', beats: { l: 'decapitates', p: 'cuts' } },
              l:  { name: 'lizard', beats: { p: 'eats', sp: 'poisons'} },
              sp: { name: 'spock', beats: { r: 'vapourises', sc: 'smashes' } } }

  attr_reader :player1, :player2

  def initialize(player_name)
    @player1 = Player.new(player_name)
    @player2 = ComputerPlayer.new
    @round = 1
  end

  def result
    if tie?
      "It was a tie! No winner"
    else
      winner.win_count += 1
      "WINNER is: #{winner.name} - #{winner.selection_name} #{winner_action} #{loser.selection_name}"
    end
  end

  def champion
    if @player1.win_count == @player2.win_count
      "TIE!!!"
    else
      @player1.win_count > @player2.win_count ? @player1.name : @player2.name
    end
  end

  private

    def tie?
      @player1.selection == @player2.selection
    end

    def winner
      player1.beat?(player2.selection) ? player1 : player2
    end

    def loser
      player1.beat?(player2.selection) ? player2 : player1
    end

    def winner_action
      winner.selection_detail[:beats][loser.selection.to_sym]
    end
end
