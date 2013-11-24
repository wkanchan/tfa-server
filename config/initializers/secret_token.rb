# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
TfaServer::Application.config.secret_key_base = 'c7a460124bd72b98c15feb357f6246ce7f860f0e22cd80ce865ddc284af5887e9b5ef195e6334017a2b2f667ae350c5d951deb102cd86ef629449dec608e5b98'
