class Item < ActiveRecord::Base

  belongs_to :parent, class_name: 'Item', :foreign_key => 'parent_id'
  has_many :children, class_name: 'Item', :foreign_key => 'parent_id'

  accepts_nested_attributes_for :children

  scope :root, -> {
    where(parent_id: nil)
  }

  default_scope { order :position }
  def serialize
    to_json
  end

end
