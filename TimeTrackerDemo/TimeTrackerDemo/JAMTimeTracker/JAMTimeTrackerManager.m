//
//  JAMTimeTrackerManager.m
//  TimeTrackerDemo
//
//  Created by Piotr Jamróz on 27.09.2015.
//  Copyright © 2015 Piotr Jamróz. All rights reserved.
//

#import "JAMTimeTrackerManager.h"

#import "JAMTimeTrackerManager.h"

@interface JAMTimeTrackerManager()

@property (nonatomic, weak) NSTimer *currentTimer;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *stopTime;

@end

@implementation JAMTimeTrackerManager

#pragma mark - Private

- (void)startTimer {
    self.currentTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    self.startTime = [NSDate date];
}

- (void)stopTimer {
    self.stopTime = [NSDate date];
    [self.currentTimer invalidate];
}

- (void)countTime {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.startTime];
    self.elapsedTime = [self stringFromTimeInterval:timeInterval];
    [self.delegate tUpdate:self];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    
    double dti = interval;
    NSInteger deciseconds = (NSInteger) (dti * 100.0) % 100;
    
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    //NSInteger hours = (ti / 3600);
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)minutes, (long)seconds, (long)deciseconds];
}

@end
