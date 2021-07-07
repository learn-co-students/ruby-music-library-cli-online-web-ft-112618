class Genre

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

  def self.create(genre_name)
    created_genre = Genre.new(genre_name)
    created_genre.save
    created_genre
  end

    def add_song(song)
      if song.genre.nil?
        song.genre = self
      end
      @songs << song unless @songs.include?(song)
    end

    def artists
     artists_all = []
     @songs.each do |song|
         artists_all << song.artist unless artists_all.include?(song.artist)
      end
      artists_all
    end

end
