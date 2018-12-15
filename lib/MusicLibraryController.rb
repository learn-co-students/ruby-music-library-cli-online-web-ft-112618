require 'pry'
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

    input = ""

    while input != "exit" do # or until input == "exit" do
     input = gets
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
       end

    end




  end

  def list_songs

    sorted_song_list = Song.all.sort_by do |song|
      song.name
    end

    sorted_song_list.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end

  end

  def list_artists

    sorted_artist_list = Artist.all.sort_by do |artist|
      artist.name
    end
        #binding.pry

    sorted_artist_list.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end.uniq # might not need it.

  end

  def list_genres
    sorted_genre_list = Genre.all.sort_by do |genre|
      genre.name
    end

    sorted_genre_list.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end

  end

  def list_songs_by_artist

    puts "Please enter the name of an artist:"
    input = gets.strip

    artist_intance = Artist.all.find do |artist|
      artist.name == input
    end

    selected_songs = Song.all.select do |song|
      song.artist == artist_intance
    end

    sorted_and_selected = selected_songs.sort_by do |song|
      song.name
    end

    sorted_and_selected.each.with_index(1) do |song, index|
      puts "#{index}. #{song.name} - #{song.genre.name}"
    end

  end # end of method

  def list_songs_by_genre

    puts "Please enter the name of a genre:"
    input = gets

    genre_instance = Genre.all.find do |genre|
      genre.name == input
    end

    selected_songs = Song.all.select do |song|
      song.genre == genre_instance
    end

    sorted_and_selected = selected_songs.sort_by do |song|
      song.name
    end

    sorted_and_selected.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name}"
    end

  end # end of method

  def play_song
    puts "Which song number would you like to play?"
    input = gets.to_i

    sorted_song_list = Song.all.sort_by do |song|
      song.name
    end

    if (1..sorted_song_list.length).include?(input)
    matched_song = sorted_song_list[input-1]
    puts "Playing #{matched_song.name} by #{matched_song.artist.name}"
    end

  end #end of paly song

end #end of class MusicLibraryController
