module TraceInterface

"""
    Trace

A `Trace` represents a time varying quantity and is expected to implement the following methods

- `getindex(::Trace, i)`
- `(::Trace)(t)`
- AbstractArray Interface
- Iteration Interface
"""
abstract type Trace end

"""
    getindex(x::Trace, i)

Return the value of the trace at timestep `i`. Interpolation is not expected for `i <: Integer`
"""
getindex(::Trace, i) = error("getindex is not implemented")

"""
    (x::Trace)(t)

Return the value of the trace at time `t`. Sane interpolation is expected
"""
(::Trace)(t) = error("not defined")

"""
    size(x::Trace)
    size(x::Trace, i)

Returns the size of the trace. Time is expected to be the trailing dimension
"""

# Rest of AbstractArray Interface...

# Rest of Iteration Interface...

"""
     MLUtils.numobs(::Trace)

Return the number of observations in the trace
"""
MLUtils.numobs(x::Trace) = last(size(::Trace))

# Rest of MLUtils Interface with default methods using the AbstractArray / Iteration Interface

end
