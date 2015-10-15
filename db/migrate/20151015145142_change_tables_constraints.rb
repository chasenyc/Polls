class ChangeTablesConstraints < ActiveRecord::Migration
  def change
    change_column :users, :user_name, :string, unique: true, null: false

    change_column_null :polls, :title, false
    change_column_null :polls, :author_id, false
    change_column_null :questions, :text, false
    change_column_null :questions, :poll_id, false
    change_column_null :answer_choices, :text, false
    change_column_null :answer_choices, :question_id, false
    change_column_null :responses, :user_id, false
    change_column_null :responses, :answer_choice_id, false
  end
end
