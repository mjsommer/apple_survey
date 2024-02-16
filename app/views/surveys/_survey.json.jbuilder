json.extract! survey, :id, :question, :created_at, :updated_at
json.url survey_url(survey, format: :json)
