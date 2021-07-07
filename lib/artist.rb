class Artist

  attr_accessor :name, :songs

  @@all = []

  extend Concerns::Findable

    def initialize(name)
      @name = name
      @songs = []
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

    def self.create(artist_name)
      created_artist = Artist.new(artist_name)
      created_artist.save
      created_artist
    end

    def add_song(song)
      if song.artist.nil?
        song.artist = self
      end
      @songs << song unless @songs.include?(song)
    end

    def genres
     genres_all = []
     @songs.each do |song|
         genres_all << song.genre unless genres_all.include?(song.genre)
      end
      genres_all
    end

end
