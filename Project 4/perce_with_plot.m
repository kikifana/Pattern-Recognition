function [w,iter,mis_clas,wrong_class]=perce_with_plot(X,y,w_ini,rho)
%from  function [w,iter,mis_clas]=perce(X,y,w_ini,rho)
[l,N]=size(X);
max_iter=200000; % Maximum allowable number of iterations
 
w=w_ini;        % Initilaization of the parameter vector
iter=0;            % Iteration counter
 
mis_clas=N;     % Number of misclassfied vectors

while(mis_clas>0)&&(iter<max_iter)
    iter=iter+1;
    mis_clas=0;
    
    gradi=zeros(l,1); % Computation of the "gradient" term
    err=0;   		% evaluates the error CC
    for i=1:N
        if((X(:,i)'*w)*y(i)<0)
            mis_clas=mis_clas+1;
            gradi=gradi+rho*(-y(i)*X(:,i));
            err=err+w'*(y(i)*X(:,i));  			%CC
        end
    end
    wrong_class(iter)=mis_clas;
    %err   %prints the values of error CC
    if(iter==1)
        fprintf('\n First Iteration: # Misclassified points = %g \n',mis_clas);        
    end
				
    
   
    w=w-rho*gradi; % Updating the parameter vector
end


end