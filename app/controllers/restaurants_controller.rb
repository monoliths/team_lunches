class RestaurantsController < ApplicationController
  before_action :logged_in?

  def fetch
    # set up yelp API
    params = {term: 'lunch large groups',  is_closed: false}
    coord = {latitude: current_user.latitude, longitude: current_user.longitude}

    # this is where the chosen suggestions will land in
    @eateries = get_restaurants(params, coord)
  end

  def fetch_custom_city
    if params[:custom_city].blank? or params[:custom_city].length > 50
      flash[:error] = "Please provide a valid city to search"
      redirect_to root_path and return
    end

    city = Geocoder.coordinates(params[:custom_city])
    # set up yelp API
    params = {term: 'lunch large groups',  is_closed: false}
    coord = {latitude: city[0], longitude: city[1]}

    # this is where the chosen suggestions will land in
    @eateries = get_restaurants(params, coord)
  end
  private

  def get_restaurants(params, coord)
    # this is where the chosen suggestions will land in
    businesses = []

    # if any of the params are not preset simply return the empty array
    unless params or coord
      return businesses
    end

    # I know ruby arrays are not thread safe but this will have to do,
    # Since yelp api calls only return 20 results I call 3 threads that
    # will hit the yelp API and return results 0-59 for the term "lunch large groups"
    t0 = Thread.new { businesses << get_businesses(0, params, coord)}
    t1 = Thread.new { businesses << get_businesses(1, params, coord)}
    t2 = Thread.new { businesses << get_businesses(2, params, coord)}
    t0.join
    t1.join
    t2.join

    businesses.flatten!
    businesses.shuffle!

    # for now return 5 of of the randomized eateries
    businesses[0..4]
  end

  def get_businesses(offset, params, coord)
    params[:offset] = 20 * offset
    Yelp.client.search_by_coordinates(coord, params).businesses
  end

  def logged_in?
    unless current_user
      flash[:notice] = "Please login or signup!"
      redirect_to root_path and return
    end
  end

end
