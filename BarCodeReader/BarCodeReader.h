//
//  BarCodeReader.h
//  BarCodeReader
//
//  Created by Jasveer Singh on 06/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarCodeReader : UIViewController <ZBarReaderDelegate>
@property (nonatomic, retain) IBOutlet UIImageView *scannedImage; // to show the scanned image
@property (nonatomic, retain) IBOutlet UILabel *label; //to show Scanned data
-(IBAction)scanButtonPressed:(id)sender; // this will start scanning
-(IBAction)viewButtonPressed:(id)sender; //this will show scanned data in webview
@end
