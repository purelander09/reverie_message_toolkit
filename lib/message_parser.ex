defmodule ReverieMessageToolkit.MessageParser do
    use GenServer

    @impl true
    def init(:ok) do
        {:ok, %{}}
    end

    @impl true
    def handle_call({:parse, parser, message}, _from, message) do
        case {:parse, parser, message} do
            {:parse, :hl7_generic, message} -> {:reply, ReverieMessageToolkit.HL7GenericParser.parse(message), message}
            {:parse, :hl7, message} -> {:reply, ReverieMessageToolkit.HL7GenericParser.parse(message), message}
            _ -> {:reply, :error}
        end
    end
end