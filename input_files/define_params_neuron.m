%DEFINE_PARAMS_NEURON SpinDoctor input file.
%   This script defines the structures needed for a simulation by a driver:
%
%   params_cells: struct
%        Cell parameters. Can also contain parameters for specific cell types
%        (spheres, cylinders). Contains geometry parameters (whether to include
%        inner and ECS compartments); finite element mesh parameters.
%
%	params_domain: struct
%        Domain parameters. Contains PDE parameters (material properties)
%        defined for the domains "IN", "OUT", "ECS" and their boundaries
%
% 	experiment: struct
%   	Parameters for the experiments to be performed. It must also contain
%   	the field `sequences`, which is a cell array containing instances of
%   	`Sequence`. Available sequences are:
%        	PGSE(delta, Delta)
%       	DoublePGSE(delta, Delta)
%           CosOGSE(delta, Delta, nperiod)
%           SinOGSE(delta, Delta, nperiod)
%           CustomSequence(delta, Delta, @timeprofile)
%       In addition to the general experiment parameters, it may
%    	contain the fields
%       	btpde:      Solve Bloch-Torrey PDE with P1-FEM
%         	hadc:       Solve the equation for the homogenized apparent
%                       diffusion coefficient using P1-FEM
%        	mf:         Compute the matrix formalism signal
%        	multilayer: Compute analytical signal one multilayered sphere or
%                       cylinder using truncated radial matrix formalism
%    	The presence of any of these substructures triggers the corresponding
%     	experiment.



%% Mesh file
% filename = "mesh_files/spindle/whole_neurons/03a_spindle2aFI";
filename = "mesh_files/spindle/whole_neurons/03b_spindle4aACC";
% filename = "mesh_files/spindle/whole_neurons/03b_spindle7aACC";
% filename = "mesh_files/spindle/whole_neurons/04b_spindle3aFI";
% filename = "mesh_files/spindle/whole_neurons/06b_spindle8aACC";
% filename = "mesh_files/spindle/whole_neurons/16o_spindle13aFI";
% filename = "mesh_files/spindle/whole_neurons/16o_spindle13aFI.stl";
% filename = "mesh_files/spindle/separated_neurons/03a_spindle2aFI_soma";
% filename = "mesh_files/spindle/separated_neurons/03a_spindle2aFI_dendrites_1";
% filename = "mesh_files/spindle/separated_neurons/03a_spindle2aFI_dendrites_2";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle4aACC_dendrites_1";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle4aACC_dendrites_2";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle4aACC_soma";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle6aACC_dendrites_1";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle6aACC_dendrites_2";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle6aACC_soma";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle7aACC_dendrites_1";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle7aACC_dendrites_2";
% filename = "mesh_files/spindle/separated_neurons/03b_spindle7aACC_soma";
% filename = "mesh_files/spindle/separated_neurons/04b_spindle3aFI_dendrites_1";
% filename = "mesh_files/spindle/separated_neurons/04b_spindle3aFI_dendrites_2";
% filename = "mesh_files/spindle/separated_neurons/04b_spindle3aFI_soma";
% filename = "mesh_files/spindle/separated_neurons/19o_spindle14aFI_dendrites_2.stl";
% filename = "mesh_files/pyramidal/separated_neurons/02b_pyramidal1aACC_dendrites";
% filename = "mesh_files/pyramidal/separated_neurons/02b_pyramidal1aACC_soma";
% filename = "mesh_files/pyramidal/whole_neurons/02b_pyramidal1aACC";
% filename = "mesh_files/pyramidal/whole_neurons/02a_pyramidal2aFI";
% filename = "mesh_files/pyramidal/whole_neurons/04a_pyramidal4aACC";
% filename = "mesh_files/pyramidal/whole_neurons/04a_pyramidal5aACC";
% filename = "mesh_files/pyramidal/whole_neurons/04b_pyramidal6aACC";
% filename = "mesh_files/pyramidal/whole_neurons/04b_pyramidal6aFI";
% filename = "mesh_files/pyramidal/whole_neurons/25o_pyramidal18aFI";

%% Cell configuration parameters
params_cells.("filename") = filename;                   % File name to store cell description OR file to get neuron msh data
params_cells.("shape") = "neuron";                      % Cell shape; "sphere", "cylinder" or "neuron"
params_cells.("ncell") = 1;                             % Number of cells
% params_cells.("rmin") = 1;                            % Minimum radius
% params_cells.("rmax") = 4;                            % Maximum radius
% params_cells.("dmin") = 0.2;                          % Minimum distance between cells (times mean(rmin,rmax))
% params_cells.("dmax") = 0.3;                          % Maximum distance between cells (times mean(rmin,rmax))
% params_cells.("height") = 100;                        % Cylinder height
params_cells.("deformation") = [0; 0];                  % Domain deformation; [a_bend,a_twist]

