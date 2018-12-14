require 'pry'

class Song
  attr_accessor :name
  attr_reader :genre, :artist

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end

  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file)
    binding.pry
    song = self.new(file.slice(/-.*-\s/).slice(/\b.*\w\b/))
    song.artist = Artist.find_or_create_by_name(file.slice(/^[\w\s]*/).slice(/[\s\w]*\b/))
    song.genre = Genre.find_or_create_by_name(file.slice(/\b\w+[\s-]?\w*.mp3$/).slice(/^[\w\s-]+/))
    song
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
    song
  end



# binding.pry


end
