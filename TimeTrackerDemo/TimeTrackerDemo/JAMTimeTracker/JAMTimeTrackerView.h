//
//  JAMTimeTrackerView.h
//  TimeTrackerDemo
//
//  Created by Piotr Jamróz on 27.09.2015.
//  Copyright © 2015 Piotr Jamróz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JAMTimeTrackerView;
@protocol TimeTrackerView <NSObject>   // define delegate protocol
- (void)tStarted:(JAMTimeTrackerView *)sender;  // method to be called when timer is started
- (void)tStopped:(JAMTimeTrackerView *)sender; // method to be called when timer is stopped
@end

@interface JAMTimeTrackerView : UIView

@property (nonatomic) BOOL isTimerVisible; // NO if start button is added to main view
@property (nonatomic, weak) id <TimeTrackerView> delegate;

- (void)showStartButton; // show start button
- (void)showTimer; // show timer with stop button
- (void)updateElapsedTimeLabelWith:(NSString *)elapsedTime; // for updating uilabel text with current elapsed time

@end

