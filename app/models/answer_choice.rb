# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  text        :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswerChoice < ActiveRecord::Base
  validates :text, presence: true
  validates :question_id, presence: true

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :respondent,
    through: :responses,
    source: :respondents

end
