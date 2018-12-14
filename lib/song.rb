class Song
  extend Concerns::Findable, Concerns::Editable
  include Concerns::Savable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all =[]

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.all
    @@all
  end

  def self.new_from_filename(filename)    
    artist, title, genre, extension = filename.split(/ - |\./)
    new_artist = Artist.find_or_create_by_name(artist.strip)
    new_genre = Genre.find_or_create_by_name(genre.strip)
    
    Song.new(title.strip, new_artist, new_genre).tap do |song|
      new_artist.add_song(song)
      new_genre.add_song(song)
    end
  end

  def self.create_from_filename(filename)
    Song.new_from_filename(filename).save
  end
end
