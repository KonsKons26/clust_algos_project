% Probabilistic clustering algorithm test
load Salinas_Data
load preprocessed_X

X = zscore(X);

% smallest_m = 3;
% largest_m = 10;
% ms = smallest_m:largest_m;
% thresh = 0.5;
% seeds = 1:10;
% num_repeats = 10;
% 
% probabi_mean_Js = zeros(1, size(ms, 2));
% for iter = 1:size(ms, 2)
%     m = ms(iter);
%     J_values_for_m = zeros(1, num_repeats);
%     for repeat = 1:num_repeats
%         seed = seeds(repeat);
%         [mu, Sigma, P, gamma] = probabi(X, m, thresh, seed);
%         cost = probabi_cost(X, 
% mu, Sigma, P, gamma);
%         J_values_for_m(repeat) = cost;
%     end
%     probabi_mean_Js(iter) = mean(J_values_for_m);
%     fprintf("Iteration: %d, m=%d, cost=%f\n", iter, m, cost);
% end
% 
% figure;
% plot(ms, probabi_mean_Js, '-o', 'LineWidth', 2, ...
%     'MarkerSize', 6);
% xlabel('Number of Clusters (m)');
% ylabel('Cost Function (J)');
% ylim([0 300000]);
% title('Probabilistic clustering: m vs J (averaged over 10 runs)');
% grid on;


tic
    m = 8;
    thresh = 1e-10;
    seed = 42;
    [~, ~, ~, gamma] = probabi(X, m, thresh, seed);

    [~, cl_label] = max(gamma, [], 2);

    [p, n, ~] = size(Salinas_Image);

    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("\n\nprobabilistic clustering with %d clusters", m))

    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\nprobabilistic clustering with %d clusters\n", m);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc
