locationcontroller
==================


This is a singleton implementation of the Location Controller. 

The class can be instantiated as follows:

    LocationController *mLC = [LocationController sharedLocationInterface];


To initialize the location do the following:
    [mLC startListeningForLocationUpdates];
    

To check latest location: 
    CLLocation *curr = [mLC getCurrentLocation];
    
