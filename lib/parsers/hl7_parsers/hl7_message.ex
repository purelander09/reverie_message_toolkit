defmodule HL7Message do
    defstruct [:MSH, :field_separator, :subfield_separator, :repeat_separator, :version, :message_type, :segments]
end