class RestaurantsController < ApplicationController
  def fetch
    @eateries = Yelp.client.search(current_user.city, { term: 'food',  is_closed: false})
  end
end
