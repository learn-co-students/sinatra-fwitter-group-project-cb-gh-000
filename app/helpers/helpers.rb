class Helpers
    def self.current_user(session)
      @user = User.find_by_id(session[:user_id])
      # current_user = @user.id
    end

    def self.is_logged_in?(session)
      !!session[:user_id]
    end

    def self.delete_spaces(str)
      str.split.delete_if {|letter| letter == " "}.join
    end
end
