# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  author_id  :integer          not null
#  chirp_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :body, presence: true
  validate :too_long

  def too_long
    if body && body.length > 140
      errors[:body] << 'too long'
    end
  end

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  belongs_to :chirp,
    primary_key: :id,
    foreign_key: :chirp_id,
    class_name: :Chirp
end
