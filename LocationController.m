#import "LocationController.h"
NSString *const locationPermissionReceived =  @"ReceivedLocationPermission";
NSString *const locationPermissionDenied  = @"DeniedLocationPermission";

@implementation LocationController

#pragma mark Singleton Methods

+ (LocationController*)sharedLocationInterface {
    static LocationController *sharedLocationInterface = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationInterface = [[self alloc] init];
    });
    
    return sharedLocationInterface;
}

- (id)init {
    if (self = [super init])
    {
        if(![CLLocationManager locationServicesEnabled]) {
            return nil;
        }
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.currentLocation = [[CLLocation alloc]init];
    }
    return self;
}


-(void) startListeningForLocationUpdates
{
    [_locationManager startUpdatingLocation];
}

-(void) stopListeningForLocationUpdates
{
    [_locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
}

-(CLLocation*) getCurrentLocation
{
        return self.currentLocation;
}

-(BOOL) isLocationServiceEnabled{
    return [CLLocationManager locationServicesEnabled];
}

-(CLAuthorizationStatus)locationStatus
{
    return [CLLocationManager authorizationStatus];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            break;
            
        case kCLAuthorizationStatusRestricted:
            break;
            
        case kCLAuthorizationStatusDenied:
            [[NSNotificationCenter defaultCenter] postNotificationName:locationPermissionDenied object:nil userInfo:nil];
            break;
            
        case kCLAuthorizationStatusAuthorized:{
            [[NSNotificationCenter defaultCenter] postNotificationName:locationPermissionReceived object:nil userInfo:nil];
            break;
        }
            
        default:
            break;
    }
    
}

@end
