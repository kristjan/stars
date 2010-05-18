class UserSession < Authlogic::Session::Base
  facebook_skip_new_user_creation true
end
