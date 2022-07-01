//
//  ViewController.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "ColorsTraceViewController.h"
#import "ColorSelectionHandler.h"
#import "ColorCanvasHandler.h"

@interface ColorsTraceViewController ()
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorButtons;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *undoBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *redoBarButtonItem;
@property (strong, nonatomic) ColorSelectionHandler *colorSelectionHandler;
@property (strong, nonatomic) ColorCanvasHandler *colorCanvasHandler;
@end

@implementation ColorsTraceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateSelectedColorBarButtonItemByColor: nil];
            
    self.colorSelectionHandler = [[ColorSelectionHandler alloc] initWithColorButtons:self.colorButtons withColorWasChangedHandler:^(UIColor *color) {
        __weak typeof(self) weakSelf = self;
        [weakSelf updateSelectedColorBarButtonItemByColor: color];
        [weakSelf.colorCanvasHandler colorWasChangedWith: color];
    }];
    
    self.colorCanvasHandler = [[ColorCanvasHandler alloc] initWithCanvas:self.colorView withWasChangedHandler:^(BOOL isUndoEnabled, BOOL isRedoEnabled) {
        __weak typeof(self) weakSelf = self;
        [weakSelf.undoBarButtonItem setEnabled: isUndoEnabled];
        [weakSelf.redoBarButtonItem setEnabled: isRedoEnabled];
    }];
}

- (void)updateSelectedColorBarButtonItemByColor:(UIColor *) color {
    UIBarButtonItem *barButtonItem;
    
    if (color) {
        CGFloat size = 32.0;
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, size, size)];
        view.layer.cornerRadius = size * 0.5;
        view.backgroundColor = color;
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (IBAction)buttonWasTapped:(UIButton *)sender {
    [self.colorSelectionHandler colorWasChanged: sender];
}

- (IBAction)undoPressed:(UIBarButtonItem *)sender {
    [self.colorCanvasHandler undo];
}

- (IBAction)redoPressed:(UIBarButtonItem *)sender {
    [self.colorCanvasHandler redo];
}

@end
