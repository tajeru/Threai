require_relative '../services/chat_gpt_client'

class PostsController < ApplicationController
  before_action :set_current_user, :redirect_root 
  before_action :posts_index
  def index
   
  end

  def create
    @content = params[:content]
    @post = Post.new(content: params[:content], user_id: session[:user_id])
  if @content != nil
    if @post.save
      api_key = ENV['CHAT_GPT_API_KEY']
      client = ChatGptClient.new(api_key)
      @question = params[:content] + "また300文字以内に要約してください。"
      puts @question
      @answer = client.ask_question(@question)

      if @answer && @answer["choices"]
        reply_content = @answer["choices"].first["message"]["content"]
        reply = Reply.new(content: reply_content, user_id: 2, post_id: @post.id)
        if reply.save
          redirect_to ("/posts/index")
        else
          flash[:error] = "Reply could not be saved."
          redirect_to ("/posts/index")
        end
      else
        flash[:error] = "No response from ChatGPT."
        redirect_to ("/posts/index")
      end
    else
      flash[:error] = "適切に投稿できませんでした。"
      redirect_to("/posts/index")
    end
  else
    flash[:error] = "内容が空です。"
    redirect_to ("/posts/index")
  end
  end

  def reply
    reply = Reply.new(content: params[:content], user_id: session[:user_id], post_id: params[:post_id])
    if reply.save
      redirect_to ("/posts/index")
    else
      flash[:error] = "返信を送信できませんでした。"
      redirect_to ("/posts/index") # または適切なエラーハンドリング
    end
  end

  
  

def destroy
  @post = Post.find_by(id: params[:id])
  
  # 削除権限の確認
  if @post && (@current_user.id == @post.user_id || @current_user.id == 3)
    @post.destroy
    flash[:notice] = '投稿は削除されました。'
    redirect_to("/posts/index")
  else
    flash[:error] = "削除する権限がありません。"
  end
  
  redirect_to("/posts/index")
end 

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_root
    if @current_user.nil?
      redirect_to("/")
    end
  end

def posts_index
   @posts = Post.includes(:user, :replies).all.order(created_at: :desc)
end

end