class MusicLibraryController
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = nil
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.strip.downcase

      case input
      when  "list songs"
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
    sorted_list = Song.all.sort_by {|song| song.name}
    sorted_list.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    #sort list alphabetically by artist name and map it to array with just the artist name.
    sorted_list = Artist.all.sort_by {|artist| artist.name}.map {|artist| artist.name}
    #iterate through the alphabatized array, assign an index to it and puts it out in list form.
    sorted_list.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist}"
    end
  end

  def list_genres
    #sort list alphabetically by genre name and map it to array with just the genre name.
    sorted_list = Genre.all.sort_by {|genre| genre.name}.map {|genre| genre.name}
    #iterate through the alphabatized array, assign an index to it and puts it out in list form.
    sorted_list.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end

  def list_songs_by_artist
    puts 'Please enter the name of an artist:'
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort_by(&:name).each.with_index(1) do |s, i|
        puts "#{i}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts 'Please enter the name of a genre:'
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort_by(&:name).each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if (1..Song.all.length).include?(input - 1)
      song = Song.all.sort {|a, b| a.name <=> b.name}[input -1]
    end
      puts "Playing #{song.name} by #{song.artist.name}" if song

    #binding.pry
  end

end
