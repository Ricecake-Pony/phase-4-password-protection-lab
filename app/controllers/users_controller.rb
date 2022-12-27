class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def show
        user = User.find_by(id: session[:user_id])
        render json: user
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

private 

def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
end

#

def user_params
    params.permit(:username, :password, :password_confirmation)
end
# Why do we need these params? I thought since it's not on the table ophhhh because something gives us the password and password confirmation attrs because we shouldnt be using password_digest of course.
end
