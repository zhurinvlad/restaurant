require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurants" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: {restaurants: {addres: @restaurant.addres, description: @restaurant.description, image: @restaurant.image, lat: @restaurant.lat, lng: @restaurant.lng, name: @restaurant.name } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurants" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurants" do
    patch restaurant_url(@restaurant), params: {restaurants: {addres: @restaurant.addres, description: @restaurant.description, image: @restaurant.image, lat: @restaurant.lat, lng: @restaurant.lng, name: @restaurant.name } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurants" do
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end
end
