Twitter.configure do |config|
  config.consumer_key = "xoiz1obGbJCgOTGCM28lmlDtD"
  config.consumer_secret = "VqYwnu5BXuIObIxuPxnAaxc2vA4eogggKdlACgaDTHM0i8TEJI"
  config.oauth_token = "3094789293-rvThm7aHdDJN55i7OI0xNAg5JEwsLn6IiqAqMJZ"
  config.oauth_token_secret = "DtRg1rr3NcA99r8KaZtQIiiMaRRaGdy2DW0zzMb2h5dHJ"
  config.connection_options = Twitter::Default:: CONNECTION_OPTIONS.merge(:request => { 
    :open_timeout => 10,
    :timeout => 20
  })
end