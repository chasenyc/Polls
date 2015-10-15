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
require 'byebug'

class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_be_author


  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_many :respondents,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    if self.id.nil?
      question.responses
    else
      question.responses.where("responses.id != ?", self.id)
    end
  end

  def poll
    question.poll
  end

  private

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:response] << "can't already exist"
    end
  end

  def respondent_cannot_be_author
    if poll.author_id == self.user_id
      errors[:response] << "can't be author of poll"
    end
  end

end
