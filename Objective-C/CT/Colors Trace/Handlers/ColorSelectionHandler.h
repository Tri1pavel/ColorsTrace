//
//  ColorSelectionHandler.h
//  CT
//
//  Created by Development on 01.07.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  An object that track selected color.
 *  Handle event when selected color was changed.
 */
@interface ColorSelectionHandler: NSObject

/**
 *  Initialization for ColorsSelectionHandler.
 *
 *  @param colorButtons Array of UIButton, that holds color buttons for change selected color.
 *  @param colorWasChangedHandler This block will be invoked every time when color was changed by switching between color buttons.
 */
- (id)initWithColorButtons:(NSArray *) colorButtons withColorWasChangedHandler:(void (^)(UIColor *color)) colorWasChangedHandler;

/**
 *  Call this method to notify the handler that color button was tapped by user.
 */
- (void)colorWasChanged:(UIButton *)sender;

@end

