class Player
  attr_accessor :name, :selection, :win_count

  def initialize(name)
    @name = name
    @win_count = 0
  end

  def valid?
    Game::CHOICES.include? @selection.to_sym
  end

  def selection_detail
    Game::CHOICES[@selection.to_sym]
  end

  def selection_name
    selection_detail[:name]
  end

  def beat?(opponent_selection)
    selection_detail[:beats].keys.include? opponent_selection.to_sym
  end
end
