//
//  ColorsTraceHandler.h
//  CT
//
//  Created by Development on 24.06.2022.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  An object that manages trace of selected color by switching between color buttons.
 *  Handle tap gesture to add *UIView* on canvas.
 *  Handle event when color was changed.
 *  Handle event when undo stack of *UIView* was changed.
 */
@interface ColorsTraceHandler: NSObject
/**
 *  Initialization for ColorsTraceHandler.
 *
 *  @param canvas UIView for adding selected color view by tap.
 *  @param colorButtons Array of UIButton, that holds color buttons for change selected color.
 *  @param colorWasChangedHandler This block will be invoked every time when color was changed by switching between color buttons.
 *  @param undoStackWasChangedHandler This block will be invoked every time when undo stack was changed.
 */
- (id)initWithCanvas:(UIView *) canvas withColorButtons:(NSArray *) colorButtons withColorWasChangedHandler:(void (^)(UIColor *color)) colorWasChangedHandler withUndoStackWasChangedHandler:(void (^)(BOOL isEnabled)) undoStackWasChangedHandler;
/**
 *  Call this method to notify the handler that color button was tapped by user.
 */
- (void)colorWasChanged:(UIButton *)sender;
/**
 *  Call this method to notify the handler that undo button was tapped by user.
 */
- (void)undo;
@end
