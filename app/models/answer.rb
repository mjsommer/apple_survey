class Answer < ApplicationRecord
  belongs_to :survey

  def self.result_percentage(survey_id, response)
    total = Answer.where(survey_id: survey_id).count()
    count = Answer.where(survey_id: survey_id, response: response).count()
    (count.to_f / total.to_f).round(2) * 100
  end
end
