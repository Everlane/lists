class Item < ActiveRecord::Base

  belongs_to :parent, class_name: 'Item', :foreign_key => 'parent_id'
  has_many :children, class_name: 'Item', :foreign_key => 'parent_id'

  accepts_nested_attributes_for :children

  scope :root, -> {
    where(parent_id: [nil, 0])
  }

  default_scope -> {
    order('position ASC')
  }

  before_create :set_initial_position

  def set_initial_position
    others = parent ? parent.children.count : Item.root.count
    self.position = others + 1
  end

end
