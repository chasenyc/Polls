# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true

  belongs_to
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_many
    :respondents,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
    
end
