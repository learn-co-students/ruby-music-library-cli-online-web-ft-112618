require_relative './concerns/findable.rb'

class Artist
  # #name retrieves the name of an Artist
  # #name= can set the name of an artist
  attr_accessor :name
  
  # extends the Concerns::Findable module
  extend Concerns::Findable
  
  # @@all is initialized as an empty Array
  @@all = []
  
  # #initialize accepts a name for the new artist
  def initialize(name)
    @name = name
    
    # #initialize creates a 'songs' property to an empty
    # Array
    # (artist has many songs).
    @songs = []
  end
  
  # .all returns the class variable @@all
  def self.all
    @@all
  end
  
  # .destroy_all resets the @@all class variable to an empty
  # Array
  def self.destroy_all
    @@all = []
  end
  
  # #save add the Artist instance to the @@all class variable
  def save
    @@all << self
  end
  
  # .create initializes, saves and returns the artist
  def self.create(name)
    instance = Artist.new(name)
    instance.save
    instance
  end
  
  # #songs returns the artist's 'songs' collection (artist
  # has many songs)
  def songs
    @songs
  end
  
  # #add_song assigns the current artist to the song's artist
  # property
  def add_song(song)
    # does not assign the artist if the song already has an 
    # artist
    if !(song.artist)
      song.artist=(self)
      # adds the song to current artist's songs
      # doesn't add the song to the current artist's
      # collection
      # of songs if it already exist therein.
      @songs << song
    end
  end
  
  # #genres returns a collection of genres for all the 
  # artist's songs (artist has many genres through songs).
  # Doesn't return duplicate genres if the artist has 
  # than one song of a particular genre(artist has many
  # genres through songs).
  # Collects genres through it's songs instead of maintaining
  # it's own @genres instance variable (artist has many 
  # genres through songs).
  def genres
    artist_genres = []
    Song.all.each {|song| 
      if song.artist == self && 
         !artist_genres.include?(song.genre)
        artist_genres << song.genre
      end
    }
    artist_genres
  end
  
end