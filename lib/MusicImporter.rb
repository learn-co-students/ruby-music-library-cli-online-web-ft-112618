class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries("#{self.path}").select {|f| f.include?(".mp3")}
  end
end
