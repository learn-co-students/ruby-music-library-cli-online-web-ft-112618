class MusicLibraryController

  def initialize(path = './db/mp3s')
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
      when "list songs"
        self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      when "exit"
        break
      end
    end
  end

  def list_songs
    Song.all.sort {|a, b| a.name <=> b.name }.each.with_index(1) {|song, i| puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name }.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name }.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input2 = gets.chomp
    artist = Artist.find_or_create_by_name(input2)
    artist.songs.sort {|a, b| a.name <=> b.name }.each.with_index(1) {|song, i| puts "#{i}. #{song.name} - #{song.genre.name}"}
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input2 = gets.chomp
    genre = Genre.find_or_create_by_name(input2)
    genre.songs.sort {|a, b| a.name <=> b.name }.each.with_index(1) {|song, i| puts "#{i}. #{song.artist.name} - #{song.name}"}
  end

  def play_song
    puts "Which song number would you like to play?"
    input2 = gets.chomp
    song = Song.all.sort {|a, b| a.name <=> b.name }[input2.to_i - 1]
    y = Song.all.sort {|a, b| a.name <=> b.name }.size
    puts "Playing #{song.name} by #{song.artist.name}" if (1..y).include?(input2.to_i)
  end

end
