module Concerns::Editable
  def create(name)
    self.new(name).tap { |obj| obj.save }
  end

  def destroy_all
    self.all.clear
  end
end
