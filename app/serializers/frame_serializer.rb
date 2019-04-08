class FrameSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :bikes
end
