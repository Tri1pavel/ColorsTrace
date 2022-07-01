//
//  ColorCanvasHandler.h
//  CT
//
//  Created by Development on 01.07.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  An object that hold canvas for displaying selected color as rounded view by tap.
 *  Handle tap gesture to add UIView on canvas.
 *  Handle event when undo & redo stack of UIView's was changed.
 */
@interface ColorCanvasHandler: NSObject

/**
 *  Initialization for ColorsTraceHandler.
 *
 *  @param canvas UIView for adding selected color view by user's tap.
 *  @param wasChangedHandler This block will be invoked every time when undo & redo stack of UIView's was changed.
 */
- (id)initWithCanvas:(UIView *) canvas withWasChangedHandler:(void (^)(BOOL isUndoEnabled, BOOL isRedoEnabled)) wasChangedHandler;

/**
 *  Call this method to notify the handler that selected color was changed.
 */
- (void)colorWasChangedWith:(UIColor *)color;

/**
 *  Call this method to notify the handler that undo item bar button was tapped by user.
 */
- (void)undo;

/**
 *  Call this method to notify the handler that redo item bar button was tapped by user.
 */
- (void)redo;

@end
