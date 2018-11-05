function lk = evaluator(inputStrings)

%% Runs the code made by connecting the strings given
lk=[];
 
 allStrings = ["","","","","","","","","","","","","","","","","","","",""];

    for n=1:length(inputStrings)
        allStrings(n) = inputStrings(n)
    end


allStrings

eval(strcat(allStrings(1),allStrings(2),allStrings(3)));

end

