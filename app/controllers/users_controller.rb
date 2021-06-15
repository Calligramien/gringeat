class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:avatar)
  end

@user.avatar.attached? #=> true/false
@user.avatar.purge #=> Destroy the avatar
end
