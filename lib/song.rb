require 'pry'
require_relative './concerns/findable_module.rb'
class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    #ßbinding.pry
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist
    @artist
  end

  def artist=(artist)

      @artist = artist
      artist.add_song(self) unless artist.songs.include?(self)
      
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.new_from_filename(file_name)
      artist_name = file_name.split(" - ")[0]
      song_name = file_name.split(" - ")[1]
      genre_name = file_name.split(" - ")[2].split(".")[0]

      new_song = Song.new(song_name)
      new_artist = Artist.find_or_create_by_name(artist_name)
      new_song.artist = new_artist
      new_genre = Genre.find_or_create_by_name(genre_name)
      new_song.genre = new_genre

      new_song
  end

  def self.create_from_filename(file_name)
      new_song = self.new_from_filename(file_name)
      new_song.save
  end



end # end of Song
