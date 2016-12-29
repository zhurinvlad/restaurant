class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :addres, :lat, :lng, :image
end
