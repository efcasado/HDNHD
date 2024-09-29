defmodule HDNHD do
  use Application

  def start(_type, _args) do
    children = [{Slack.Supervisor, Application.get_all_env(:hdnhd)}]

    opts = [strategy: :one_for_one, name: HDNHD.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
