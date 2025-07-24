function Cont = Contingency(Mem1, Mem2)
% CONTINGENCY Form contingency matrix for two vectors
% C = Contingency(Mem1, Mem2) returns contingency matrix for two
% column vectors Mem1, Mem2. These define which cluster each entity 
% has been assigned to.
%
% The matrix Cont(i,j) contains the number of elements assigned to 
% cluster i in Mem1 and cluster j in Mem2.

% Input validation
if nargin < 2 || numel(Mem1) ~= numel(Mem2)
    error('Contingency: Requires two vectors of equal length');
end

% Ensure Mem1 and Mem2 are column vectors
Mem1 = Mem1(:);
Mem2 = Mem2(:);

% Map cluster labels to contiguous indices
[~, Mem1_idx] = ismember(Mem1, unique(Mem1));
[~, Mem2_idx] = ismember(Mem2, unique(Mem2));

% Create the contingency matrix
Cont = zeros(max(Mem1_idx), max(Mem2_idx));

% Populate the contingency matrix
for i = 1:length(Mem1)
    Cont(Mem1_idx(i), Mem2_idx(i)) = Cont(Mem1_idx(i), Mem2_idx(i)) + 1;
end
end