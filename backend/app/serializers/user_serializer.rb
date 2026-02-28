class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :point, :level, :experience_point, :status
  has_many :todos
  has_many :rewards
end
