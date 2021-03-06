class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}

  sluggable_column :name
  #before_save :generate_slug!
  #
  ##def generate_slug
  ##  self.slug = self.name.gsub(' ','-').downcase
  ##end
  #def generate_slug!
  #  the_slug = to_slug(self.title)
  #  category = Post.find_by slug: the_slug
  #  count = 2
  #  while category && category != self
  #    the_slug = append_suffix(the_slug, count)
  #    category = Post.find_by slug: the_slug
  #    count += 1
  #  end
  #  self.slug = the_slug.downcase
  #end
  #
  #def append_suffix(str, count)
  #  if str.split('-').last.to_i != 0
  #    str.split('-').slice(0...-1).join('-') + '-' + count.to_s
  #  else
  #    str + '-' + count.to_s
  #  end
  #end
  #
  #def to_slug(name)
  #  str = name.strip
  #  str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
  #  str.gsub! /-+/, '-'
  #  str.downcase
  #end
  #
  #def to_param
  #  self.slug
  #end
end