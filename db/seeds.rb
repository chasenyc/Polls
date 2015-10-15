# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

("a".."f").each { |letter| User.create!(user_name: letter) }

User.all.each_with_index { |user, i| Poll.create!(title: i.to_s, author_id: user.id)}

qs = ["what?", "where?", "when?", "who?", "why?", "how?"]

Poll.all.each_with_index do |poll, i|
  Question.create!(text: qs[i], poll_id: poll.id)
end

Question.all.each_with_index do |question, i|
  AnswerChoice.create!(text: "Justin", question_id: question.id)
  AnswerChoice.create!(text: "Alex", question_id: question.id)
end

Question.all.each do |question|
  User.all.each do |user|
    Response.create!(user_id: user.id, answer_choice_id: question.answer_choices.sample.id)
  end
end
