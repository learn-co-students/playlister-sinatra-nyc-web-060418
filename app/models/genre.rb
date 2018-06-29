class Genre < ActiveRecord::Base

  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs
  def slug
    name_array = self.name.split
    slug_name = name_array.join("-")
    slug_name.downcase
  end

  def self.find_by_slug(slug)
    Genre.all.find {|genre| genre.slug == slug}
  end
end
