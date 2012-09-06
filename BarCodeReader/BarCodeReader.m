//
//  BarCodeReader.m
//  BarCodeReader
//
//  Created by Jasveer Singh on 06/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BarCodeReader.h"
#import "Webpage.h"

@implementation BarCodeReader
@synthesize scannedImage;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Bar Code Reader";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//this method will start scanning and show scanned data
-(IBAction)scanButtonPressed:(id)sender{
    NSLog(@"Inside ScanButtonPressed");
    
    //Thios will open Iphone camera for scanning
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner; //for scanning of image
    
    //disabling rarely used I2/5 to improve performance
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    //present and release controler for scanning
    [self presentModalViewController:reader animated:YES];
    
    [reader release];
    NSLog(@"Outside ScanButtonPressed");
}

//This method will show image in imageview
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results) {
        break; // for grabbing the first barcode only
    }
    label.text = symbol.data; //Show scanned text on label
    
    scannedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage]; //show scanned image in imageView
    
    [picker dismissModalViewControllerAnimated:YES];
}

//this method will show scanned data in webview
-(IBAction)viewButtonPressed:(id)sender{
    NSLog(@"Inside ViewButtonPressed");
    
    if ([label.text hasPrefix:@"http://"]) {
        Webpage *webpage = [Webpage new];
        webpage.Url = label.text;
        [self.navigationController pushViewController:webpage animated:YES];
    }
    else{
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Invalid URL" message:@"Scanned URL is invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
    
    NSLog(@"Outside ViewButtonPressed");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
