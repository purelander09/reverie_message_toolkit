defmodule ReverieMessageToolkit.HL7GenericParser do
    @moduledoc """
    """

    @behaviour Parser

    @impl Parser
    def parse(message) do
        segments = String.split(message, "\r")

        msh_segments = Enum.filter(segments, fn x -> String.slice(x, 0..2) == "MSH" end)
        msh = Enum.fetch(msh_segments, 0) # we have to have an MSH segment, it is appropriate to raise an exception

        # Now grab separators
        field_separator = String.at(msh, 3)
        subfield_separator = String.at(msh, 4)
        repeat_separator = String.at(msh, 5)

        msh_data = parse_msh(msh, field_separator)
        segment_map = parse_segments(segments, field_separator, subfield_separator, repeat_separator)

        version = Map.get(msh_data, :version)
        message_type = Map.get(msh_data, :message_type)

        # Now return our message
        %HL7Message{
            MSH: msh,
            field_separator: field_separator,
            subfield_separator: subfield_separator,
            repeat_separator: repeat_separator,
            segments: segments,
            version: version,
            message_type: message_type
        }
    end

    defp parse_msh(msh_segment, field_separator) do
        pieces = String.split(msh_segment, field_separator)

        # MSH is positional (all HL7 is) so we use the positions to grab this data
        message_type = Enum.at(pieces, 7, "")
        version = Enum.at(pieces, 10, "")

        # Now return the MSH information
        %{:message_type => message_type, :version => version}
    end

    defp parse_line(segment, field_separator, subfield_separator, repeat_separator) do
        fields = String.split(segment, field_separator)
        fields
    end

    defp parse_segments(segments, field_separator, subfield_separator, repeat_separator) do
        Enum.map(segments, fn x -> parse_line(x, field_separator, subfield_separator, repeat_separator) end)
    end

    @impl Parser
    def mime_type() do
        "x-application/hl7-v2+er7"
    end

    @impl Parser
    def extension() do
        ["hl7"]
    end

    @impl Parser
    def message_formats() do
        ["HL7"]
    end
end