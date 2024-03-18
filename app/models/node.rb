class Node < ApplicationRecord
  has_many :birds, dependent: :destroy
  belongs_to :parent
  has_many :children, class_name: 'Node', foreign_key: 'parent_id', dependent: :destroy
end
