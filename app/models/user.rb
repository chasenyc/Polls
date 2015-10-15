# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true

  has_many :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id

  has_many :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id

  has_many :answer_choices,
    through: :responses,
    source: :answer_choice

  def completed_polls
    Poll.all
        .joins(:questions)
        .joins('JOIN answer_choices ON answer_choices.question_id = questions.id')
        .joins("LEFT OUTER JOIN
          (SELECT
            responses.*
          FROM
            responses
          WHERE
            user_id = 2
          ) AS user_responses")
        .group(:polls)
        .having('COUNT(user_responses.user_id) = COUNT(DISTINCT(questions.id))')

  end
end
