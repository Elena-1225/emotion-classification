

%% accuracy
n=38
for ID=1:4
    filename=sprintf('sub_%d',ID)
    filename_xlsx=sprintf('sub_%d.xlsx',ID);
    %Folder=fullfile('/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/main_experiment_result/',filename,'/');
    Folder=fullfile('/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/guangeryuan/result');
    filename_final=fullfile(Folder,filename_xlsx);
    data=readmatrix(filename_final, 'Sheet', 'blockMat', 'Range', 'B2:K2');
    accuracy(ID)=mean(data);
end
%%
accuracy(7)  = accuracy(37);
accuracy(14) = accuracy(38);
accuracy([37 38]) = [];
n=36;
%%
n=4;
figure('Position', [100, 100, 900, 400]); 
set(gca, 'FontName', 'Arial', 'FontSize', 14, 'LineWidth', 1);

[sorted_accuracy, sort_idx] = sort(accuracy, 'descend');
subject_ids = sort_idx;
bar(1:n, sorted_accuracy);
set(gca, 'XTick', 1:length(accuracy), 'XTickLabel', sort_idx,'FontSize', 9);
set(gca, 'Box', 'off','XAxisLocation', 'bottom', 'YAxisLocation', 'left','TickLength', [0.004 0.004],'LineWidth', 1.2);  
xtickangle(0); 
hold on;
yline(mean(sorted_accuracy), 'k--', 'Mean Accuracy', 'LabelHorizontalAlignment', 'right', 'LineWidth', 1.2); 
yline(50, '--r', 'LabelHorizontalAlignment', 'right', 'LineWidth', 1.2);
% edges = [40,50, 60, 70,80];
% bin_labels = {'40-50%' ,'50-60%', '60-70%','70-80%'};
% [counts, ~, bins] = histcounts(accuracy, edges);
% 
% for i = 1:length(edges)-1
%     lower = edges(i);
%     upper = edges(i+1);
%     idx_in_range = find(sorted_accuracy >= lower & sorted_accuracy < upper);
%     x_start = idx_in_range(1);
%     x_end = idx_in_range(end);
%     y_bracket = 75 + 3 * (i - 1);  
%     plot([x_start, x_end], [y_bracket y_bracket], 'k', 'LineWidth', 1.5);
%     plot([x_start x_start], [y_bracket-1 y_bracket+1], 'k', 'LineWidth', 1.5);
%     plot([x_end x_end], [y_bracket-1 y_bracket+1], 'k', 'LineWidth', 1.5);
%     text((x_start + x_end)/2, y_bracket + 1.5, ...
%         sprintf('%s: %dÈË', bin_labels{i}, length(idx_in_range)), ...
%         'HorizontalAlignment', 'center', 'FontSize', 9);
% end
hold off;
ylim([0,100]);
xlabel('Subject ID', 'FontSize', 16);
ylabel('Accuracy(%)', 'FontSize', 16);
title('Operation Task Accuracy', 'FontSize', 18, 'FontWeight', 'bold');
%grid on;
%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/behavioral result/Accuracy.png');
%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/behavioral result/Accuracy1-4.png');

%% Reaction time
for ID=1:4
    filename=sprintf('sub_%d',ID)
    filename_xlsx=sprintf('sub_%d.xlsx',ID);
    %Folder=fullfile('/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/main_experiment_result/',filename,'/');
    Folder=fullfile('/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/guangeryuan/result');
    filename_final=fullfile(Folder,filename_xlsx);
    Iscorrect = readmatrix(filename_final,'Sheet', 'respMat','Range', 'B5:IG5');
    RT=readmatrix(filename_final,'Sheet', 'respMat','Range', 'B6:IG6');
    correct_idx=find(Iscorrect==1);
    false_idx=find(Iscorrect==0);
    RT_1(ID)=mean(RT(correct_idx));
    RT_0(ID)=mean(RT(false_idx));
end
%%
RT_1(7)  = RT_1(37);
RT_1(14) = RT_1(38);
RT_1([37 38]) = [];

RT_0(7)  = RT_0(37);
RT_0(14) = RT_0(38);
RT_0([37 38]) = [];

n=36;
%%
RT_mat = [RT_1(:),RT_0(:)];
%%
figure('Position', [100, 100,500, 500]); 
%figure;
bar(mean(RT_mat), 'FaceColor', [0.75 0.75 0.75],'EdgeColor', 'none','BarWidth', 0.6);
hold on;

