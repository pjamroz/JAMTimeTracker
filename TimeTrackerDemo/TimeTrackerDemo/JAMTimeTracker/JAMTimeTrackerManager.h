//
//  JAMTimeTrackerManager.h
//  TimeTrackerDemo
//
//  Created by Piotr Jamróz on 27.09.2015.
//  Copyright © 2015 Piotr Jamróz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@class JAMTimeTrackerManager;
@protocol TimerTrackerManager <NSObject>   // define delegate protocol
- (void)tUpdate:(JAMTimeTrackerManager *)sender; // method to update displayed elapsed time
@end

@interface JAMTimeTrackerManager : NSObject

- (void)startTimer;
- (void)stopTimer;

@property (nonatomic, weak) id <TimerTrackerManager> delegate;
@property (strong, nonatomic) NSString *elapsedTime; // current elapsed time since timer was started

@end
