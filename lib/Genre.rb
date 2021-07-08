class Genre
  # #name retrieves the name of a Genre
  # #name= can set the name of Genre
  attr_accessor :name
  
  # Genre extends the Concerns::Findable module
  extend Concerns::Findable
  
  # @@all is initialized as an empty Array
  @@all = []
  
  # #initialize accepts a name for the new genre
  def initialize(name)
    @name = name
    
    # Creates a 'songs' property set to an empty array 
    # (genre has many songs)
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
  
  # #save adds the Genre instance to the @@all class variable
  def save
    @@all << self
  end
  
  # .create initializes, saves and returns the genre
  def self.create(name)
    instance = Genre.new(name)
    instance.save
    instance
  end
  
  # #songs returns the genre's 'songs' collection (genre has
  # many songs)
  def songs
    @songs
  end
  
  # #artists returns a collection of artists for all of the
  # genres's songs (genre has many artists through songs)
  # Does not return duplicate artists if the genres has more
  # than one song by a particular artist (genre has many
  # artists through songs).
  # Collects artists through its songs instead of maintaining
  # it's own @artists instance variable (genre has many 
  # artists through songs)
  def artists
    genre_artists = []
    Song.all.each {|song|
      if song.genre == self &&
         !genre_artists.include?(song.artist)
         genre_artists << song.artist
       end
    }
    genre_artists
  end
end