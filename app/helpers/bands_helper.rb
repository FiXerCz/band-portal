module BandsHelper
  def get_all_genres
    Genre.all.order(:title)
  end
end
