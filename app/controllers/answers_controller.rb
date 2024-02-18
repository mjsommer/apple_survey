class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show ]

  # GET /answers or /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1 or /answers/1.json
  def show
  end

  # POST /answers or /answers.json
  def create
    @answer = Answer.new(survey_id: params[:survey_id], response: params[:response])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to root_url, notice: "Answer was successfully recorded." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def result_percentage(survey, answer)
    total = survey.answers.count
    count = survey.answers.where(response: answer).count
    (count.to_f / total.to_f * 100).round(2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:survey_id, :response)
    end
end
