class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_genre = Genre.new(name)
    new_genre.save
    new_genre
  end

  def songs
    @songs
  end

  def add_song(song)
    song.genre == nil ? song.genre = self : song.genre
    self.songs << song unless self.songs.include?(song)
  end

  def artists
    artists = []
    self.songs.each do |song|
      artists << song.artist unless artists.include?(song.artist)
    end
    artists
  end

end
