class RestaurantsController < ApplicationController


  def fetch
    # set up yelp API
    params = {term: 'lunch large groups',  is_closed: false}
    coord = {latitude: current_user.latitude, longitude: current_user.longitude}

    # this is where the chosen suggestions will land in
    @eateries = []

    # I know ruby arrays are not thread safe but this will have to do,
    # Since yelp api calls only return 20 results I call 3 threads that
    # will hit the yelp API and return results 0-59 for the term "lunch large groups"
    t0 = Thread.new { @eateries << get_places_to_eat(0, params, coord)}
    t1 = Thread.new { @eateries << get_places_to_eat(1, params, coord)}
    t2 = Thread.new { @eateries << get_places_to_eat(2, params, coord)}
    t0.join
    t1.join
    t2.join

    @eateries.flatten!
    @eateries.shuffle!

    # for now return 5 of of the randomized eateries
    @eateries = @eateries[0..4]
  end

  def fetch_custom_city
    @custom_city = params[:custom_city]
  end



  private

  def get_places_to_eat(offset, params, coord)
    params[:offset] = 20 * offset
    Yelp.client.search_by_coordinates(coord, params).businesses
  end

end
