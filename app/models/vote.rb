class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :creator, scope: :voteable #prevents creator from voting more than once same as scopte:[:voteable_id, :voteable_type ]
end