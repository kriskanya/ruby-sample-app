module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token  # create a new token
    cookies.permanent[:remember_token] = remember_token  # place the raw token in the browser cookies
    # 'permanent' causes the default setting to be 20 years until the cookie expires
    user.update_attribute(:remember_token, User.digest(remember_token)) # save the hashed token to the database
      # the update_attribute above allows us to save the token attribute while bypassing the other user validations---
      # since we don't have the user's password or confirmation
    self.current_user = user  # set the current user equal to the given user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user  # this simply defines a method 'current_user=' expressly designed to handle assignment to 'current_user'
    # this means that 'self.current_user...' gets converted to current_user=(...)
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))  # change the user's remember token in the databse, in case it's been stolen
    cookies.delete(:remember_token)  # remove the remember token from the session
    self.current_user = nil
  end
end
