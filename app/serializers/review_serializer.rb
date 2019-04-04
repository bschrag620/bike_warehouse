class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :username, :rating, :comment, :updated_at

  belongs_to :frame
end