%% Geometry parameters
params_cells.("include_in") = false;                    % Ratio Rin/R, within range [0,0.99]
params_cells.("in_ratio") = 0.7;                        % Ratio Rin/R, within range [0,0.99]
params_cells.("ecs_shape") = "tight_wrap";              % Shape of ECS: "no_ecs", "box", "convex_hull", or "tight_wrap".
params_cells.("ecs_ratio") = 0.2;                       % ECS gap; percentage in side length

%% Finite element mesh parameters (comment block to use default parameters)
% params_cells.("refinement") = 10;                     % Tetgen refinement parameter

%% PDE parameters
params_domain.("diffusivity_in") = 0.002;               % Diffusion coefficient IN
params_domain.("diffusivity_out") = 0.002;              % Diffusion coefficient OUT
params_domain.("diffusivity_ecs") = 0.002;              % Diffusion coefficient ECS
params_domain.("relaxation_in") = Inf;                  % T2-relaxation IN. No relaxation: Inf
params_domain.("relaxation_out") = Inf;                 % T2-relaxation OUT. No relaxation: Inf
params_domain.("relaxation_ecs") = Inf;                 % T2-relaxtion ECS. No relaxation: Inf
params_domain.("initial_density_in") = 1.0;             % Initial density in IN
params_domain.("initial_density_out") = 1.0;            % Initial density in OUT
params_domain.("initial_density_ecs") = 1.0;            % Initial density in ECS
params_domain.("permeability_in_out") = 1e-5;           % Permeability IN-OUT interface
params_domain.("permeability_out_ecs") = 1e-5;          % Permeability OUT-ECS interface
params_domain.("permeability_in") = 0;                  % Permeability IN boundary
params_domain.("permeability_out") = 0;                 % Permeability OUT boundary
params_domain.("permeability_ecs") = 0;                 % Permeability ECS boundary

%% General experiment parameters
experiment.("ndirection") = 1;                          % Number of gradient directions to simulate
experiment.("flat_dirs") = false;                       % Choose between 3d or 2d distributed gradient directions
experiment.("remove_opposite") = false;                 % Choose whether to not compute opposite directions
experiment.("direction") = [1.0; 1.0; 1.0];             % Gradient direction; [g1; g2; g3] (ignored if ndirection>1)
experiment.("values") = [50 100 500 1000 4000 10000];   % g-, q-, or b-values [1 x namplitude]
experiment.("values_type") = "b";                       % Type of values; "g", "q" or "b"
experiment.("sequences"){1} = PGSE(2500, 15000);        % Gradient sequences {1 x nsequence}
experiment.("sequences"){2} = PGSE(5000, 15000);        % Gradient sequences {1 x nsequence}

%% BTPDE experiment parameters (comment block to skip experiment)
experiment.("btpde").("ode_solver") = @ode15s;          % ODE solver for BTPDE
experiment.("btpde").("reltol") = 1e-4;                 % Relative tolerance for ODE solver
experiment.("btpde").("abstol") = 1e-6;                 % Absolute tolerance for ODE solver

%% HADC experiment parameters (comment block to skip experiment)
experiment.("hadc").("ode_solver") = @ode15s;           % ODE solver for HADC
experiment.("hadc").("reltol") = 1e-4;                  % Relative tolerance for ODE solver
experiment.("hadc").("abstol") = 1e-6;                  % Absolute tolerance for ODE solver

%% MF experiment parameters (comment block to skip experiment)
experiment.("mf").("length_scale") = 3;                 % Minimum length scale of eigenfunctions
experiment.("mf").("neig_max") = 250;                   % Requested number of eigenvalues
experiment.("mf").("ninterval") = 100;                  % Number of intervals to discretize time profile in MF (if not PGSE)

%% Multilayer experiment parameters (comment block to skip experiment)
% experiment.("multilayer").("length_scale") = 1;       % Minimum length scale of eigenfunctions
% experiment.("multilayer").("eigstep") = 1e-8;         % Minimum distance between eigenvalues

%% Custom time profile for magnetic field gradient pulse
% The function should be defined on the interval [0, Delta+delta].
% Here we manually define the PGSE sequence, as an example.
function f = timeprofile(t, delta, Delta)
f = (t < delta) - (Delta <= t);
end
