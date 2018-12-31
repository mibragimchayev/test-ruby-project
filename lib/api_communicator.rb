 require 'rest-client'
 require 'json'


def get_superhero(id)
  superhero_string = RestClient.get("https://superheroapi.com/api.php/10156542011821195/#{id}")
  superhero_hash = JSON.parse(superhero_string)
end

# need name, intelligence, strength, speed of each superhero

def get_hero_name(id)
  get_superhero(id)["name"]
end

def get_hero_intelligence(id)
  get_superhero(id)["powerstats"]["intelligence"]
end

def get_hero_strength(id)
  get_superhero(id)["powerstats"]["strength"]
end

def get_hero_speed(id)
  get_superhero(id)["powerstats"]["speed"]
end