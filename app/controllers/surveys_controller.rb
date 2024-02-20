class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show ]

  # GET /surveys or /surveys.json
  def index
    @survey_stats = []
    @surveys = Survey.all

    @surveys.each_with_index do |survey, i|
      stats = {}
      stats[:survey] = survey
      stats[:question] = survey.question
      stats[:count] = survey.answers.count()
      stats[:yes] = result_percentage(survey.id, 1)
      stats[:no] = result_percentage(survey.id, 0)
      @survey_stats << stats
    end
  end

  def result_percentage(survey_id, response)
    total = Answer.where(survey_id: survey_id).count()
    count = Answer.where(survey_id: survey_id, response: response).count()
    (count.to_f / total.to_f).round(2) * 100
  end

  # GET /surveys/1 or /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # POST /surveys or /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to survey_url(@survey), notice: "Survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def survey_params
      params.require(:survey).permit(:question)
    end
end
