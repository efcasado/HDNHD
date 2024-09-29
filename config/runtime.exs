import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

if slack_app_token = System.get_env("SLACK_APP_TOKEN") do
  config :hdnhd, app_token: slack_app_token
end

if slack_bot_token = System.get_env("SLACK_BOT_TOKEN") do
  config :hdnhd, bot_token: slack_bot_token
end
