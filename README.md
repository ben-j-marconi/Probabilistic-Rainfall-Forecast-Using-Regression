# Probabilistic-Rainfall-Forecast-Using-Regression
Calculated using Kaplan SST data for June, July August (JJA) from IRI.  The data is for the tropical Pacific domain from 30S to 30N and 120E to 60W

Acquiring the Data
Go to the IRI data library
http://iridl.ldeo.columbia.edu/SOURCES/.KAPLAN/.EXTENDED/.v2/.ssta/ 	

Click on “Expert Mode”
Add the following to select the region and time period:
  X (120E) (300E) RANGE
  Y (30S) (30N) RANGE
  T (Jan 1950) (Dec 2009) RANGE

Similarly to Lab 6, select months corresponding to JJA
  T 12 splitstreamgrid
  T (Jun) (Jul) (Aug) VALUES

And finally, compute the seasonal average
[T] average
