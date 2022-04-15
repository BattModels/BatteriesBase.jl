
"""
p::Parameters{T} = model_name(args...)

Packages are expected to provide some function that returns the model parameters for an
Electrical Energy Storage Device (EESD) model.

"""
module ElectricalEnergyStorageDevices

abstract type AbstractState end
const State = Union{Any, AbstractState}

abstract type AbstractParameters end
const Parameters = Union{Any, AbstractParameters}

abstract type AbstractExogenous end
const Exogenous = Union{Any, Nothing, AbstractExogenous}

"""
    du = dudt(du, u::State, p::Parameters, e::Exogenous)
    dudt!(du, u::State, p::Parameters, e::Exogenous)

Represent the dynamics of an EESD using an ordinary differential equation

"""
dudt(u::State, p::Parameters, e::Exogenous, t) = error()
dudt!(du, u::State, p::Parameters, e::Exogenous, t) = error()

"""
    resid = dae(du, u::State, p::Parameters, e::Exogenous)
    dae!(residm u::State, p::Parameters, e::Exogenous)

Represent the dynamics of an EESD using a differential algebraic equation (DAE)

"""
dae(du, u::State, p::Parameters, e::Exogenous, t) = error()
function dae!(resid, du, u::State, p::Parameters, e::Exogenous, t)
    v = get(TerminalVoltage)

"""
    sol = solve(u::State, p::Parameters, e::Exogenous, tspan=(0, 1);
        saveat=[], trace_vars=Quantity[],
        args...
    )

Given an initial state `u`, model parameters `p`, and exogenous inputs `e`, simulate the
EESD model for the given time span `tspan`

- `saveat` save the model state `u` at each time step listed in `saveat`
- `trace_vars` request that the provided Quantity are saved in the returns `sol`
    - If any `trace_vars` is unsupported, a `ValueError` is raised
    - `sol` may contain additional fields that are not `trace_vars`, but must contain sufficient
      information to compute `trace_vars .|> q -> get(q, sol)`
- `args...` additional arguments to pass to the solver

Packages should provide this function if that wish to expose their internal simulation routines
to the user. Packages are strongly encouraged to provide `dudt`, `dudt!`, `dae` or `dae!` functions
that describe their model as well.
"""
solve(u::State, p::Parameters, e::Exogenous; args...) = error()
solve(u::State, p::Parameters; args...) = solve(u, p, nothing, args...)
