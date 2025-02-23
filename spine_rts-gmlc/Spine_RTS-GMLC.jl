#############################################################################
# Copyright (C) 2017 - 2018  Spine Project
#
# This file is part of SpineOpt.
#
# SpineOpt is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SpineOpt is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
# using JuMP
using SpineOpt
# using SpineInterface
# try
#     using Gurobi
# catch
#     using Cbc
# end

input_url = "sqlite:///$(@__DIR__)/datasets/input_DB.sqlite"
output_url = "sqlite:///$(@__DIR__)/datasets/output_DB.sqlite"

m = run_spineopt(input_url, output_url; cleanup=true, optimize=true)
# optional keywords: with_optimizer=optimizer_with_attributes(Cbc.Optimizer), add_constraints=m->constraint_ramping(m)
# execute with full address: include("C:\\HJY_projects\\spine\\RTS-GMLC_system_test\\spinetoolbox_rts-gmlc\\spine_rts-gmlc\\Spine_RTS-GMLC.jl")
# execute with relative address: include("..\\spine\\RTS-GMLC_system_test\\spinetoolbox_rts-gmlc\\spine_rts-gmlc\\Spine_RTS-GMLC.jl")

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

# access defined object and parameters
## demand(node = node_group__node()[1][:node1], t = time_slice()[1])
## demand(node=node()[first(findall(n->n.name == :node_name_here/Symbol("node_name_here"), node()))])

## key = m.ext[:constraints][:constraint_name].keys[3] - including undef keys
## keys(m.ext[:constraints][:constraint_name]) can avoid undef keys
## m.ext[:constraints][:constraint_name][key]

## node_group__node()[1][:node1]
## fractional_demand[(node1=node_group__node()[1][:node1], node2=node_group__node()[1][:node2],t = time_slice()[1])]

## m.ext[:objective_terms]
