# frozen_string_literal: true

# Application record base and abstract class. It is used as parent class for each model.
# It will make possible use Rails ORM.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
