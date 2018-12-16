module Concerns::Editable

  def destroy_all
    self.all.clear
  end
end
