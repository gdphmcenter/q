1. The pso-qnpso-dynamic.m file, test.m file and water.m file in the Main branch need to use the data collected by the real precision air-conditioner, which we can't provide due to the confidentiality of the data.
2. We have updated a master branch with a compare file, which mainly shows the simulation comparison of several optimization algorithms for control parameters optimization. (Path: https://github.com/gdphmcenter/QNPS-fuzzy/tree/master/compare)
(1) compare_opt_emulate.mkv is a screen-recording video shows the control simulation using qnpso optimization with the addition of a dynamically tuned optimization strategy, the pso-optimized control simulation, the GA-controlled optimization simulation, and the simulation without optimization algorithms.
(2) fuzzy.m is the fuzzy controller code that we designed.
(3) fuzzy_adjust.m is the optimization adjustment strategy based on the fuzzy control design.
(4) pso.m mainly shows the control simulation of the qnpso optimization algorithm without/with the optimization adjustment strategy, as well as the code for the pso optimization control simulation, GA control optimization simulation, and simulation without optimization algorithm. And in this code file incremental fuzzy control is designed on the basis of fuzzy.m.

