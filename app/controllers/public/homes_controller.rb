class Public::HomesController < ApplicationController

  def top
    @rest = Rest.new
    
  if Rails.env.development?
    @random_rests = Rest.order("RANDOM()").limit(3)
  else
    @random_rests = Rest.order("RAND()").limit(3)
  end
  end

  def about
  end

end
