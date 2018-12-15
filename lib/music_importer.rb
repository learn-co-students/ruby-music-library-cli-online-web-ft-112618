class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.glob("#{@path}/*").map do |file|
      file.gsub("#{@path}/", "")
    end
  end

  def self.import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
