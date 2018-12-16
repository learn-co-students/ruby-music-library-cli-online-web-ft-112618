class Artist
  extend Concerns::Findable, Concerns::Editable
  attr_accessor :name, :genre, :song
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
    artist = Artist.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

  def add_song(song)
    if song.artist != nil
      song.artist
    else
      song.artist = self
    end
    @songs << song unless songs.include?(song)
  end

  def genres
    songs.each.collect {|song| song.genre}.uniq
  end
end