for i = 1:size(RT_mat,1)
    plot(1:2, RT_mat(i,:), '-', 'Color', [0.5 0.5 0.5 0.5],'LineWidth', 1);  
    hold on;
    plot(1, RT_mat(i,1), 'o', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerEdgeColor', 'none'); 
    plot(2, RT_mat(i,2), 'o', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerEdgeColor', 'none'); 
end

sem = std(RT_mat) ./ sqrt(size(RT_mat,1));
errorbar(1:2, mean(RT_mat), sem, 'k.', 'LineWidth', 1.5);

set(gca, 'Box', 'off','XAxisLocation', 'bottom', 'YAxisLocation', 'left'); 
set(gca, 'FontName', 'Arial', 'FontSize', 16, 'LineWidth', 1); 
set(gca, 'XTick', [1 2], 'XTickLabel', {'Correct', 'Incorrect'});
ax=gca;
ax.XAxis.FontSize = 16;
ax.TickLength = [0.007 0.007];
ax.LineWidth=1.2; 
ylabel('Reaction Time (s)','FontSize', 16); 
ylim([3,9]); 
title('Read','FontSize', 18)

[~, p] = ttest(RT_1, RT_0);
if p < 0.01
    y_max = max(RT_mat(:)) + 0.7;
    plot([1 2], [y_max y_max], 'k-', 'LineWidth', 1.5);
    text(1.5, y_max+0.3, '**', 'HorizontalAlignment', 'center', 'FontSize', 16);
end
%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/behavioral result/RT comparsion.png');
%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/behavioral result/RT comparsion.png');

%% DL_new
clear DL;
clear thresh;
clear relative_DL;

for ID=1:7
    filename=sprintf('sub_%d',ID)
    filename_xlsx=sprintf('sub_%d.xlsx',ID);
    Folder=fullfile('Z:/zhujianan/operation task/EEG_new/main_experiment_result/',filename,'/');    
    filename_final=fullfile(Folder,filename_xlsx);
    DL(ID,:)=readmatrix(filename_final, 'Sheet', 'respMat', 'Range', 'B9:BUP9');
    DL(ID, isnan(DL(ID,:))) = 0;
    thresh(ID)=DL(ID,1);
    thresh_final(ID)=DL(ID,end);
    relative_DL(ID,:)=DL(ID,:)-thresh(ID);
end
%%
for ID=1:4
    filename=sprintf('sub_%d',ID)
    filename_xlsx=sprintf('sub_%d.xlsx',ID);
    %Folder=fullfile('/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/main_experiment_result/',filename,'/');
    Folder=fullfile('/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/guangeryuan/result');
    filename_final=fullfile(Folder,filename_xlsx);
    DL1(ID,:)=readmatrix(filename_final, 'Sheet', 'respMat', 'Range', 'B9:IG9');
    thresh(ID)=DL1(ID,1);
    thresh_final(ID)=DL1(ID,end);
    relative_DL1(ID,:)=DL1(ID,:)-thresh(ID);

end
%%
relative_DL1(7,:)  = relative_DL1(37,:);
relative_DL1(14,:) = relative_DL1(38,:);
relative_DL1([37 38], :) = []; 
%%
for trial = 1:240 
    mean_difficulty(trial) = mean(relative_DL1(:,trial));  
    se_difficulty(trial) = std(relative_DL1(:,trial)) / sqrt(36);  
end
%%
figure('Position', [100, 100, 800, 400]); 
set(gca, 'FontName', 'Arial', 'FontSize', 14, 'LineWidth', 1);
hold on;
x = 1:240;
fill([x, fliplr(x)], ...
     [mean_difficulty + se_difficulty, fliplr(mean_difficulty - se_difficulty)], ...
     [0.8 0.8 1], ...        
     'EdgeColor', 'none', ...
     'FaceAlpha', 0.5);     
plot(x, mean_difficulty, 'b-', 'LineWidth', 2);

set(gca, 'Box', 'off','XAxisLocation', 'bottom', 'YAxisLocation', 'left','TickLength', [0.004 0.004],'LineWidth', 1.2);  
xlim([0 240]);
title('Difficulty level variation','FontSize', 16);
xlabel('Trial','FontSize', 16);
ylabel('Difficulty level variation','FontSize', 16);

%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/behavioral result/DL variation.png');

%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/behavioral result/DL variation1-4.png');

%%
figure;
[sorted_thresh, sort_idx1] = sort(thresh, 'descend');

subject_ids = sort_idx1;
bar(1:n, sorted_thresh);
set(gca, 'XTick', 1:n, 'XTickLabel', sort_idx1);
yline(mean(sorted_thresh), 'k--', 'Mean thresh', 'LabelHorizontalAlignment', 'right', 'LineWidth', 1.5); 
xlabel('Subject ID');
ylabel('Thresh');
title('Operation Thresh');
grid on;
%%
saveas(gcf,'Z:/zhujianan/operation task/EEG_new/behavioral result/thresh sub1-7.png');

%%
 
thresh(7)  = thresh(37);
thresh(14) = thresh(38);
thresh([37 38]) = [];

thresh_final(7)  = thresh_final(37);
thresh_final(14) = thresh_final(38);
thresh_final([37 38]) = [];
%%
figure('Position', [100, 100, 900, 400]);
[sorted_thresh, sort_idx1] = sort(thresh, 'descend');
bar_data = [thresh(:), thresh_final(:)];

bar_data_sorted = bar_data(sort_idx1, :);
b = bar(bar_data_sorted, 'grouped');
b(1).FaceColor = [0.2 0.6 1];   
b(2).FaceColor = [1 0.4 0.4];   
n=36;
set(gca, 'FontSize', 10);
set(gca, 'XTick', 1:n, 'XTickLabel', sort_idx1);
set(gca, 'Box', 'off','XAxisLocation', 'bottom', 'YAxisLocation', 'left','TickLength', [0.004 0.004],'LineWidth', 1.2);  
xtickangle(0); 
legend({'Initial DL', 'Final DL'}, 'Location', 'northeast');
legend boxoff

yline(mean(bar_data_sorted(:,1)), '--', 'Mean initial DL', 'Color', [0.2 0.6 1], 'LineWidth', 1.2, 'HandleVisibility','off');
yline(mean(bar_data_sorted(:,2)), '--', 'Mean final DL', 'Color', [1 0.4 0.4], 'LineWidth', 1.2, 'HandleVisibility','off');

xlabel('Subject ID','FontSize', 16);
ylabel('Difficulty Level', 'FontSize', 16);
title('Initial vs. Final Difficulty Level', 'FontSize', 18);
%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/EEG_new/behavioral result/Initial vs. Final Difficulty Levels.png');

%%
saveas(gcf,'/home/zhujianan/Desktop/n2/zhujianan/operation task/SEEG/behavioral result/Initial vs. Final Difficulty Levels.png');

