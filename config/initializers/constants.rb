#if Rails.env == "test"
#  USER_COOKIE_DURATION_IN_SECONDS = 10 # 10 seconds
#  VISIT_COOKIE_DURATION_IN_SECONDS = 3 # 3 seconds
#else
  USER_COOKIE_DURATION_IN_SECONDS = 60*60*24*730 # 2 years
  VISIT_COOKIE_DURATION_IN_SECONDS = 60*30 # 30 minutes
#end