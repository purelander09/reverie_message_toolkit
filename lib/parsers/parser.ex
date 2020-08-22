defmodule Parser do
    @moduledoc """
    Parser Behaviour that allows different message parsers to support parsing messages.
    """

    @typedoc """
    """
    @type msg_structure :: {term}

    @callback parse(String.t) :: {:ok, msg_structure} | {:error, String.t}
    @callback mime_type() :: String.t
    @callback extension() :: [String.t]
    @callback message_formats() :: [String.t]

    @doc """
        Can be used to call parse on any message format that is currently implemented or available.

        Should only be used by the parsers in this application.

        All outside parsers should use their gen_server methods to call their parse method.
    """
    def parse!(implementation, message) do
        case implementation.parse(message) do
            {:ok, data} -> data
            {:error, error} ->
                raise ArgumentError, "parsing error: #{error}"
        end
    end
end