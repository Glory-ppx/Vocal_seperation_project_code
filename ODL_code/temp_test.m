for i = 1:10
    if testmode == 1
        tic
    end
    %temp = OMP_others(D,stft_abs(:,i),sparsity);
    temp = OMP_others(D(:,colvocal+1:colvocal+colbg),stft_abs(:,i),sparsity);
    tempv = OMP_others(D(:,1:colvocal),stft_abs(:,i),sparsity);
    if testmode == 1
        diff(i,1) = sum(sum((D*temp-stft_abs(:,i)).^2,1),2);
        test_recover_record = [test_recover_record,temp];
    end
    temp_vocal = D(:,1:colvocal)*tempv;
    temp_inst = D(:,colvocal+1:colvocal+colbg)*temp;
    if mod(i,100) == 0
        i/col_s    
    end
    if testmode == 1
        toc
    end
end