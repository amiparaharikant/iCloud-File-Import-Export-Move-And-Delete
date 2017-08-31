//
//  ViewController.m
//  iCloudeFileImportExport
//
//  Created by Nandlal on 31/08/17.
//  Copyright © 2017 Mahadev. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIDocumentPickerDelegate>
{
    NSURL *ubiquitousURL;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self saveFileAtLocalPath];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btImportData:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Import data from iCloud" message:@"choice is yours" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Import File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Import File button tappped.
        // Create the array of UTI Type that you want to support
        // Pass the array of UTI Type that application wants to support. Add more UTI Type if you want to support more other than listed
        
        // for "UTI types" import #import <MobileCoreServices/MobileCoreServices.h>
        NSArray *types = @[(__bridge NSString*)kUTTypeImage,(__bridge NSString*)kUTTypeSpreadsheet,(__bridge NSString*)kUTTypePresentation,(__bridge NSString*)kUTTypeFolder,(__bridge NSString*)kUTTypeZipArchive,(__bridge NSString*)kUTTypeVideo,(__bridge NSString*)kUTTypeText,(__bridge NSString *) kUTTypeContent, (__bridge NSString *) kUTTypePackage, @"com.apple.iwork.pages.pages", @"com.apple.iwork.numbers.numbers", @"com.apple.iwork.keynote.key", @"public.item"];
        
        //Create a object of document picker view and set the mode to Import
        UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
        
        //Set the delegate
        docPicker.delegate = self;
        //present the document picker
        [self presentViewController:docPicker animated:YES completion:nil];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)btExportData:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@" Export data to iCloud" message:@"choice is yours" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Export Single File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Export Single File button tappped.
        NSURL *filePathToUpload = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"testing" ofType:@"doc"]];
        
        //Create a object of document picker view and set the mode to Export
        UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithURL:filePathToUpload inMode:UIDocumentPickerModeExportToService];
        //Set the delegate
        docPicker.delegate = self;
        //present the document picker
        [self presentViewController:docPicker animated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Export MultiFile File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSMutableArray *item = [NSMutableArray arrayWithObjects:@"1.jpg", @"2.png", @"testing.doc", nil];
        
        for (int ii = 0; ii<item.count; ii++) {
            
            //fileName for upload which file
            NSString *fileName = [NSString stringWithFormat:@"%@",[item objectAtIndex:ii]];
            
            // File Name
            NSString *theFileName = [[fileName lastPathComponent] stringByDeletingPathExtension];
            
            //File Extanstion
            NSString *ext = [fileName pathExtension];
            
            //File PathURL
            NSURL *filePathToUpload = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:theFileName ofType:ext]];
            
            [self iCloudeUplodFile:filePathToUpload destFileNameStr:fileName];
        }
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)btMoveData:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Move data to iCloud" message:@"choice is yours" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Move Single File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Move Single File button tappped.
        NSURL *filePathToUpload = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"testing" ofType:@"doc"]]  ;
        //Create a object of document picker view and set the mode to Export
        UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithURL:filePathToUpload inMode:UIDocumentPickerModeMoveToService];
        //Set the delegate
        docPicker.delegate = self;
        //present the document picker
        [self presentViewController:docPicker animated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Move MultiFile File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSMutableArray *item = [NSMutableArray arrayWithObjects:@"1.jpg", @"2.png", @"testing.doc", nil];
        
        for (int ii = 0; ii<item.count; ii++) {
            
            //fileName for Move
            NSString *fileName = [NSString stringWithFormat:@"%@",[item objectAtIndex:ii]];
            
            // File Name
            NSString *theFileName = [[fileName lastPathComponent] stringByDeletingPathExtension];
            
            //File Extanstion
            NSString *ext = [fileName pathExtension];
            
            //File PathURL
            NSURL *filePathToUpload = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:theFileName ofType:ext]];
            
            [self iCloudeMoveFile:filePathToUpload destFileNameStr:fileName];
        }
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)btDeleteData:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Delete data from iCloud" message:@"choice is yours" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [self iCloudeDeleteFile:@"testing.doc"];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

//  Delegate called when user Import Export Data
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    if (controller.documentPickerMode == UIDocumentPickerModeImport)
    {
        // Condition called when user download the file
        NSData *fileData = [NSData dataWithContentsOfURL:url];
        // NSData of the content that was downloaded - Use this to upload on the server or save locally in directory
        
        //Showing alert for success
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *alertMessage = [NSString stringWithFormat:@"Successfully downloaded file %@", [url lastPathComponent]];
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"UIDocumentView"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        });
    }else  if (controller.documentPickerMode == UIDocumentPickerModeExportToService)
    {
        // Called when user uploaded the file - Display success alert
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *alertMessage = [NSString stringWithFormat:@"Successfully uploaded file %@", [url lastPathComponent]];
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"UIDocumentView"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        });
    }
}

//  Delegate called when user cancel the document picker
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

- (void)iCloudeDeleteFile:(NSString *)fileName
{
    ubiquitousURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    NSURL *destinationURL = [ubiquitousURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",fileName]];

    NSError *error;
    BOOL RSuc = [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:&error];
    
    if (RSuc)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"iCloudeDeleteFile" message:[NSString stringWithFormat:@"Delete from icloud : %@",fileName] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Okey" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (!RSuc || destinationURL == nil)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"iCloudeDeleteFile" message:[NSString stringWithFormat:@"%@ File not found at iColudDrive",fileName] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Okey" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)iCloudeUplodFile:(NSURL *)sourchPath destFileNameStr:(NSString *)fileName
{
    ubiquitousURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    //destinationURL use for upload file at iCloud ubiquitousURL Location to istant upload in iCloudDrive.com or iCloudApplication
    //here you can see file at localdirectory and iCloudeDrive
    NSURL *destinationURL = [ubiquitousURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",fileName]];
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:sourchPath toURL:destinationURL error:&error];
    if (success){
     NSLog(@"copied to icloud");
    }
}

- (void)iCloudeMoveFile:(NSURL *)sourchPath destFileNameStr:(NSString *)fileName
{
    ubiquitousURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    //destinationURL use for Move file at iCloud ubiquitousURL Location to istant Move in iCloudDrive.com or iCloudApplication from Localdirectory
    NSURL *destinationURL = [ubiquitousURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",fileName]];
    
    NSError *error;
    
    BOOL success = [[NSFileManager defaultManager] setUbiquitous:YES
                                        itemAtURL:sourchPath
                                   destinationURL:destinationURL
                                            error:&error];
    if (success){
        NSLog(@"copied to icloud");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
