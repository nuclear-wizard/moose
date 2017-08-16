/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/

#ifndef CIRCLECUTUSEROBJECT_H
#define CIRCLECUTUSEROBJECT_H

#include "GeometricCut3DUserObject.h"

// Forward declarations
class CircleCutUserObject;

template <>
InputParameters validParams<CircleCutUserObject>();

class CircleCutUserObject : public GeometricCut3DUserObject
{
public:
  CircleCutUserObject(const InputParameters & parameters);

  virtual void initialize() override{};
  virtual void execute() override{};
  virtual void finalize() override{};

protected:
  Point _centroid;
  Point _edge_point1;
  Point _edge_point2;

private:
  std::vector<Point> _vertices;
  Real _radius;
  Real _angle;

  virtual bool isInsideCutPlane(Point p) const override;
};

#endif // CIRCLECUTUSEROBJECT_H
