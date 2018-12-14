class Genre
  extend Concerns::Findable, Concerns::Editable
  include Concerns::Savable
  attr_accessor :name
  attr_reader :songs

  @@all =[]

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def artists
    self.songs.map(&:artist).uniq
  end
  
  def add_song(song)    
    song.genre = self unless song.genre == self
    self.songs << song unless self.songs.include?(song)
  end

  def self.all
    @@all
  end
end
