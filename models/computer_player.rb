class ComputerPlayer
  attr_reader :selection
  attr_accessor :win_count

  def initialize
    @win_count = 0
  end

  def name; "Computer"; end

  def pick
    @selection = Game::CHOICES.keys.sample.to_s
  end

  def selection_detail
    Game::CHOICES[@selection.to_sym]
  end

  def selection_name
    selection_detail[:name]
  end
end
