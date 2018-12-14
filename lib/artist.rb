class Artist
  extend Concerns::Findable, Concerns::Editable
  include Concerns::Savable
  attr_accessor :name
  attr_reader :songs  

  @@all =[]

  def initialize(name)
    @name = name    
    @songs = []
  end
  
  def genres
    self.songs.map(&:genre).uniq
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    self.songs << song unless self.songs.include?(song)
  end
  
  def self.all
    @@all
  end
end
