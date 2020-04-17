#############################################################################
# Copyright (C) 2017 - 2018  Spine Project
#
# This file is part of Spine Model.
#
# Spine Model is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Spine Model is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
# using JuMP
using SpineModel
# using SpineInterface
# try
#     using Gurobi
# catch
#     using Cbc
# end

# Custom constraint for ramp up and down.
# function constraint_ramping(m::Model)
#     @fetch unit_flow, units_on, units_started_up = m.ext[:variables]
#     cons = m.ext[:constraints][:ramping] = Dict()
#     for (u, n, d) in indices(ramp_up)
#         for (u, n, d) in indices(ramp_down)
#             # ramp_up and ramp_down must be defined together
#             for (u, n, d, t_after) in unit_flow_indices(unit=u, node=n, direction=d)
#                 for (u, n, d, t_before) in unit_flow_indices(
#                     unit=u, node=n, direction=d, t=t_before_t(t_after=t_after))
#                     cons[u, n, d, t_before, t_after] = @constraint(
#                         m,
#                         unit_flow[u, n, d, t_after] - unit_flow[u, n, d, t_before]
#                         # / duration(t_after)
#                         <=
#                         + ramp_up[(unit=u, node=n, direction=d)] * units_on[u, t_before]
#                         + ramp_down[(unit=u, node=n, direction=d)] * units_started_up[u, t_after]
#                     )
#                 end
#             end
#         end
#     end
# end

input_url = "sqlite:///$(@__DIR__)/.spinetoolbox/items/input_db/input_DB.sqlite"
output_url = "sqlite:///$(@__DIR__)/.spinetoolbox/items/output_db/output_DB.sqlite"

m = run_spinemodel(input_url, output_url; cleanup=true)
# optional keywords: with_optimizer=optimizer_with_attributes(Cbc.Optimizer), add_constraints=m->constraint_ramping(m)

# Show active variables and constraints
println("*** Active constraints: ***")
for key in keys(m.ext[:constraints])
    !isempty(m.ext[:constraints][key]) && println(key)
end
println("*** Active variables: ***")
for key in keys(m.ext[:variables])
    !isempty(m.ext[:variables][key]) && println(key)
end

# println("*** Value of variables: ***")
# var = :units_on
# for key in keys(m.ext[:variables][var])
#     !isempty(m.ext[:variables][var][key]) && println(m.ext[:variables][var][key], " = ", SpineModel.value(m.ext[:variables][var][key]))
# end
