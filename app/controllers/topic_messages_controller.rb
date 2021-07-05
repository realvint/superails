class TopicMessagesController < ApplicationController
  before_action :set_topic!

  def create
    @topic_message = @topic.topic_messages.build(topic_message_params)
    @topic_message.user_id = current_user.id
    if @topic_message.save
      redirect_to(topic_path(@topic), notice: 'Message created!')
    else
      redirect_to(topic_path(@topic), alert: 'Message NOT created!')
    end
  end

  def destroy
    topic_message = @topic.topic_messages.find params[:id]
    topic_message.destroy
    redirect_to(topic_path(@topic), notice: 'Message destroy!')
  end

  private

  def set_topic!
    @topic = Topic.find params[:topic_id]
  end

  def topic_message_params
    params.require(:topic_message).permit(:body)
  end
end