import Config

config :hdnhd,
  app_token: "<YOUR-SECRET-SLACK-APP-TOKEN>",
  bot_token: "<YOUR-SECRET-SLACK-BOT-TOKEN>",
  bot: HDNHD.Slack,
  channels: [
    types: ["public_channel", "private_channel", "im", "mpim"]
  ],
  #model_name: "microsoft/resnet-50",
  model_name: "google/vit-base-patch16-224",
  threshold: 0.9

config :nx, :default_backend, EXLA.Backend
