class Genre
  extend Concerns::Findable, Concerns::Editable
  attr_accessor :name, :song, :artist
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def genre
    @genre
  end

  def artists
    songs.each.collect {|song| song.artist}.uniq
  end
end
