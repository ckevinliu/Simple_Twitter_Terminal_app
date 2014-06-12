class User

  attr_accessor :user_input

  def initialize(user_input)
    @user_input = user_input
  end

  # def check_user(user_input)
  # 	return "Hello, #{user_input}! That's long." if user_input.length >= 10
  # 	return "Hello, #{user_input}!"
  # end
end