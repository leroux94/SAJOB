# coding=utf-8

import os
os.chdir( 'C:\SAJOB_TEST\Param_Gen' )         
execfile('C:\SAJOB_TEST\Param_Gen\Param_Gen.py')

os.chdir( 'C:\SAJOB_TEST\Collector' ) 
execfile("C:\SAJOB_TEST\Collector\Collector.py")

os.chdir( 'C:\SAJOB_TEST\Loader' ) 
execfile("C:\SAJOB_TEST\Loader\Loader.py")

#os.chdir( 'C:\SAJOB_TEST\Analyser' ) 
#execfile("C:\SAJOB_TEST\Analyser\Analyser.py")

#os.chdir( 'C:\SAJOB_TEST\Emailer' ) 
#execfile("C:\SAJOB_TEST\Emailer\Emailer.py")
