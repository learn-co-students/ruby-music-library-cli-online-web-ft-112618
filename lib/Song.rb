class Song
  # #name retrieves the name of a Song
  # #name= can set the name of song
  attr_accessor :name
  
  # @@all is initialized as an empty Array
  @@all = []
  
  #initialize accepts a name for the new Song
  def initialize(name, artist = nil, genre = nil)
    @name = name
    
    # #initialize can be invoked with an optional second 
    # argument an Artist obect to be assigned to the song's
    # property (song belongs to artist)
    # invokes #artist= instead of simply assigning to an
    # @artist instance variable to ensure that associations
    # are created upon initialization
    if(artist != nil)
      self.artist=(artist)
    end
    
    # can be invoked with an optional third argument, a Genre
    # object to be assigned to the song's 'genre' property
    # invokes #genre= instead of simply assigning to a @genre
    # instance variable to ensure that associations are 
    # created upon initialization
    if(genre != nil)
      self.genre=(genre)
    end
    
    # Extremely important! Adds current instance of class to
    # @@all.
    @@all << self
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
  
  # #save adds the song instance to the @@all class variable
  def save
    @@all << self
  end
  
  # #create initializes, saves & returns the song
  def self.create(name)
    instance = Song.new(name)
    instance
  end
  
  # #artist returns the artist of the song (song belongs to
  # artist)
  def artist
    @artist
  end
  
  # #artist= assigns an artist to the song (song belongs to
  # artist)
  def artist=(artist)
    @artist = artist
    
    # invokes Artist#add_song to add itself to the artist's
    # collection of songs (artist has many songs)
    artist.add_song(self)
  end
  
  # genre returns the genre of the song (song belongs to
  # genre).
  def genre
    @genre
  end
  
  # #genre= assigns a genre to the song (song belongs to 
  # genre)
  def genre=(genre)
    @genre = genre
    
    # adds the song to the genre's collection of songs 
    # (genre has many songs).
    # Doesn't add the song to the genre's collection of
    # songs if it already exists therein
    if !(genre.songs.include?(self))
      genre.songs << self
    end
  end
  
  # .find_by_name finds a song instance in @@all by the
  # name property of the song.
  def self.find_by_name(name)
    song_instance = nil
    @@all.each {|song|
      if song.name == name
        song_instance = song
      end
    }
    song_instance
  end
  
  # .find_or_create_by_name returns (does not recreate) an
  # existing song w/the provided name if one exist in @@all.
  def self.find_or_create_by_name(name)
    
    if find_by_name(name) == nil
      # Create a song if an existing match isn't found.
      create(name)
    else
      # Invokes .find_by_name instead of recoding the same
      # functionality.
      find_by_name(name)
    end
  end
    
  # Song .new_from_filename initializes a song based on the
  # passed-in filename
  # Invokes the appropriate Findable methods so as to avoid
  # duplicating objects.
  def self.new_from_filename(filename)
    name = filename.split(' - ')[1]
    artist = filename.split(' - ')[0]
    genre = filename.split(' - ')[2]
    genre = genre.split(".")[0]
    @artist = Artist.find_or_create_by_name(artist)
    @genre = Genre.find_or_create_by_name(genre)
    Song.new(name, @artist, @genre)  
    
  end
  
  # .create_from_filename initializes and saves a song based
  # on the passed-in filename.
  # Invokes teh .new_from_filename instead of re-coding the
  # same functionality.
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
end