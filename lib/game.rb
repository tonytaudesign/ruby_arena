require_relative 'arena'
require_relative 'class_loader'
require_relative 'gui'
require_relative 'robot'

class Game
  attr_reader :arena

  def initialize
    @arena = Arena.new
    add_robots_to_arena
  end

  def run
    gui.show
  end

  private

  def gui
    Gui.new(arena)
  end

  def add_robots_to_arena
    robots.each do |robot|
      arena.add_robot(robot)
    end
  end

  def robots
    ARGV.map do |file|
      ai_class = load_class_from_file(file)

      Robot.new({
        ai: ai_class,
        arena: arena
      })
    end
  end

  def load_class_from_file(file)
    ClassLoader.new("#{pwd}/#{file}").get_class
  end

  def pwd
    Dir.getwd
  end
end
