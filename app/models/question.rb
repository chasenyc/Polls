# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  has_one :author,
    through: :poll,
    source: :author

  def n_plus_one_results
    responses = self.responses
    results = Hash.new(0)
    responses.each do |response|
      results[response.answer_choice.text] += 1
    end

    results
  end

  def better_but_not_best_results
    answers = self.answer_choices.includes(:responses)
    results = {}
    answer_choices.each do |answer|
      results[answer.text] = answer.responses.length
    end

    results
  end

  def results
    answers = self.answer_choices
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .group("answer_choices.text")
      .count
  end

end
