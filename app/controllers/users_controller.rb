class UsersController < ApplicationController

# @user.avatar.attached? #=> true/false
# @user.avatar.purge #=> Destroy the avatar
def index
    @user = User.find(current_user.id)
end
  
def user_params
    params.require(:user).permit(:avatar)
end
end
