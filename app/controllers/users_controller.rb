class UsersController < ApplicationController



@user.avatar.attached? #=> true/false
@user.avatar.purge #=> Destroy the avatar
end
