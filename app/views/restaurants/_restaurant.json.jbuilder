json.extract! restaurant, :id, :name, :description, :addres, :lat, :lng, :image, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)