function [nbErrors,score]=demo_graph_matching_SMAC();
%{
% Timothee Cour, 4 february 2009: fixed a bug which affected discretization in the case n1~=n2
% This software is made publicly for research use only.
% It may be modified and redistributed under the terms of the GNU General Public License.

nbTrials=100;
nbErrors=zeros(nbTrials,1);
for i=1:nbTrials
nbErrors(i)=demo_graph_matching_SMAC();
end
disp2('mean(nbErrors)');
%}

%% compute a synthetic graph matching example
n1=3;%n1 nodes in graph 1
n2=3;%n2=n1 nodes in graph 2
param.na=1;
param.ratio_fill=0.1;
noise.noise_self=5;%3
noise.noise_edges=0;
noise.noise_add=0;

% density_matches=0.1;
density_matches=0.2;
[W,E12,target,G1,G2]=computeSyntheticExampleMatching(n1,n2,param,noise,density_matches);

W

%target is ground truth matches


%% options for graph matching (discretization, normalization)
options.constraintMode='both'; %'both' for 1-1 graph matching
options.isAffine=1;% affine constraint
options.isOrth=1;%orthonormalization before discretization
options.normalization='iterative';%bistochastic kronecker normalization
% options.normalization='none'; %we can also see results without normalization
options.discretisation=@discretisationGradAssignment; %function for discretization
options.is_discretisation_on_original_W=0;

%put options.is_discretisation_on_original_W=1 if you want to discretize on original W 
%1: might be better for raw objective (based orig W), but should be worse for accuracy

%% graph matching computation
[X12,X_SMAC,timing]=compute_graph_matching_SMAC(W,E12,options);

%% results evaluation
if n1>n2
    dim=1;
else
    dim=2;
end
[ignore,target_ind]=max(target,[],dim);
[ignore,X12_ind]=max(X12,[],dim);
nbErrors=sum(X12_ind~=target_ind)/length(target_ind);

score=computeObjectiveValue(W,X12(E12>0));

%timing for SMAC (excluding discretization, which is not optimized)
% timing
% nbErrors

0;
