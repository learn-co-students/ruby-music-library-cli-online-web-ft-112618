class Song
  extend Concerns::Findable, Concerns::Editable
  attr_accessor :name
  attr_reader :genre, :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @genre = genre
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
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

  def genre= (genre)
    @genre = genre
    genre.songs << self
    genre.songs.uniq!
  end

  def self.new_from_filename(file)
    parsed = file.split(" - ")
    new_artist = parsed[0]
    new_genre = parsed[2].chomp(".mp3")
    new_song = self.new(parsed[1])
    new_song.artist = Artist.find_or_create_by_name(new_artist)
    new_song.genre = Genre.find_or_create_by_name(new_genre)
    new_song.artist.add_song(new_song)
    new_song
  end

  def self.create_from_filename(file)
    new_from_filename(file).save
  end
end
