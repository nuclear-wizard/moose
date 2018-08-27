# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# XFEM Moving Interface Verification Problem #1.0.0.0.01
# Dimensionality:                                         2D
# Coordinate System:                                      xy
# Material Numbers/Types:   homogeneous 1 material, 1 region
# Element Order:                                         1st
# Companion Problems:                            #1.0.0.0.00
# Transient 2D heat transfer problem in Cartesian coordinates. It was designed
#   using Method of Manufactured Solutions to exactly evaluate the analytical
#   solution.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

[GlobalParams]
  order = FIRST
  family = LAGRANGE
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1
  ny = 1
  xmin = 0.0
  xmax = 1.0
  ymin = 0.0
  ymax = 1.0
  elem_type = QUAD4
[]

[Variables]
  [./u]
  [../]
[]

[Kernels]
  [./heat_cond]
    type = HeatConduction
    variable = u
  [../]
  [./vol_heat_src]
    type = BodyForce
    variable = u
    function = src_func
  [../]
  [./mat_time_deriv]
    type = MatTimeDerivative
    variable = u
    mat_prop_value = rhoCp
  [../]
[]

[Functions]
  [./src_func]
    type = ParsedFunction
    value = '10*(-100*x-100*y+200)'
  [../]
  [./neumann_func]
    type = ParsedFunction
    value = '1.5*100*t'
  [../]
  [./dirichlet_right_func]
    type = ParsedFunction
    value = '(-100*y+100)*t+400'
  [../]
  [./dirichlet_top_func]
    type = ParsedFunction
    value = '(-100*x+100)*t+400'
  [../]
[]

[Materials]
  [./mat_time_deriv_prop]
    type = GenericConstantMaterial
    prop_names = 'rhoCp'
    prop_values = 10
  [../]
  [./therm_cond_prop]
    type = GenericConstantMaterial
    prop_names = 'diffusion_coefficient'
    prop_values = 1.5
  [../]
[]

[BCs]
  [./left_du]
    type = FunctionNeumannBC
    variable = u
    boundary = 'left'
    function = neumann_func
  [../]
  [./right_u]
    type = FunctionDirichletBC
    variable = u
    boundary = 'right'
    function = dirichlet_right_func
  [../]
  [./bottom_du]
    type = FunctionNeumannBC
    variable = u
    boundary = 'bottom'
    function = neumann_func
  [../]
  [./top_u]
    type = FunctionDirichletBC
    variable = u
    boundary = 'top'
    function = dirichlet_top_func
  [../]
[]

[ICs]
  [./u_ic]
    type = ConstantIC
    value = 400
    variable = u
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'
  # petsc_options_iname = '-pc_type -pc_hypre_type'
  # petsc_options_value = 'hypre boomeramg'
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  line_search = 'none'

  l_tol = 1.0e-6
  nl_max_its = 15
  nl_rel_tol = 1.0e-10
  nl_abs_tol = 1.0e-9

  start_time = 0.0
  dt = 0.1
  end_time = 2.0
  # max_xfem_update = 1
[]

[Outputs]
  interval = 1
  execute_on = 'initial timestep_end'
  exodus = true
  [./console]
    type = Console
    output_linear = true
  [../]
[]
