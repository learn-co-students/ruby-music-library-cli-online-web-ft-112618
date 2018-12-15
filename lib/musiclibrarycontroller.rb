class MusicLibraryController
  def initialize(path = "./db/mp3s")
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

    loop do
      input = gets.chomp
        case input
        when "exit"
          break
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        end
      end
  end

  def list_songs
    Song.all.sort{|first,second| first.name <=> second.name}.each.with_index(1) do |data, index|
      puts "#{index}. #{data.artist.name} - #{data.name} - #{data.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{|first,second| first.name <=> second.name}.each.with_index(1) do |data, index|
      puts "#{index}. #{data.name}"
    end
  end

  def list_genres
    Genre.all.sort{|first,second| first.name <=> second.name}.each.with_index(1) do |data, index|
      puts "#{index}. #{data.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_or_create_by_name(input)
    artist.songs.sort{|first,second| first.name <=> second.name}.find.with_index(1) do |data, index|
      puts "#{index}. #{data.name} - #{data.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre = Genre.find_or_create_by_name(input)
    genre.songs.sort{|first,second| first.name <=> second.name}.find.with_index(1) do |data, index|
      puts "#{index}. #{data.artist.name} - #{data.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    Song.all.sort{|first,second| first.name <=> second.name}.each.with_index(1) do |data, index|
      if input.to_i == index
        puts "Playing #{data.name} by #{data.artist.name}"
      end
    end
  end
end
