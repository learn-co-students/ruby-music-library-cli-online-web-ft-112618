class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  extend Concerns::Findable

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

    def self.destroy_all
      @@all.clear
    end

    def save
      @@all << self
    end

    def self.create(song_name)
      created_song = Song.new(song_name)
      created_song.save
      created_song
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
    end

end
