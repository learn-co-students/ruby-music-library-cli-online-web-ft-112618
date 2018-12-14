class MusicImporter
  attr_reader :path, :files
  def initialize(path)
    @path = path
    @files = Dir.entries(path).select { |filename| filename.match(/.mp3$/) }
  end

  def import
    self.files.each { |filename| Song.create_from_filename(filename) }  
  end
end