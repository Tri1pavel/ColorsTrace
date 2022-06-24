//
//  ColorsTraceHandler.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "ColorsTraceHandler.h"

@interface ColorsTraceHandler ()
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) NSArray *colorButtons;
@property (nonatomic, copy) void (^colorWasChanged)(UIColor *color);
@end

@implementation ColorsTraceHandler

// Override the setter for selectedColor property
// and execute the closure block colorWasChanged(UIColor *color)
- (void)setSelectedColor:(UIColor *)color {
    _selectedColor = color;
    self.colorWasChanged(color);
}

- (id) initWithColorButtons:(NSArray *) colorButtons withColorWasChangedHandler:(void (^)(UIColor *color)) colorWasChangedHandler {
    self = [super init];
    if (self) {
        self.colorButtons = colorButtons;
        self.colorWasChanged = colorWasChangedHandler;
    }
    return self;
}

- (void) colorWasChanged:(UIButton *)sender {
    if (sender.isSelected) {
        // Deselect button that previously was selected
        sender.selected = !sender.selected;
    } else {
        // Deselect all buttons
        for (id color in self.colorButtons) {
            [color setSelected:false];
        }
        // Select the button that was tapped
        sender.selected = !sender.selected;
    }
    
    self.selectedColor = sender.isSelected ? sender.backgroundColor : nil;
}

@end
