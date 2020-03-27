# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  chirp_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord
  validates :chirp_id, uniqueness: { scope: :user_id }

  belongs_to :chirp,
    primary_key: :id,
    foreign_key: :chirp_id,
    class_name: :Chirp
    
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User 
  
end
