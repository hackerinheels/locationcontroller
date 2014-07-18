#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
FOUNDATION_EXPORT NSString *const locationPermissionReceived;
FOUNDATION_EXPORT NSString *const locationPermissionDenied;

@interface LocationController : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

// Access to the singleton object
+ (LocationController*)sharedLocationInterface;

- (CLLocation*) getCurrentLocation;

- (void) startListeningForLocationUpdates;
- (void) stopListeningForLocationUpdates;
- (BOOL) isLocationServiceEnabled;
- (CLAuthorizationStatus)locationStatus;
