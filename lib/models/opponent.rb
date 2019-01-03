class Opponent < ActiveRecord::Base
  has_many :battles
  has_many :superheros, through: :battles

  # def find_contender
  #   puts "What's your name"
  # end

  # need to match superhero table attributes, need name, intelligence, strength, speed
  def self.create_opponent
    self.create(name: get_opponent_name, intelligence: get_opponent_intelligence, strength: get_opponent_strength, speed: get_opponent_speed)
  end

  def show_stats
    puts "Here are your stats:"
    puts " - Name: #{self.name}"
    puts " - Intelligence: #{self.intelligence}"
    puts " - Strength: #{self.strength}"
    puts " - Speed: #{self.speed}"
    puts "\n"
  end

  def battle_30_heroes
    Battle.delete_all #redundancy check to clear previous game battles
    30.times do
      Battle.create(name: "Battle of #{Faker::Address.unique.city}", opponent_id: Opponent.last.id, superhero_id: Superhero.ids.sample)
    end
  end

  def battled_superheroes
    names = self.battles.map {|battle| battle.superhero.name}
    unique_names = names.uniq
  end

  def print_battled_heroes_names
    puts "You battled with the following Superheroes: "
    puts "\n"
    sleep(0.75)
    battled_superheroes.each {|name| puts " - #{name}"}
    puts "\n"
  end

  def chess_victor
    self.superheros.where("intelligence < ?", self.intelligence).distinct
  end

  def arm_wrestling_victor
    self.superheros.where("strength < ?", self.strength).distinct
  end

  def speed_walking_victor
    self.superheros.where("speed < ?", self.speed).distinct
  end

  def print_chess_victor
    puts "You beat the following Superheroes in a super intense game of chess:"
    puts "\n"
    chess_victor.each {|hero| puts " - #{hero.name} -- Their intelligence (#{hero.intelligence}) was no match for yours (#{opp.intelligence})"}
    puts "\n"
  end

  def print_arm_wrestling_victor
    puts "You beat the following Superheroes in a super veiny arm wrestling match:"
    puts "\n"
    arm_wrestling_victor.each {|hero| puts " - #{hero.name} -- Their strength (#{hero.strength}) was no match for yours (#{opp.strength})"}
    puts "\n"
  end

  def print_speed_walking_victor
    puts "You beat the following Superheroes in a super thigh-burning speed walking race:"
    puts "\n"
    speed_walking_victor.each {|hero| puts " - #{hero.name} -- Their speed (#{hero.speed}) was no match for yours (#{opp.speed})"}
    puts "\n"
  end

end
