class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username
  #before_save :generate_slug!
  #
  #def generate_slug!
  #  the_slug = to_slug(self.title)
  #  user = Post.find_by slug: the_slug
  #  count = 2
  #  while user && user != self
  #    the_slug = append_suffix(the_slug, count)
  #    user = Post.find_by slug: the_slug
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