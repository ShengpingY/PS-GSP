# PS-GSP
This project is established to analyze the Glucose Seperation Process from Adamy's "Nonlinear Analysis", which is a three dimensional nonlinear system.
The code is also applicable for other higher dimension system which needs to be difined according to certain situation.

The code is made up of following parts：
1. model: contains simulink model and error analysis code
2. linear analysis: part for linear system anaylsis 
3. maximum ellipsodi: contains code for ellipsoid-polygon intersection
4. RS of nolinear system code: part for nonlinear analysis

Prerequisities:\
Other than basic tool box from matlab, you need to install toolbox CORA and CVX for analysis. Install tutorial for CVX is at following link: http://cvxr.com/cvx/doc/install.html. Github page for CORA: https://tumcps.github.io/CORA/

Tutorial for linear analysis:
1. define your own system in file model\nonLinear_Gsp, model\equilibrium, linear analysis\system_def according to different system dimensions and constraints
2. Choose different analysis mode: outerapproximation, innerapproximation and Ellipsoid-Polygon intersection in file linear analysis\system_def
3. run file linear analysis\runanalysis , according different input failure code will generate different numbers of analysis result, for further details please check the comments in the code

Tutorial for nonlinear analysis: RS of nolinear system code\check readme.txt

