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
        Artist.all.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
      when "list genres"
        Genre.all.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}"}
      when "list artist"
        print "Enter the name of the artist: "
        input2 = gets.chomp
        puts "The artist's songs are:"
        artist = Artist.find_or_create_by_name(input2)
        artist.songs.each.with_index(1) {|song, i| puts "\t#{i}. #{song.name}"}
      when "list genre"
        print "Enter the name of the genre: "
        input2 = gets.chomp
        puts "The songs within that genre are:"
        genre = Genre.find_or_create_by_name(input2)
        genre.songs.each.with_index(1) {|song, i| puts "\t#{i}. #{song.name}"}
      when "play song"
      when "exit"
        break
      end
    end
  end

  def list_songs
    # binding.pry
    Song.all.sort {|a, b| a.name <=> b.name }.each.with_index(1) {|song, i| puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

end
