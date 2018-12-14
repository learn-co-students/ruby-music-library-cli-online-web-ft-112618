class MusicLibraryController
  attr_reader :path

  def initialize(path = './db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = ''
    until input == 'exit' do
      input = gets.chomp
      case input
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end
  end

  def list_songs
    list_collection(sort_class(Song))
  end

  def list_artists
    list_collection(sort_class(Artist))
  end

  def list_genres
    list_collection(sort_class(Genre))
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    list_songs_sorted(Artist)
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    list_songs_sorted(Genre)
  end

  def play_song
    puts "Which song number would you like to play?"
    selection = gets.chomp.to_i
    if selection < Song.all.length && selection > 0 
      song = sort_class(Song)[selection - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

  def sort_class(klass)
    alphabetize(klass.all)
  end

  def alphabetize(collection)
    collection.sort_by(&:name)
  end

  def list_collection(collection)
    is_song = collection.first.instance_of?(Song)
    collection.each.with_index do |element, index|      
      puts is_song ? "#{index + 1}. #{element.artist.name} - #{element.name} - #{element.genre.name}" \
                   : "#{index + 1}. #{element.name}"
    end
  end

  def list_songs_sorted(klass)
    filter = gets.chomp
    # Dangerous to use find_or_create_by_name here without sanitizing input
    alphabetize(klass.find_or_create_by_name(filter).songs).each.with_index do |song, index|
      puts klass == Artist ? "#{index + 1}. #{song.name} - #{song.genre.name}" \
                           : "#{index + 1}. #{song.artist.name} - #{song.name}"
    end
  end
end
