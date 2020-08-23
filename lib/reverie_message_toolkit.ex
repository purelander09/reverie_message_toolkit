defmodule ReverieMessageToolkit do
  @moduledoc """

  """
  use Application

  @impl true
  def start(_type, _args) do
    ReverieMessageToolkit.Supervisor.start_link(name: ReverieMessageToolkit.Supervisor)
  end
end
