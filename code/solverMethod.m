%% load the sensing matrix A
A = load('D:\learn\CS591_CompressedSensing\project\data\A_200_200.mat');
%bgs = load();
%vocal_size = size(vocals);
%bgs_size = size(bgs);
%% merge them into a single A
%A = [vocals bgs];
%clear vocals bgs
%% load the testing audio matrix
test = load('D:\learn\CS591_CompressedSensing\project\data\truncated_test.mat');
test_sets = test.test.test_audio{1};
y = test_sets(:,1:size(test_sets,2)/2);
ori_x = test_sets(:,size(test_sets,2)/2+1:size(test_sets,2));
%% solve  it with time Series Solver (inverse)
predict_x = zeros(400,size(y,2));
for i = 1:size(y,2)
    predict_x(:,i) = timeSeriesSolver(A.A_200_200,y(:,i));
end
%% regenerating the original vocals

predict_vocals = zeros(size(y,1)*size(y,2),1);
for i = 1:size(y,2)
    predict_vocals(size(y,1)*(i-1)+1:size(y,1)*i,1) = A.A_200_200(:,1:200)*predict_x(1:200,i);
end