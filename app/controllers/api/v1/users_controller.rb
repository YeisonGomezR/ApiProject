module Api
    module V1
      class UsersController < ApplicationController
          def create
            @user = User.new(user_params)
            if @user.save
              render status: :created
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          end

          def user_params
            params.require(:user).permit(:name)
          end

          def index
            @users= User.order('id')
            render json:@users
          end
      end
    end
end