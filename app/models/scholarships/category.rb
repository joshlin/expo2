class Category < ActiveRecord::Base
  establish_connection "uso_#{Rails.env}".to_sym
  
  has_many :scholarship_category
  
  validates_presence_of :name
  
  default_scope { order('name') }
  
  # Alias for #name
  def title
    name
  end
  
end