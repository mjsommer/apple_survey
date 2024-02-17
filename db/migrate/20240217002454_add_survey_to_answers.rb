class AddSurveyToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_reference :answers, :survey, null: false, foreign_key: true
  end
end
