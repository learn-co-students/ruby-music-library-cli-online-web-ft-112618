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

    user_input = ""

    while user_input != "exit" do
     user_input = gets
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

    sorted_artist_list = Song.all.sort_by do |song|
      song.artist.name
    end
        #binding.pry

    sorted_artist_list.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name}"
    end

  end



end #end of class MusicLibraryController
