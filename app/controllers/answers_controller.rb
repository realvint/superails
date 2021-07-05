class AnswersController < ApplicationController
  before_action :set_question!

  def create
    @answer = @question.answers.build answer_params
    if @answer.save
      redirect_to(question_path(@question), notice: 'Answer created!')
    else
      redirect_to(question_path(@question), notice: 'Answer NOT created!')
    end
  end

  def destroy
    answer = @question.answers.find params[:id]
    answer.destroy
    redirect_to(question_path(@question), notice: 'Answer destroy!')
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end
end
