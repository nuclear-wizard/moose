//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef ADDGKERNEL_H
#define ADDGKERNEL_H

#include "DGKernel.h"

#include "metaphysicl/numberarray.h"
#include "metaphysicl/dualnumber.h"

#define usingKernelMembers                                                                         \
  using ADDGKernel<compute_stage>::_test;                                                            \
  using ADDGKernel<compute_stage>::_qp;                                                              \
  using ADDGKernel<compute_stage>::_i;                                                               \
  using ADDGKernel<compute_stage>::_u;                                                               \
  using ADDGKernel<compute_stage>::_var;                                                             \
  using ADDGKernel<compute_stage>::_grad_test;                                                       \
  using ADDGKernel<compute_stage>::_grad_u

template <ComputeStage compute_stage>
class ADDGKernel;

declareADValidParams(ADDGKernel);

template <ComputeStage compute_stage>
class ADDGKernel : public DGKernel
{
public:
  ADDGKernel(const InputParameters & parameters);

  virtual ~ADDGKernel();

  // See KernelBase base for documentation of these overridden methods
  virtual void computeResidual() override;
  virtual void computeJacobian() override;
  virtual void computeOffDiagJacobian(unsigned int jvar) override;
  virtual void computeElemNeighJacobian(Moose::DGJacobianType type) override;
  virtual void computeOffDiagElemNeighJacobian(Moose::DGJacobianType type, unsigned int jvar) override;

  virtual MooseVariable & variable() override { return _var; }
protected:
  /// Compute this Kernel's contribution to the residual at the current quadrature point
  virtual ADResidual computeADQpResidual(Moose::DGResidualType type) = 0;

  /// the current test function
  const ADVariableTestValue & _test;

  /// gradient of the test function
  const ADVariableTestGradient & _grad_test;

  /// Holds the solution at current quadrature points
  const ADVariableValue & _u;

  /// Holds the solution gradient at the current quadrature points
  const ADVariableGradient & _grad_u;
};

#endif /* ADDGKERNEL_H */
