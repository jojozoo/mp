# Be sure to restart your server when you modify this file.

# Mp::Application.config.session_store :cookie_store, key: '_mp_session', domain: '.mpwang.cn'
Mp::Application.config.session_store :cookie_store, key: '_mp_session', :expire_after => 6.month, domain: '.mpwang.cn' if Rails.env.eql?('production')
Mp::Application.config.session_store :cookie_store, key: '_mp_session', :expire_after => 6.month unless Rails.env.eql?('production')
Rails.application.config.middleware.insert_before(
  ActionDispatch::Session::CookieStore,
  FlashSessionCookieMiddleware,
  Rails.application.config.session_options[:key]
)
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Mp::Application.config.session_store :active_record_store
