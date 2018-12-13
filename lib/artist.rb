class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  attr_reader :genres

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
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist == nil ? song.artist = self : song.artist
    self.songs << song unless self.songs.include?(song)
  end

  def genres
    #alternate way - returns array of unique genres
    # x = self.songs.map {|song| song.genre}
    # x.uniq
    #This method adds only unique genres to the array and returns the array
    genres = []
      self.songs.each do |song|
        genres << song.genre unless genres.include?(song.genre)
    end
    genres
  end


end
