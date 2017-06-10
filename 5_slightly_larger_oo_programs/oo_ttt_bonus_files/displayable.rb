module Displayable
  CONSOLE_WIDTH = 80

  private
  def bannerize(message, style = "=")
    puts style * CONSOLE_WIDTH
    center_print(message)
    puts style * CONSOLE_WIDTH
  end

  def center_print(message)
    puts message.center(CONSOLE_WIDTH)
  end

  def prompt(message); puts ">> #{message}"; end

  def capitalize_words(str)
    str.split.map(&:capitalize).join(' ')
  end

  def alert(message); puts "<!>...#{message}..."; end

  def display_player_created
    bannerize("#{self.class} player created!" \
    " Name =>'#{self.name}' | Marker =>'#{self.marker}'", '-')
  end

  def choice_or_default(choice, default_marker)
    choice.empty? ? default_marker : choice.upcase
  end
end
