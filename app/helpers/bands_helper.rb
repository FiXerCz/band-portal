module BandsHelper
  def get_all_genres
    Genre.all.order(:title)
  end

  def get_random_bands(n = 2)
    Band.limit(n.to_i).order("RANDOM()")
  end
end
