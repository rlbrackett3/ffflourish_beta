class FeedbackMessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  
  respond_to :js, :html, :xml, :json
  
  def index
    @title = "feedback"
#    @search_path = feeback_messages_path
    @messages = FeedbackMessage.all
    
   respond_with(@messages) 
    
  end

  def show
    @title = "feedback message"
    @message = FeedbackMessage.find(params[:id])
    
    respond_with(@message)
  end

  def new
    @title = "thank you for your feedback"
    @message = FeedbackMessage.new
  end

  def create
    @user = current_user
    @message = @user.feedback_messages.create(params[:feedback_message])
    if @message.save
      respond_with(current_user, :location => root_path)
    else
      respond_with(@message, :location => new_feedback_message_path)
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    @messages = FeedbackMessage.all.search(params[:search]).desc(:created_at).paginate(:page => params[:page], :per_page => 50)
    @message = FeedbackMessage.find(params[:id])
    @message.destroy
    
    respond_with(@messages)
  end

end
