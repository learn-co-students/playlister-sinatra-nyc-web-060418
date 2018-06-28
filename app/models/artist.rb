require 'pry'
class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    name_array = self.name.split
    slug_name = name_array.join("-")
    slug_name.downcase
  end

  def self.find_by_slug(slug)
    Artist.all.find {|artist| artist.slug == slug}
  end
end
