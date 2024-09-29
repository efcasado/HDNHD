defmodule HDNHD.Slack do
  use Slack.Bot

  require Logger

  @yes "white_check_mark"
  @no "x"

  @impl true
  def handle_event("message", %{"subtype" => "file_share", "files" => files} = message, _state) do
    hot_dog = files
    |> Enum.map(&fetch_image(&1["url_private"]))
    |> Enum.any?(&is_hot_dog(&1, Application.get_env(:hdnhd, :threshold)))

    case hot_dog do
      true ->
        add_reaction(message, @yes)
      false ->
        add_reaction(message, @no)
    end

    :ok
  end

  def handle_event(type, payload, _state) do
    Logger.debug("Unhandled #{type} event: #{inspect(payload)}")
    :ok
  end

  defp add_reaction(%{"channel" => channel, "ts" => ts} = _message, reaction) do
    bot_token = Application.get_env(:hdnhd, :bot_token)
    Slack.API.post("reactions.add", bot_token, name: reaction, channel: channel, timestamp: ts)
  end

  defp fetch_image(url) do
    auth_header = {"Authorization", "Bearer #{Application.get_env(:hdnhd, :bot_token)}"}
    %HTTPoison.Response{body: body} = HTTPoison.get!(url, [auth_header])
    body
  end

  defp is_hot_dog(raw_image, threshold) do
    model_name = Application.get_env(:hdnhd, :model_name)
    {:ok, resnet} = Bumblebee.load_model({:hf, model_name})
    {:ok, featurizer} = Bumblebee.load_featurizer({:hf, model_name})
    serving = Bumblebee.Vision.image_classification(resnet, featurizer)

    image = Image.from_binary!(raw_image)
    tensor = Image.to_nx!(image)

    predictions = Nx.Serving.run(serving, tensor).predictions
    Logger.debug("Predictions: #{inspect(predictions)}")
    Enum.find(predictions, fn p -> String.contains?(p.label, "hotdog") && p.score > threshold end)
  end
end
