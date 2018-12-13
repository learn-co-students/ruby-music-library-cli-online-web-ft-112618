require 'pry'

class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
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
    self.class.all << self
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self) unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(filename)
    #split the filename into an array
    song_array = filename.split(" - ")
    #create the song if it doesn't already exist
    new_song = self.find_or_create_by_name(song_array[1])

    #Assign the artist to the song
    new_song.artist = Artist.find_or_create_by_name(song_array[0])
    # Assign the genre to the song
     new_song.genre = Genre.find_or_create_by_name(song_array[2].gsub(".mp3", ""))

     #return the song
     new_song
  end

    def self.create_from_filename(filename)
      self.new_from_filename(filename)
      #binding.pry
    end

end
