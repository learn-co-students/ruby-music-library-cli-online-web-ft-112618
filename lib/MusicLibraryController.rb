class MusicLibraryController
  
  attr_accessor :path
  
  # #initialize accepts one argument, the path to the MP3
  # files to be imported.
  # The 'path' argument defaults to '.db/mp3s'.
  # Invokes the #import method on the created MusicImporter
  # object.
  def initialize(path = './db/mp3s')
    #@path = path
    @ImportedMusic = MusicImporter.new(path)
    @ImportedMusic.import
  end
  
  # Welcomes the user.
  # asks the user for input
  # loops and asks for user input until they type in exit.
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
    input = nil
    while input != "exit"
      input = gets.strip
      
      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end
    end
  end
  
  # #list_songs prints all songs in the music library in a
  # numbered list (alphabetized by song name)
  # Is not hard-coded
  def list_songs
    #get song names
    songNames = []
    Song.all.each {|songinstance|
      songNames << songinstance.name
    }
    
    # Sort songnames
    songNames.sort!
    
    # Iterate through sorted songs and output them.
    songNames.each_with_index{|songName, index|
      puts "#{index + 1}. #{Song.find_by_name(songName).artist.name} - #{songName} - #{Song.find_by_name(songName).genre.name}"
    }
  end
  
  # #list_artists prints all artists in the music library in
  # a numbered list (alphabetized by artist name)
  # Is not hard-coded
  def list_artists
    # Get all artists names
    artistNames = []
    Artist.all.each{|artistInstance|
      artistNames << artistInstance.name
    }
    
    # Sort Artist names
    artistNames.sort!
    
    # Iterate through artistNames and output them
    artistNames.each_with_index{|artistName, index|
      puts "#{index + 1}. #{artistName}"
    }
  end
  
  # #list_genres prints all genres in the music library
  # in a numbered list (alphabetized by artist name).
  def list_genres
    # get genre names
    genreNames = []
    Genre.all.each{|genre|
      genreNames << genre.name
    }
    
    # Sort the genreNames
    genreNames.sort!
    
    # Output the genreNames
    genreNames.each_with_index{|genreName, index|
      puts "#{index + 1}. #{genreName}"
    }
  end
  
  # #list_songs_by_artist prompts the user to enter an
  # artist
  # Accepts user input
  # Prints all songs by a particular artist in a numbered
  # list (alphabetized by song name)
  # Does nothing if not matching artist is found
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artistName = gets.strip
    
    # Store matching songNames to be sorted
    sortedNames = []
    
    # Iterate through songs and store matches.
    Song.all.each{|songInstance|
      if songInstance.artist.name == artistName
        sortedNames << songInstance.name
      end
    }
    
    # sort songNames
    sortedNames.sort!
    
    # Outputs the matching song name and genre
    sortedNames.each_with_index{|song, index|
      puts "#{index + 1}. #{Song.find_by_name(song).name} - #{Song.find_by_name(song).genre.name}"
    }
  end
  
  # #list_song_by_genre prompts the user to enter a genre
  # Prints all songs by a particular genre in numbered 
  # (alphabetized by a song name)
  # Does nothing if no matching genre is found.
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genreName = gets.strip
    
    # Stores song names to be sorted later
    songNames = []
    
    # Gets matching genres and stores song names that match.
    Song.all.each{|songInstance| 
      if (songInstance.genre.name == genreName)
        songNames << songInstance.name
      end
    }
    
    # sort songNames
    songNames.sort!
    
    # Output list of songs matching genre
    songNames.each_with_index{|songName, index|
      puts "#{index + 1}. #{Song.find_by_name(songName).artist.name} - #{Song.find_by_name(songName).name}"
    }
  end
  
  # #play_song prompts the user to choose a song from the 
  # alphabetized list output by #list_songs.
  def play_song
    puts "Which song number would you like to play?"
    songNumber = gets.strip
    
    #get song names
    songNames = []
    Song.all.each {|songinstance|
      songNames << songinstance.name
    }
    
    # Sort songnames
    songNames.sort!
    
    if(songNumber.to_i >= 1 && songNumber.to_i <= songNames.size)
      if(Song.find_by_name(songNames[songNumber.to_i - 1]) != nil)
        puts "Playing #{songNames[songNumber.to_i - 1]} by #{Song.find_by_name(songNames[songNumber.to_i - 1]).artist.name}"
      end
    end
  end
end
