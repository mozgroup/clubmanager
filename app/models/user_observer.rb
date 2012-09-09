class UserObserver < ActiveRecord::Observer
  def before_save(user)
    UserMailer.password_reset(user).deliver if user.password_reset_token_changed?
  end
end
