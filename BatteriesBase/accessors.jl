module Accessors

# Should we hook into Unitful.jl?
abstract type Quantity end

abstract type TerminalVoltage{Volt} <: Quantity end

abstract type TerminalCurrent{Amp} <: Quantity end

abstract type Temperature{Kelvin} <: Quantity end


"""
    get(::Quantity, x::SimulationOrExperimentResults)
    get(::Quantity, u::State, p::Parameters, t::Time)
    get(::Quantity, u::State, p::Parameters, e::Exogenous, t::Time)

Return the data for a given symbol for the given arguments. Packages should implement
relevant accessors for their data type using `get` and not via user-centric functions such as
`current` or `voltage`

## Supported Quantities

The following Quantities are "reserved" in that the have defined definitions that packages
should follow for interoperability. For the full list see `subtypes(Quantity)`


## Naming Conventions

The following naming conventions should be used when defining additional symbols

- Use `UpperCamelCase` for
- Prefer a-z
- No acronyms `StateOfHealth` not `SOH`
- Omit units `TerminalVoltage` not `TerminalVoltageV`

Additionally, generic names (i.e. `Temperature`) should be avoided or return generic results
I.e. `Temperature` would return most generic temperature for a input and not "the temperature
of the upper left hand corner"

## Creating User-centric functions with `@accessor`

The @accessor macro can be used to define user-centric functions for a given symbol.
For example, the following will define both `get(:terminal_voltage, args...)` and
`terminal_voltage(args...)`. For more information see [`@accessor`](@ref)

"""
get(::Type{Q}, x) where {Q <: Quantity}= error("get is not implement for $Q")
get(::Type{Q}, u, p, t) where {Q <: Quantity} = get(Q, u, p, nothing, t)


"""
    @accessor function terminal_voltage(args...)...
    @accessor TerminalVoltage args... begin ... end

Macros for defining Quantities and user-centric accessors
"""
accessor(f...) = error("To Do...")
