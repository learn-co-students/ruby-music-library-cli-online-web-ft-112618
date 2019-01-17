class MusicImporter 
  # #path retrieves the path provided to the MusicImporter
  # object
  attr_accessor :path
  
  # #initialize accepts a file path to parse MP3 files from.
  def initialize(path)
    @path = path
    @files = []
  end
  
  # #files loads all the MP3 files in the path directory
  # #normalizes the filename to just the MP3 filename 
  # w/no path
  def files
    Dir.open @path do |dir|
      @files = dir.entries.delete_if{|element|
        !element.include? ".mp3"
      }
    end
  end
  
  # #import imports the files into the library by invoking 
  # Song.create_from_filename
  def import
    files
    @files.each {|file|
      Song.create_from_filename(file)
    }
  end
end