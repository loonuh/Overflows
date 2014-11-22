%I have matrix something like A=[NAN 0.9 0.8 0.7; NAN NAN 0.7 0; NAN NAN NAN NAN] and
%I want to tell MATLAB that-
%For all columns in A- If column contains only NAN then return the index of 
%last NAN element, else find the maximum value from each column and return the value and index.
%Thus, ultimately I will have vectors like- value vector = 0.9,0.7,NA and index vector = 2, 3, 4 
%for this particular example. and
%I think I can try "if else" loop inside the for loop but I don't know how to do it. Can anyone help?
%Thanks in advance.

A=[NaN 0.9 0.8 0.7; NaN NaN 0.7 0; NaN NaN NaN NaN]';