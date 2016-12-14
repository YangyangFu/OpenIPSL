within OpenIPSL.Electrical.Controls.PSSE.TG;
model TGOV1 "TGOV1 - Steam Turbine-Governor"
  extends BaseClasses.BaseGovernor;
  OpenIPSL.NonElectrical.Continuous.LeadLag imLeadLag(
    T1=T_2,
    T2=T_3,
    K=1,
    y_start=P0) annotation (Placement(transformation(extent={{80,-11},{100,10}})));
  parameter Real R "Governor gain, 1/R (pu)";
  parameter Real D_t "(pu)";
  parameter Real T_1 "Control time constant (s)";
  parameter Real T_2 "Control time constant (s)";
  parameter Real T_3 "Control time constant (s)";
  parameter Real V_MAX "Max. valve position (p.u. on M_b)";
  parameter Real V_MIN "min. valve position (p.u. on M_b)";
  Modelica.Blocks.Math.Gain imGain9(k=1/R) annotation (Placement(transformation(extent={{0,-10},
            {20,10}})));
  Modelica.Blocks.Math.Gain imGain1(k=D_t) annotation (Placement(transformation(extent={{40,-69},
            {60,-50}})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(extent={{-40,-11},
            {-20,10}})));
  Modelica.Blocks.Math.Add add1(k2=-1) annotation (Placement(transformation(extent={{180,-10},
            {200,10}})));
  Modelica.Blocks.Sources.Constant REF(k=P_REF) annotation (Placement(transformation(extent={{-140,40},
            {-120,60}})));
  NonElectrical.Continuous.SimpleLagLim simpleLagLim(
    K=1,
    T=T_1,
    y_start=P0,
    outMax=V_MAX,
    outMin=V_MIN) annotation (Placement(transformation(extent={{40,-9},{60,10}})));
protected
  parameter Real P0(fixed=false) "Power reference of the governor";
  parameter Real P_REF(fixed=false);
initial equation
  P0 = PMECH0;
  P_REF = P0*R;


equation
  connect(REF.y, add.u1) annotation (Line(points={{-119,50},{-60,50},{-60,5.8},{
          -42,5.8}},                                                    color={0,0,127}));
  connect(simpleLagLim.u, imGain9.y) annotation (Line(points={{38,0.5},{21,0.5},
          {21,0}},                                                                          color={0,0,127}));
  connect(add1.y, PMECH)
    annotation (Line(points={{201,0},{250,0},{250,0}}, color={0,0,127}));
  connect(simpleLagLim.y, imLeadLag.u) annotation (Line(points={{61,0.5},{69.5,0.5},
          {69.5,-0.5},{78,-0.5}}, color={0,0,127}));
  connect(add.y, imGain9.u) annotation (Line(points={{-19,-0.5},{-10.5,-0.5},{-10.5,
          0},{-2,0}}, color={0,0,127}));
  connect(imLeadLag.y, add1.u1) annotation (Line(points={{101,-0.5},{160,-0.5},{
          160,6},{178,6}}, color={0,0,127}));
  connect(imGain1.y, add1.u2) annotation (Line(points={{61,-59.5},{160,-59.5},{160,
          -6},{178,-6}}, color={0,0,127}));
  connect(SPEED, add.u2) annotation (Line(points={{-240,-120},{-150,-120},{-60,-120},
          {-60,-6.8},{-42,-6.8}}, color={0,0,127}));
  connect(imGain1.u, add.u2) annotation (Line(points={{38,-59.5},{-12,-59.5},{-12,
          -60},{-60,-60},{-60,-6.8},{-42,-6.8}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        extent={{-240,-200},{240,180}},
        preserveAspectRatio=false,
        grid={2,2},
        initialScale=0.1)),
    Icon(coordinateSystem(
        extent={{-240,-200},{240,180}},
        preserveAspectRatio=false,
        grid={2,2},
        initialScale=0.1),
                     graphics={
                              Text(
          extent={{-60,26},{58,-18}},
          lineColor={28,108,200},
          textString="TGOV1")}),
    Documentation(revisions="<html>
<!--DISCLAIMER-->
<p>OpenIPSL:</p>
<p>Copyright 2016 SmarTS Lab (Sweden)</p>
<ul>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>

<p></p>
<p>iPSL:</p>
<p>Copyright 2015-2016 RTE (France), SmarTS Lab (Sweden), AIA (Spain) and DTU (Denmark)</p>
<ul>
<li>RTE: <a href=\"http://www.rte-france.com\">http://www.rte-france.com</a></li>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
<li>AIA: <a href=\"http://www.aia.es/en/energy\"> http://www.aia.es/en/energy</a></li>
<li>DTU: <a href=\"http://www.dtu.dk/english\"> http://www.dtu.dk/english</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:info@itesla-ipsl.org\">info@itesla-ipsl.org</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>
</html>
"));
end TGOV1;
