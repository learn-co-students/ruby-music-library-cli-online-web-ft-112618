# Defines a module named Concerns::Findable
module Concerns
  module Findable
    # .find_by_name is added as a class method to classes 
    # that extend the module.
    # Isn't hard-coded.
    # works exactly like a generic version of
    # Song.find_by_name.
    # Searching the extended class's @@all variable for an
    # instance that matches the provided name.
    def find_by_name(name)
      classInstance = nil
      self.all.each {|instance|
        if (instance.name == name)
          classInstance = instance
        end
      }
      classInstance
    end
    
    # .find_or_create_by_name is added as a class method to 
    # classes that extend the module.
    # Works exactly like a generic version of Song.find_
    # or_create_by_name: finds (does not recreate) an
    # existing intance with the provided name if one exists
    # in @@all.
    # Isn't hard-coded
    # Invokes .find_by_name instead of re-coding the same
    # functionality.
    # Invokes the extended class's .create method, passing in
    # the provided name, if an existing match is not found.
    def find_or_create_by_name(name)
      classInstance = self.find_by_name(name)
      if classInstance == nil
        classInstance = self.create(name)
      end
      classInstance
    end
  end
  
end
