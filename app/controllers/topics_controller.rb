class TopicsController < ApplicationController
  before_action :set_topic, only: %i[show edit update destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic_message = @topic.topic_messages.build
    @topic_messages = @topic.topic_messages.order created_at: :desc
  end

  def new
    @topic = Topic.new
  end

  def edit; end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_url, notice: 'Обсуждение сохранено.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_url, notice: 'Обсуждение сохранено.' }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
    end
  end


  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name)
  end


end
