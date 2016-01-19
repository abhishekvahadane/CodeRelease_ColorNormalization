README.TXT

HOW TO RUN THE DEMO: 

Run demo.m file to run the demo. Please note that the current implementation of our method is provided in exe file. Stay tuned to this webpage for future releases of this software supporting other platforms as well.

(1) The folder contains implementation of the Stain normalisation algorithm reported in the following publication.

Khan, A.M., Rajpoot, N., Treanor, D., Magee, D., A Non-Linear Mapping Approach to Stain Normalisation in Digital Histopathology Images using 
Image-Specific Colour Deconvolution, IEEE Transactions on Biomedical Engineering, 2014. 

For our method reported in TBME'2014, an executable file (along with all the supporting files). This technique can be executed using the following command-line format:

ColourNormalisation.exe BimodalDeconvRVM files.txt Refimg.jpg HE.colourmodel

Here files.txt is a text file which contains a list of source image names. Refimg.jpg is the name of the image that is used as reference for performing stain normalisation.

(2) The folder also provides a MATLAB implementation of 3 more stain normalisation algoirthms generally used in histological image analysis:

a. RGB Histogram Specification
b. Reinhard et al. method reported in E. Reinhard, M. Adhikhmin, B. Gooch, and P. Shirley, “Color transfer between images,” IEEE Computer Graphics and Applications, vol. 21(5), pp.
34–41, 2001.

c. Macenko et al. method reported in "A method for normalizing histology slides for quantitative analysis," M. Macenko et al., ISBI 2009

Also note that the folder contains G. Landini's implementation of Ruifork & Johnston's algorithm (in C). In order to run the demo, make sure you
have C comiler properly configured. 

(3) The software is provided 'as is' with no implied fitness for purpose. The author is exempted from any liability relating to the use of this 
software. 
 
(4) The software is provided for research use only. Clinical and commercial use is forbidden. 

(5) Please consider citing our following paper should you find the software useful for your purpose, 

Khan, A.M., Rajpoot, N., Treanor, D., Magee, D., A Non-Linear Mapping Approach to Stain Normalisation in Digital Histopathology Images using 
Image-Specific Colour Deconvolution, IEEE Transactions on Biomedical Engineering, 2014. 

(6) The software is explicitly not licenced for re-distribution (except via the websites of Leeds and Warwick Universities). 


In case of any comment/feedback, feel free to contact me at adnan.mujahid@gmail.com


