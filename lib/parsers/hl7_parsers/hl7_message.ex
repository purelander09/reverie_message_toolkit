defmodule HL7Message do
    @typedoc """
    Generic structure of an HL7 message
    """
    defstruct [:MSH, :field_separator, :subfield_separator, :repeat_separator, :version, :message_type, :segments]
end