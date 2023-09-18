step 1 Download toolbox CORA(COntinuous Reachability Analyze) 
step 2 Replace the files "reachInner" and "reachInnerProjection" from toolbox CORA
step 3 open file "RS_nolinearsystem" and run the code

After you get the reachable set, you can compare the different state value in fault case with normal case in one figure by using file "plot_faultcase_and_normalcase".

File "Simulationresult" is state value results from simulink.Through the file "plot_statevalue_and__simulation" you can compare the state value results from CORA with the state value results from Simulink. 

In this algorithm, all inouts must be represented by the state values.