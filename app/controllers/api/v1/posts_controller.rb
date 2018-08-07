module Api
    module V1
      class PostsController < ApplicationController
        include ActionController::HttpAuthentication::Token::ControllerMethods
        before_action :authenticate, only: [:create, :destroy]

        def index
          @posts= Post.order('created_at DESC')
          render json:@posts
        end

        def destroy
            @post = @user.posts.find_by(delete_params)
            if @post
              @post.destroy
            else
              render json: {post: "No fue Encontrado el Id"}, status: :not_found
            end
        end

        def create
            @post = @user.posts.new(post_params)
            if @post.save
                render json: @post, status: :created
            else
                render json: @post.errors, status: :unprocessable_entity
            end
        end

      def show
          @posts=Post.find(params[:id])          
          if @posts
              render json: @posts
          else
              render json: {post: "No fue Encontrado el Id"}, status: :not_found
          end
      end

      def update          
          @posts=Post.find(params[:id])
          if @posts 
            if @posts.update(post_params)
                  render json: @posts
            end
          else
              render json: {post: "No fue Encontrado el Id"}, status: :not_found
        
          end
      end

      private
            def authenticate
                authenticate_or_request_with_http_token do |token, options|
                @user = User.find_by(token: token)
                end 
            end

            def post_params
                    params.require(:post).permit(:title,:body)
            end

            def postUpdate_params
                    params.require(:post).permit(:id,:title,:body)
            end
            
            def delete_params
                    params.require(:post).permit(:id)
            end
          
      end
    end
  end