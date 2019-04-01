class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :rating, :comment, :updated_at
end
