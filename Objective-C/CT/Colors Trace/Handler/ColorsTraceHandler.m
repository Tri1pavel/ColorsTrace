//
//  ColorsTraceHandler.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "ColorsTraceHandler.h"

@interface ColorsTraceHandler ()
@property (strong, nonatomic) UIView *canvas;
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

- (id)initWithCanvas:(UIView *) canvas withColorButtons:(NSArray *) colorButtons withColorWasChangedHandler:(void (^)(UIColor *color)) colorWasChangedHandler {
    self = [super init];
    if (self) {
        self.canvas = canvas;
        self.colorButtons = colorButtons;
        self.colorWasChanged = colorWasChangedHandler;
        
        [self addTapGestureRecognizerToCanvas];
    }
    return self;
}

- (void)addTapGestureRecognizerToCanvas {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(addView:)];
    [self.canvas addGestureRecognizer:tapGesture];
}

- (void)addView:(UITapGestureRecognizer *) gesture {
    if (self.selectedColor) {
        // Get location on canvas
        CGPoint location = [gesture locationInView:self.canvas];
        UIColor *color = self.selectedColor;
        // Add view at location on canvas with specific color
        [self addViewAt: location withColor: color];
    }
}

- (void)addViewAt:(CGPoint) location withColor:(UIColor *) color {
    CGFloat size = 50.0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(location.x - size * 0.5, location.y - size * 0.5, size, size)];
    view.backgroundColor = color;
    // Add rounded corners
    view.layer.cornerRadius = size * 0.5;
    view.clipsToBounds = true;
    // Add to canvas
    [self.canvas addSubview:view];
}

- (void)colorWasChanged:(UIButton *)sender {
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
